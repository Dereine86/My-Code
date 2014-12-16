-- COPYRIGHT 2012: Jan Burchard, Lehrstuhl fuer Rechnerarchitektur, Universitaet Freiburg
-- This file is only for the hardware labs "grand challenge" 2012!
-- It must not be uploaded, distributet or otherwise made available to any third party!

-- dataToSerial: transmits 3x8 bits via serial (9600 bauds)
-- usage: connect clock_50 to 50 mhz clock, and any data you want to transmit to a free data port
-- receive the data via "serialReceiver" on the arduino.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity dataToSerial is port(
	clk_50 : in std_logic;
	
	data1 : in std_logic_vector(7 downto 0);
	data2 : in std_logic_vector(7 downto 0);
	data_3 : in std_logic_vector(7 downto 0);
	data_4 : in std_logic_vector(7 downto 0);
	data_5 : in std_logic_vector(7 downto 0);
   data_6 : in std_logic_vector(7 downto 0);
	data_7 : in std_logic_vector(7 downto 0);
   data_8 : in std_logic_vector(7 downto 0);
   data_9 : in std_logic_vector(7 downto 0);	
   data_1_0 : in std_logic_vector(7 downto 0);	
   data_1_1 : in std_logic_vector(7 downto 0);	
   data_1_2 : in std_logic_vector(7 downto 0);	
   data_1_3 : in std_logic_vector(7 downto 0);	
   data_1_4 : in std_logic_vector(7 downto 0);
   data_1_5 : in std_logic_vector(7 downto 0);		
   data_1_6 : in std_logic_vector(7 downto 0);
   data_1_7 : in std_logic_vector(7 downto 0);		
   data_1_8 : in std_logic_vector(7 downto 0);		
   data_1_9 : in std_logic_vector(7 downto 0);		
   data_2_0 : in std_logic_vector(7 downto 0);		
	data_2_1 : in std_logic_vector(7 downto 0);
	data_2_2 : in std_logic_vector(7 downto 0);
   data_2_3 : in std_logic_vector(7 downto 0);
	data_2_4 : in std_logic_vector(7 downto 0);
	
	serial : out std_logic
);
end dataToSerial;


architecture behavior of dataToSerial is
	-- create the serial clk (9600 baud)
	signal serialClk : std_logic := '1';

	signal serialClkTimer : natural := 1;
	-- Old value for 9600 bps
	--constant serialCLkTime : natural := 2604;
	-- New value for 115200 bps. Higher data rate!
	constant serialCLkTime : natural := 217;
	-- For 19200 bps.
	--constant serialCLkTime : natural := 1302;
	
	
	-- internal state machine (which signal is sent):
	signal state : natural := 1;
	-- state:
	-- 0 : 'x'
	-- 1 : data1
	-- 2 : 'y'
	-- 3 : data2
	-- 4 : 'p'
	-- 5 : data3
	-- 6 : 'q'
	-- 7 : data4
	-- 8 : 'r'
	-- 9 : data5
	-- 10 : 's'
	-- 11 : data6
	-- 12 : 't'
	-- 13 : data7
	
	
	constant dataA : std_logic_vector(7 downto 0) := "01100001";
	constant dataB : std_logic_vector(7 downto 0) := "01100010";
	constant dataC : std_logic_vector(7 downto 0) := "01100011";
	constant dataD : std_logic_vector(7 downto 0) := "01100100";
	constant dataE : std_logic_vector(7 downto 0) := "01100101";
	constant dataF : std_logic_vector(7 downto 0) := "01100110";
	constant dataG : std_logic_vector(7 downto 0) := "01100111";
	constant dataH : std_logic_vector(7 downto 0) := "01101000";
	constant dataI : std_logic_vector(7 downto 0) := "01101001";
	constant dataJ : std_logic_vector(7 downto 0) := "01101010";
	constant dataK : std_logic_vector(7 downto 0) := "01101011";
	constant dataL : std_logic_vector(7 downto 0) := "01101100";
	constant dataM : std_logic_vector(7 downto 0) := "01101101";
	constant dataN : std_logic_vector(7 downto 0) := "01101110";
	constant dataO : std_logic_vector(7 downto 0) := "01101111";
	constant dataP : std_logic_vector(7 downto 0) := "01110000";
	constant dataQ : std_logic_vector(7 downto 0) := "01110001";
   constant dataR : std_logic_vector(7 downto 0) := "01110010";
	constant dataS : std_logic_vector(7 downto 0) := "01110011";
	constant dataT : std_logic_vector(7 downto 0) := "01110100";
	constant dataU : std_logic_vector(7 downto 0) := "01110101";
   constant dataV : std_logic_vector(7 downto 0) := "01110110";	
	constant dataW : std_logic_vector(7 downto 0) := "01110111";
   constant dataX : std_logic_vector(7 downto 0) := "01111000";	

	
	-- serial state machine:
	signal serialState : natural := 0;
	
	signal data1Intern : std_logic_vector(7 downto 0);
	signal data2Intern : std_logic_vector(7 downto 0);
	signal data3Intern : std_logic_vector(7 downto 0);
	signal data4Intern : std_logic_vector(7 downto 0);
	signal data5Intern : std_logic_vector(7 downto 0);
   signal data6Intern : std_logic_vector(7 downto 0);
	signal data7Intern : std_logic_vector(7 downto 0);
   signal data8Intern : std_logic_vector(7 downto 0);
   signal data9Intern : std_logic_vector(7 downto 0);	
   signal data10Intern : std_logic_vector(7 downto 0);	
   signal data11Intern : std_logic_vector(7 downto 0);	
   signal data12Intern : std_logic_vector(7 downto 0);	
   signal data13Intern : std_logic_vector(7 downto 0);	
   signal data14Intern : std_logic_vector(7 downto 0);
   signal data15Intern : std_logic_vector(7 downto 0);		
   signal data16Intern : std_logic_vector(7 downto 0);
   signal data17Intern : std_logic_vector(7 downto 0);		
   signal data18Intern : std_logic_vector(7 downto 0);		
   signal data19Intern : std_logic_vector(7 downto 0);		
   signal data20Intern : std_logic_vector(7 downto 0);		
	signal data21Intern : std_logic_vector(7 downto 0);
	signal data22Intern : std_logic_vector(7 downto 0);
   signal data23Intern : std_logic_vector(7 downto 0);
	signal data24Intern : std_logic_vector(7 downto 0);
	
	
