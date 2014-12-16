library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity breakControlRight is
  port(
    blockin, clk,absen, absenglobal, pwmin : in std_logic;	 
	 pwmout : out std_logic
	 );
end breakControlRight;

architecture breakControlRightBehavior of breakControlRight is
begin
  process (clk)
	 variable pwmCounter : natural := 0;
	 variable pwmCounterReset : boolean := false;
	 type state is (notblocked, blocked);
	 variable breakstate : state := notblocked;
	 variable nextstate : state := notblocked;
    constant RELEASEHIGHPHASE: natural := 1400;	 
  begin
	 if (clk'event and clk = '1') then
	  		
		-- If the wheel is blocked set a blocked flag, so that in the next
		-- pwm period the brakes are released.
	   if (blockin = '1') then
		  nextstate := blocked;
		elsif (blockin = '0') then
		  nextstate := notblocked;
		end if;
	 
	   -- Reset the pwmcounter if a new pwmperiod is detected. Furthermore set the state.
		if (pwmin = '1' and pwmCounterReset = false) then
		  pwmCounter := 0;
		  pwmCounterReset := true;
        breakstate := nextstate;		  
		elsif (pwmin = '0' and pwmCounterReset = true) then
		  pwmCounterReset := false;
		end if;

		
		-- Increment the pwmCounter
	   pwmCounter := pwmCounter + 1;
		
		-- If the wheel is blocked create a pwm signal that releases the brakes.
		-- If not, just pass on the input signal.
		if (breakstate = blocked and absen = '1' and absenglobal = '1') then
		  if (pwmCounter <= RELEASEHIGHPHASE) then
		    pwmout <= '1';
		  elsif (pwmCounter > RELEASEHIGHPHASE) then
		    pwmout <= '0';
		  end if;
	   elsif (breakstate = notblocked or absen = '0' or absenglobal = '0') then
	     pwmout <= pwmin;
      end if;
	 end if;
  end process;
end breakControlRightBehavior;
