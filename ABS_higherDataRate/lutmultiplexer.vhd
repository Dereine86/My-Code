library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity lutmultiplexer is
  port (
    clk : in std_logic;
    inport0, inport1, inport2, inport3: in std_logic_vector(15 downto 0);
    outport : out std_logic_vector(15 downto 0);
    selectport : out std_logic_vector(1 downto 0)
  );
end lutmultiplexer;

architecture lutmultiplexerbehavior of lutmultiplexer is
  signal muxCounter : std_logic_vector(1 downto 0) := "00";
  begin
    process (clk)
	 begin
	   if (rising_edge(clk)) then
		  if (muxCounter = "00") then
		    outport <= inport0;
          muxCounter <= muxCounter + 1;			 
		  elsif (muxCounter= "01") then
			 outport <= inport1;
	       muxCounter <= muxCounter + 1;  			 
		  elsif (muxCounter = "10") then
			 outport <= inport2;
          muxCounter <= muxCounter + 1;
		  elsif (muxCounter = "11") then
			 outport <= inport3;
			 muxCounter <= "00";
		  end if;
		  selectport <= muxCounter;
		end if;
	 end process;
end lutmultiplexerbehavior;