begin
	process(clk_50)
	begin
		if rising_edge(clk_50) then
			serialClkTimer <= serialClkTimer + 1;
			
			if serialClkTimer = serialCLkTime then
				serialClk <= not serialClk;
				serialClkTimer <= 1;
			end if;
		end if;
	end process;

	-- create the serial signal
	process(serialClk)
	begin
		-- change the serial state
		if rising_edge(serialClk) then
			serialState <= serialState + 1;
			
			if serialState = 12 then
				if state = 47 then
					state <= 0;
				else
					state <= state + 1;
				end if;
				
				serialState <= 0;
			end if;
		end if;
	
		if falling_edge(serialClk) then
			-- start bit
			if serialState = 0 then
				serial <= '0';			
			-- data
			elsif serialState > 0 and serialState < 9 then
				if state = 0 then
					serial <= dataA(serialState - 1);
				elsif state = 1 then
				  if serialState = 1 then
				    data1Intern <= data1;
					 serial <= data1(serialState - 1);
				  end if;
					serial <= data1Intern(serialState - 1);
				elsif state = 2 then
					serial <= dataB(serialState - 1);
				elsif state = 3 then
				  if serialState = 1 then
				    data2Intern <= data2;
					 serial <= data2(serialState - 1);
				  end	if;			
					serial <= data2Intern(serialState - 1);
				elsif state = 4 then
					serial <= dataC(serialState - 1);
				elsif state = 5 then
				  if serialState = 1 then
				    data3Intern <= data_3;
					 serial <= data_3(serialState - 1);
				  end	if;			
					serial <= data3Intern(serialState - 1);
			   elsif state = 6 then
				   serial <= dataD(serialState - 1);
				elsif state = 7 then
				  if serialState = 1 then
				    data4Intern <= data_4;
					 serial <= data_4(serialState - 1);
				  end	if;			
				   serial <= data4Intern(serialState - 1);
				elsif state = 8 then
				   serial <= dataE(serialState - 1);
				elsif state = 9 then
				  if serialState = 1 then
				    data5Intern <= data_5;
					 serial <= data_5(serialState - 1);
				  end	if;			
				   serial <= data5Intern(serialState - 1);
				elsif state = 10 then
				   serial <= dataF(serialState - 1);
				elsif state = 11 then
				  if serialState = 1 then
				    data6Intern <= data_6;
					 serial <= data_6(serialState - 1);
				  end	if;			
				   serial <= data6Intern(serialState - 1);
				elsif state = 12 then
				   serial <= dataG(serialState - 1);
				elsif state = 13 then
				  if serialState = 1 then
				    data7Intern <= data_7;
					 serial <= data_7(serialState - 1);
				  end	if;			
				   serial <= data7Intern(serialState - 1);	
				elsif state = 14 then
				   serial <= dataH(serialState - 1);
				elsif state = 15 then
				  if serialState = 1 then
				    data8Intern <= data_8;
					 serial <= data_8(serialState - 1);
				  end	if;			
				   serial <= data8Intern(serialState - 1);
            elsif state = 16 then
				   serial <= dataI(serialState - 1);
				elsif state = 17 then
				  if serialState = 1 then
				    data9Intern <= data_9;
					 serial <= data_9(serialState - 1);
				  end	if;			
				   serial <= data9Intern(serialState - 1);					
				elsif state = 18 then
				   serial <= dataJ(serialState - 1);
				elsif state = 19 then
				  if serialState = 1 then
				    data10Intern <= data_1_0;
					 serial <= data_1_0(serialState - 1);
				  end	if;			
				   serial <= data10Intern(serialState - 1);
				elsif state = 20 then
				   serial <= dataK(serialState - 1);
				elsif state = 21 then
				  if serialState = 1 then
				    data11Intern <= data_1_1;
					 serial <= data_1_1(serialState - 1);
				  end	if;			
				   serial <= data11Intern(serialState - 1);
				elsif state = 22 then
				   serial <= dataL(serialState - 1);
				elsif state = 23 then
				  if serialState = 1 then
				    data12Intern <= data_1_2;
					 serial <= data_1_2(serialState - 1);
				  end	if;			
				   serial <= data12Intern(serialState - 1);				   
				elsif state = 24 then
				   serial <= dataM(serialState - 1);
				elsif state = 25 then
				  if serialState = 1 then
				    data13Intern <= data_1_3;
					 serial <= data_1_3(serialState - 1);
				  end	if;			
				   serial <= data13Intern(serialState - 1);
				elsif state = 26 then
				   serial <= dataN(serialState - 1);
				elsif state = 27 then
				  if serialState = 1 then
				    data14Intern <= data_1_4;
					 serial <= data_1_4(serialState - 1);
				  end	if;			
				   serial <= data14Intern(serialState - 1);				   
				elsif state = 28 then
				   serial <= dataO(serialState - 1);
				elsif state = 29 then
				  if serialState = 1 then
				    data15Intern <= data_1_5;
					 serial <= data_1_5(serialState - 1);
				  end	if;			
				   serial <= data15Intern(serialState - 1);				   
				elsif state = 30 then
				   serial <= dataP(serialState - 1);
				elsif state = 31 then
				  if serialState = 1 then
				    data16Intern <= data_1_6;
					 serial <= data_1_6(serialState - 1);
				  end	if;			
				   serial <= data16Intern(serialState - 1);				   
				elsif state = 32 then
				   serial <= dataQ(serialState - 1);
				elsif state = 33 then
				  if serialState = 1 then
				    data17Intern <= data_1_7;
					 serial <= data_1_7(serialState - 1);
				  end	if;			
				   serial <= data17Intern(serialState - 1);				   
				elsif state = 34 then
				   serial <= dataR(serialState - 1);
				elsif state = 35 then
				  if serialState = 1 then
				    data18Intern <= data_1_8;
					 serial <= data_1_8(serialState - 1);
				  end	if;			
				   serial <= data18Intern(serialState - 1);				   
				elsif state = 36 then
				   serial <= dataS(serialState - 1);
				elsif state = 37 then
				  if serialState = 1 then
				    data19Intern <= data_1_9;
					 serial <= data_1_9(serialState - 1);
				  end	if;			
				   serial <= data19Intern(serialState - 1);				   
				elsif state = 38 then
				   serial <= dataT(serialState - 1);
				elsif state = 39 then
				  if serialState = 1 then
				    data20Intern <= data_2_0;
					 serial <= data_2_0(serialState - 1);
				  end	if;			
				   serial <= data20Intern(serialState - 1);				   
				elsif state = 40 then
				   serial <= dataU(serialState - 1);
				elsif state = 41 then
				  if serialState = 1 then
				    data21Intern <= data_2_1;
					 serial <= data_2_1(serialState - 1);
				  end	if;			
				   serial <= data21Intern(serialState - 1);				   
				elsif state = 42 then
				   serial <= dataV(serialState - 1);
				elsif state = 43 then
				  if serialState = 1 then
				    data22Intern <= data_2_2;
					 serial <= data_2_2(serialState - 1);
				  end	if;			
				   serial <= data22Intern(serialState - 1);				   
				elsif state = 44 then
				   serial <= dataW(serialState - 1);
				elsif state = 45 then
				  if serialState = 1 then
				    data23Intern <= data_2_3;
					 serial <= data_2_3(serialState - 1);
				  end	if;			
				   serial <= data23Intern(serialState - 1);				   
				elsif state = 46 then
				   serial <= dataX(serialState - 1);
				elsif state = 47 then
				  if serialState = 1 then
				    data24Intern <= data_2_4;
					 serial <= data_2_4(serialState - 1);
				  end	if;			
				   serial <= data24Intern(serialState - 1);				   
				end if;
			
			-- stop bit
			elsif serialState > 8 then
				serial <= '1';
			end if;
		
		end if;
		
	end process;
	
end behavior;
