-- Copyright 2012: Jan Burchard, IRA Uni Freiburg
-- gSensorReader
-- reads data from ADXL345 via 3 wire SPI

-- pins on DE0-nano:
-- CS_N : G5
-- SDIO : F1 bi-directional!
-- SCLK : F2


-- notes about the SPI interface to the ADCL345:
-- 1) between transmissions, CS_N must be high for at least 150ns
-- 2) after CS_N is low, SCLK has to go down at least 5ns later
-- 3) when reading data from FIFO, wait 5µs to ensure FIFO is popped

library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity gSensorReader is port(

	clk_50 : in std_logic; -- 50mhz clock
	reset_n : in std_logic; -- reset signal (active low)

	-- SPI interface
	CS_N : out std_logic; -- chip select pin of the gSensor
	SCLK : out std_logic; -- spi clock
	SDIO : inout std_logic; -- spi data
		
	-- data output
	dataX : out std_logic_vector(15 downto 0);
	dataY : out std_logic_vector(15 downto 0);
	dataZ : out std_logic_vector(15 downto 0)
);
end gSensorReader;


architecture behavior of gSensorReader is
	-- define the internal state machine (used to initialize the chip and read the different channels)
	type state_type is (init0, init1, init2, init3, init4, readX, readY, readZ, pause);
	signal state : state_type := pause;
	signal nextState : state_type := init0;  -- the next state after a pause
	signal pauseCounter : natural;  -- used to wait for a defined amount of clocks after each transmission
	constant pauseDuration: natural := 250; -- 5000ns = 5µS
	constant init0pauseDuration : natural := 50000; -- 1ms (pause befor init0 is sent) 
	
	-- define the SPI state machine (24 states are needed for data tx/rx + additional state at the end)
	signal transmissionState : natural := 0;
	
	-- define the SPI clock divider
	constant clockDivider : natural := 25; -- 50mhz / (25*2) --> SCLK has 1 mhz
	signal clockDividerCounter : natural := 0;
	
	-- internal SPI signals:
	signal CS_Ninternal : std_logic := '1';
	signal SCLKinternal : std_logic := '0';
	
	-- internal dataStorage
	signal dataInternal : std_logic_vector(16 downto 0);
	
	-- define the transmission data for each state
	-- data format: 00, address: 110001 (0x31), selftest: off, 3 wire spi, interrupt mode, 0, full resoultion: on, justification: right with sign extension, range (2bit): +/-2g
	constant init0_data : std_logic_vector(15 downto 0) := "0011000101001000"; 
	-- active threshold: 00, address: 100100(0x24), 00000010 -- 125 mg
	constant init1_data : std_logic_vector(15 downto 0) := "0010010000000010";
	-- data rate:   00, address: 101100 (0x2C), 000, low power = 0, 1001 (50hz mode)
	constant init2_data : std_logic_vector(15 downto 0) := "0010110000001001";
	-- interrupt control: 00, address: 101110 (0x2E), 00010000 (only activity is set as trigger)
	constant init3_data : std_logic_vector(15 downto 0) := "0010111000010000";
	-- power mode:  00, address: 101101 (0x2D), 00, link: 0, auto_sleep = 0, measure = 1, sleep = 0, wakeup = 00
	constant init4_data : std_logic_vector(15 downto 0) := "0010110100001000";
	
	constant readX_data : std_logic_vector(7 downto 0) := "11110010";
	constant readY_data : std_logic_vector(7 downto 0) := "11110100";
	constant readZ_data : std_logic_vector(7 downto 0) := "11110110";
	
