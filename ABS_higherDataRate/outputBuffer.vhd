-- Altera devices contain tri-state buffers in the I/O.  Thus, a tri-state
-- buffer must feed a top-level I/O in the final design.  Otherwise, the
-- Quartus II software will convert the tri-state buffer into logic.
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity outputBuffer is
  port (
    input, outputenable : in std_logic;
	 output : out std_logic
  );
end outputBuffer;

architecture outputBufferbehavior of outputBuffer is
begin
  output <= input when (outputenable = '1') else '1';
end outputBufferbehavior;



