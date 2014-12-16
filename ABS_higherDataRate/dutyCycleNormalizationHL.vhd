library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all; -- For the conversion to std_logic_vector from integer.
use ieee.std_logic_unsigned.all; -- For the conversion from std_logic_vector to integer

use ieee.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use ieee.fixed_pkg.all; -- ieee_proposed for compatibility version

entity dutyCycleNormalizationHL is
  port (
    inport: in std_logic_vector(15 downto 0);
    outport : out std_logic_vector(31 downto 0);
	 selectportin, clk : in std_logic;
	 selectportout : out std_logic
  );
end dutyCycleNormalizationHL;

architecture dutyCycleNormalizationHLBehavior of dutyCycleNormalizationHL is
  -- Insert duty factors here.
   signal dutyFactorLow : sfixed(15 downto -2) := "000000000000000101"; -- equals 1.25 which should be 1.25
   signal dutyFactorHigh : sfixed(15 downto -4)  := "00000000000000001101"; -- equals 0.8125 which should be 0.84

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
end dutyCycleNormalizationHLBehavior;