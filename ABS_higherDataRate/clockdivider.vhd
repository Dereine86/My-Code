library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clockdivider is
  port (
    clockin : in std_logic;
	 clockout : out std_logic
  );
end clockdivider;

architecture clockdividerbehaviour of clockdivider is
  constant divfactor : natural := 25;
  signal clockintern : std_logic := '0';  
  begin
  process(clockin)
    variable counter : natural := 0;
    begin
    if (rising_edge(clockin)) then
	   if (counter = divfactor) then
		  counter := 0;
		  clockintern <= not clockintern;
		end if;
		counter := counter + 1;
		clockout <= clockintern;
	 end if;
  end process;
end clockdividerbehaviour;