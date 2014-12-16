-------------------------------------------------------------------------------
-- Entity to measure the lengths of sensor periods
-- Johannes Scherle 2013
-- johannes.scherle@gmail.com
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity rpmMeasure is
  port(
    clk, sense : in std_logic;
	 absenable : out std_logic;
	 outhigh : out std_logic_vector (15 downto 0);
	 outlow : out std_logic_vector (15 downto 0);
	 outlive : out std_logic_vector (15 downto 0);
	 overflowlowout, overflowhighout : out std_logic;	 
	 oneorzero : out std_logic
	 );
end rpmMeasure;

architecture rpmMeasureBehavior of rpmMeasure is
  signal countIntHigh : std_logic_vector(15 downto 0);
  signal countIntLow : std_logic_vector(15 downto 0);
begin
  process (clk)
    variable lastHigh : integer := 0;
	 variable overflowlow, overflowhigh : integer := 0;
	 variable reset : boolean := false;
  begin
	 if (clk'event and clk = '1') then
	   -- If the sensor input is high.
	   if (sense = '1') then
		  -- If there has been a change from low to high, set the output to high
		  -- write the countervalue of the last low period to the output, clear
		  -- the overflowflag and reset the intern low counter.
		  if (lastHigh = 0) then
   		 oneorzero <= '1';
          outlow <= countIntLow;
		    overflowlow := 0;
		    overflowlowout <= '0';
		    lastHigh := 1;
  		    countIntLow <= (others => '0');			 
		  end if;
		  -- If there is no overflow of the intern high counter increment it
		  -- If the next increment would cause an overflow set the overflow flag
		  -- and the overflow-output.
		  if overflowhigh = 0 then
	       countIntHigh <= countIntHigh + 1;		
		    if countIntHigh = "1111111111111110" then
		      overflowhighout <= '1';
			   overflowhigh := 1;
			 end if; 
		  -- If the overflowflag is set, write the intern high counter to the output.
		  elsif overflowhigh = 1 then
          outhigh <= countIntHigh;
		  end if;
		  -- Write the intern high counter value to the live output.
		  outlive <= countIntHigh;
		  
	   -- If the sensor input is low.
      elsif sense = '0' then
		  -- If there has been a change from high to low, set the output to low,
		  -- write the countervalue of the last high period to the output, clear
		  -- the overflowflag and reset the intern high counter.		  
	     if (lastHigh = 1) then
          oneorzero <= '0';
			 -- If the length of the last high sensor period is higher than 2^14 - 2
			 -- disable the ABS.
		    if countIntHigh > "0011111111111110" then
			   absenable <= '0';
			 else
			   absenable <= '1';
			 end if;		
		    outhigh <= countIntHigh;			
          lastHigh := 0;
			 overflowhigh := 0;
			 overflowhighout <= '0';
 		    countIntHigh <= (others => '0');
		  end if;		  
		  -- If there is no overflow of the intern low counter increment it.
		  -- If the next increment would cause an overflow set the overflow flag
		  -- and the overflow-output.		  
		  if overflowlow = 0 then
	       countIntLow <= countIntLow + 1;
		    if countIntLow = "1111111111111110" then
		      overflowlowout <= '1';
			   overflowlow := 1;				
			 end if;
		  -- If the overflowflag is set, write the intern high counter to the output.			 
		  elsif overflowlow = 1 then
          outlow <= countIntLow;
		  -- Write the intern low counter value to the live output.
		  end if;
		  outlive <= countIntLow;
		end if;
	 end if;
  end process;
end rpmMeasureBehavior;
