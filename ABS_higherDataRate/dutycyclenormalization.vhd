library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all; -- For the conversion to std_logic_vector from integer.
use ieee.std_logic_unsigned.all; -- For the conversion from std_logic_vector to integer

use ieee.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use ieee.fixed_pkg.all; -- ieee_proposed for compatibility version

entity dutycyclenormalizationVR is
  port (
    inport: in std_logic_vector(15 downto 0);
    outport : out std_logic_vector(15 downto 0);
	 clk, selectportin : in std_logic;
	 selectportout : out std_logic
  );
end dutycyclenormalizationVR;

architecture dutycyclenormalizationVRbehavior of dutycyclenormalizationVR is
  -- Insert duty factors here.
  signal dutyFactorHigh : sfixed(15 downto -2) := "000000000000000011"; -- equals 0.75 which should be 0.75
  signal dutyFactorLow : sfixed(15 downto -1)  := "00000000000000011"; -- equals 1.5 which should be 1.499
  begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (selectportin = '0') then
        outport <= CONV_STD_LOGIC_VECTOR(to_integer(CONV_INTEGER(inport) * dutyFactorHigh), 32);
	   elsif (selectportin = '1') then
	     outport <= CONV_STD_LOGIC_VECTOR(to_integer(CONV_INTEGER(inport) * dutyFactorLow), 32);
      end if;
    selectportout <= selectportin;
    end if;
  end process;
end dutycyclenormalizationVRbehavior;

