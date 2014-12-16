library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clockdividerdebug is
  port (
    clockin : in std_logic;
	 clockout : out std_logic
  );
end clockdividerdebug;

architecture clockdividerdebugbehaviour of clockdividerdebug is
  constant divfactor : natural := 5;
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
end clockdividerdebugbehaviour;