begin
	-- generate the SPI clock (SCLK)
	process(clk_50)
	begin
		if clk_50'event and clk_50 = '1' then
			clockDividerCounter <= clockDividerCounter + 1;
			
			if clockDividerCounter = clockDivider then
				clockDividerCounter <= 0;
				if SCLKinternal = '1' then
					SCLKinternal <= '0';
				else
					SCLKinternal <= '1';
				end if;
			end if;
		end if;			
	end process;

	-- internal state machine
	process(clk_50, reset_n)
	begin
		if clk_50'event and clk_50 = '1' then
			pauseCounter <= pauseCounter + 1;
		
			-- reset
			if reset_n = '0' then
				state <= init0;
			
			-- initialization states
			elsif state = init0 and transmissionState = 16 then
				state <= pause;
				nextState <= init1;
				pauseCounter <= 0;
			elsif state = init1 and transmissionState = 16 then
				state <= pause;
				nextState <= init2;
				pauseCounter <= 0;
			elsif state = init2 and transmissionState = 16 then
				state <= pause;
				nextState <= init3;
				pauseCounter <= 0;
			elsif state = init3 and transmissionState = 16 then
				state <= pause;
				nextState <= init4;
				pauseCounter <= 0;
			elsif state = init4 and transmissionState = 16 then
				state <= pause;
				nextState <= readX;
				pauseCounter <= 0;
			-- normal states
			elsif state = readX and transmissionState = 25 then
				state <= pause;
				nextState <= readY;
				pauseCounter <= 0;
			elsif state = readY and transmissionState = 25 then
				state <= pause;
				nextState <= readZ;
				pauseCounter <= 0;
			elsif state = readZ and transmissionState = 25 then
				state <= pause;
				nextState <= readX;
				pauseCounter <= 0;
			
				-- start state
			elsif state = pause and nextState = init0 then
				if pauseCounter = init0pauseDuration then
					state <= nextState;
				end if;
			-- pause state
			elsif state = pause and pauseCounter = pauseDuration then
				state <= nextState;
			end if;
		end if;	
	end process;
	
	
	-- chip enable signal
	process(SCLKinternal, reset_n)
	begin
		-- SCLK is high if CS_N is enabled
		if SCLKinternal'event and SCLKinternal = '1' then
			if reset_n = '0' or state = pause then
				CS_Ninternal <= '1'; -- disabled
			else
				CS_Ninternal <= '0'; -- enabled
			end if;
		end if;
	end process;

	-- data transfer
	process(SCLKinternal, state)
	begin		
		
		-- write data
		if SCLKinternal'event and SCLKinternal = '0' then
			-- reading the values: only write 8 bit (mode + address)
			if transmissionState < 8 and (state = readX or state = readY or state = readZ)then
				if state = readX then
					SDIO <= readX_data(7 - transmissionState);
				elsif state = readY then
					SDIO <= readY_data(7 - transmissionState);
				elsif state = readZ then
					SDIO <= readZ_data(7 - transmissionState);
				end if;
				
			-- writing the initial values: write 16 bit (mode + address + values)
			elsif transmissionState < 16 and state = init0 then
				SDIO <= init0_data(15 - transmissionState);
			elsif transmissionState < 16 and state = init1 then
				SDIO <= init1_data(15 - transmissionState);
			elsif transmissionState < 16 and state = init2 then
				SDIO <= init2_data(15 - transmissionState);
			elsif transmissionState < 16 and state = init3 then
				SDIO <= init3_data(15 - transmissionState);
			elsif transmissionState < 16 and state = init4 then
				SDIO <= init4_data(15 - transmissionState);
				
			else
				SDIO <= 'Z';
			end if;
		end if;
		
		-- read data and update transmissionState counter
		if SCLKinternal'event and SCLKinternal = '1' then
			-- reset the transmissionState counter if state is pause
			if state = pause or CS_Ninternal = '1' then
				transmissionState <= 0;
			else
				-- note: this transaction is executed after the process is over! This means: If the 9th bit (counting starts at bit 0)
				--	of the transmission is read, the transmission counter is still at value 8
				transmissionState <= transmissionState + 1;
				
				-- read phase of transmission -> lower bits: bit 8 to 15 of transmission
				if transmissionState > 7 and transmissionState < 16 then -- transmission state between 8 and 15, stored in dataInternal[7..0]
					dataInternal(15 - transmissionState) <= SDIO;
				-- higher bits: bit 16 to 23 of transmission
				elsif transmissionState > 15 and transmissionState < 24 then -- transmission state between 16 and 23, stored in dataInternal[15..8]
					dataInternal(23 + 8 - transmissionState) <= SDIO;
					
				-- transmission finished, bit 24 was read, transmission counter will jump to 24 at end of process.
				elsif transmissionState = 24 then
					if state = readX then
						dataX <= dataInternal(15 downto 0);
					elsif state = readY then
						dataY <= dataInternal(15 downto 0);
					elsif state = readZ then
						dataZ <= dataInternal(15 downto 0);
					end if;
				end if;
			end if;
		end if;
	end process;
	
	
	-- connect internal signals to outputs:
	SCLK <= SCLKinternal when CS_Ninternal = '0' else '1';
	CS_N <= CS_Ninternal;
end behavior;