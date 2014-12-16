-------------------------------------------------------------------------------
-- Entity to detect a blocking state using the incoming lut and the live value
-- of the rpmMeasure Entity
-- Johannes Scherle 2013
-- johannes.scherle@gmail.com
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all; -- For the conversion to std_logic_vector from integer.
use ieee.std_logic_unsigned.all; -- For the conversion from std_logic_vector to integer

use ieee.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use ieee.fixed_pkg.all; -- ieee_proposed for compatibility version

entity blockComparatorHR is
  port(
    clk : in std_logic;	 
	 oneorzero : in std_logic;
	 selectportin : in std_logic_vector(1 downto 0);
	 blockDetect : out std_logic;
	 inlive : in std_logic_vector (15 downto 0);
	 inlut : in std_logic_vector (15 downto 0)
	 );
end blockComparatorHR;

architecture blockComparatorHRBehavior of blockComparatorHR is
  signal oneorzero_syn : std_logic;
  signal oneorzero_last : std_logic;
  signal oneorzero_rising : std_logic; 
  signal edgeCounter : std_logic_vector (2 downto 0) := "000";
  signal blockOccured : boolean := false;
  signal inlutintern : std_logic_vector (15 downto 0);
  signal inlivehigh, inlivelow : std_logic_vector (31 downto 0);  
  -- Insert duty factors here.
  signal dutyFactorHigh : sfixed(15 downto -5) := "000000000000000011101"; -- equals 0.875 which should be 0.887
  signal dutyFactorLow : sfixed(15 downto -3)  := "0000000000000001001"; -- equals 1.125 which should be 1.14
begin
  BlockDetection : process (clk)
  constant maxEdges : natural := 2;
  begin
     if (clk'event and clk = '1') then
	   -- If the data on the bus is for me, store it in inlutintern.
	   if (selectportin = "01") then
		  inlutintern <= inlut;
		end if;
		
		-- If the sensor signal is high compare the count value normalised with
		-- the high duty factor to the value of the look-up-table
		if (oneorzero = '1') then
		  -- If the value is higher set the blocking state.
	     if (inlivehigh > inlutintern) then
		    blockOccured <= true;
		    blockDetect <= '1';
		  -- If we have reached enough edges in the blocked state check again and
		  -- possibly leave the blocking state.
		  elsif (edgeCounter = maxEdges and blockOccured = true) then		  
   	    if (inlivehigh < inlutintern) then
            blockOccured <= false;
		      blockDetect <= '0';
		    end if;
		  end if;
		  
		-- If the sensor signal is low, compare the count value normalised with
		-- the low duty factor to the value of the look-up-table  
		elsif (oneorzero = '0') then
	     if (inlivelow > inlutintern) then
		    blockOccured <= true;
		    blockDetect <= '1';
		  -- If we have reached enough edges in the blocked state check again and
		  -- possibly leave the blocking state. 
		  elsif (edgeCounter = maxEdges and blockOccured = true) then
		    if (inlivelow < inlutintern) then
            blockOccured <= false;
		      blockDetect <= '0';
		    end if;
		  end if;		  
		end if;
	 end if;
  end process BlockDetection;
  
  EdgeDetection : process (clk)
  constant maxEdges : natural := 2;
  begin
    if (rising_edge(clk)) then
	   oneorzero_syn <= oneorzero;
      oneorzero_last <= oneorzero_syn;
	   oneorzero_rising <= oneorzero_syn and not oneorzero_last;
		-- If there was an edge on the sensor signal and the wheel is blocked,
		-- start counting to the maxEdges Value.
      if (oneorzero_rising = '1') then
        if (blockOccured = true) then
	       if (edgeCounter = maxEdges) then
		      edgeCounter <= (others => '0');
          else
		      edgeCounter <= edgeCounter + 1;
		    end if;
	     elsif (blockOccured = false) then
		    edgeCounter <= (others => '0');
	    end if;
	  end if;
	  end if;
  end process EdgeDetection;
  
  DutyCycleNormal : process (clk)
    begin
	   -- Do the Duty Cycle Correction
	   if rising_edge(clk) then
        inlivehigh <= CONV_STD_LOGIC_VECTOR(to_integer(CONV_INTEGER(inlive) * dutyFactorHigh), 32);
        inlivelow <= CONV_STD_LOGIC_VECTOR(to_integer(CONV_INTEGER(inlive) * dutyFactorLow), 32);
	   end if;
  end process DutyCycleNormal;
  
end blockComparatorHRBehavior;


