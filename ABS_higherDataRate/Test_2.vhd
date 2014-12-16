library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Test_2 is
  port(
    clk, sense : in std_logic;
	 --sense : in std_logic;
	 absenable : out std_logic;
	 outhigh : out std_logic_vector (15 downto 0);
	 outlow : out std_logic_vector (15 downto 0);
	 outlive : out std_logic_vector (15 downto 0);
	 overflowlowout, overflowhighout : out std_logic;	 
	 oneorzero : out std_logic
	 );
end Test_2;

architecture behavior of Test_2 is
  signal countIntHigh : std_logic_vector(15 downto 0);
  signal countIntLow : std_logic_vector(15 downto 0);
begin
  --process (sense, clk)
  process (clk)
    variable lastHigh : integer := 0;
	 variable overflowlow, overflowhigh : integer := 0;
	 variable reset : boolean := false;
  begin
	 if (clk'event and clk = '1') then
	   if (sense = '1') then
		  if (lastHigh = 0) then
   		 oneorzero <= '1';
          outlow <= countIntLow;
		    overflowlow := 0;
		    overflowlowout <= '0';
		    --outhigh <= (others => '0');
		    lastHigh := 1;
  		    countIntLow <= (others => '0');			 
		  end if;
		  if overflowhigh = 0 then
	       countIntHigh <= countIntHigh + 1;		
		    if countIntHigh = "1111111111111110" then
		      overflowhighout <= '1';
			   overflowhigh := 1;
		      --outhigh <= countIntHigh;		
			 end if; 
		  end if;
		  outlive <= countIntHigh;
      elsif sense = '0' then
	     if (lastHigh = 1) then
          oneorzero <= '0';
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
		  if overflowlow = 0 then
	       countIntLow <= countIntLow + 1;		
		    if countIntLow = "1111111111111110" then
		      overflowlowout <= '1';
			   overflowlow := 1;
				--outlow <= countIntLow;
			 end if;
		  end if;
		  outlive <= countIntLow;
		end if;
	 end if;
  end process;
end behavior;
