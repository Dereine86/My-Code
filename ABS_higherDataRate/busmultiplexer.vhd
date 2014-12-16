library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity busmultiplexer is
  port (
    inport0, inport1: in std_logic_vector(15 downto 0);
    outport : out std_logic_vector(15 downto 0);
	 selectportin : in std_logic;
	 selectportout : out std_logic
  );
end busmultiplexer;

architecture busmultiplexerbehavior of busmultiplexer is
  begin
  outport <= inport0 when selectportin = '0' else
             inport1 when selectportin = '1';
  selectportout <= selectportin;	 
end busmultiplexerbehavior;

