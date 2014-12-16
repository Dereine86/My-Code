-- Quartus II VHDL Template
-- Single-Port ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity LUT is

	generic 
	(
		DATA_WIDTH : natural := 16;
		ADDR_WIDTH : natural := 14
	);

	port 
	(
		clk		: in std_logic;
		selectportin : in std_logic_vector(1 downto 0);
		selectportout : out std_logic_vector(1 downto 0);
		oldN	: std_logic_vector((ADDR_WIDTH -1) downto 0);
		maxN		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end entity;

architecture lutbehavior of LUT is

	-- Build a 2-D array type for the RoM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;
	
	-- This is the function to inialize the rom, meaning, writing the values of the lut.
	function init_lut
		return memory_t is 
		 constant ACC : real := 30.0;
       constant FREQ : real := 1000000.0;
       constant DELTAPHI : real := 0.5236;
       constant RADIUS : real := 0.045;
       constant A : real := -ACC / FREQ;
       constant B : real := DELTAPHI * RADIUS * FREQ;
       constant C : real := -B; 
		variable tmp : memory_t := (others => (others => '0'));
	begin 
		for i in 1 to 2**ADDR_WIDTH - 1 loop 
			-- Initialize each address with the address itself
			--tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, DATA_WIDTH));
			if integer((B / real(i)) ** 2 - real(4) * A * C) > 0 then
			  tmp(i) := std_logic_vector(to_unsigned(integer(((-B / real(i) + real(SQRT((B / real(i)) ** 2 - real(4) * A * C)))
                          /(real(2) * A)) + real(5000)), 16));
			else 
			  tmp(i) := "1111111111111111"; 
			end if;
		end loop;
		return tmp;
	end init_lut;	 

	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := init_lut;

begin

	process(clk)
	begin
	if(rising_edge(clk)) then
		maxN <= rom(to_integer(unsigned(oldN)));
		selectportout <= selectportin;
	end if;
	end process;

end lutbehavior;
