library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity downclock is

port(
		i_reset			: 	in		std_logic;
		i_clock_50M 	:	in 		std_logic;
		o_slow_clock	: 	out 	std_logic
	);

end entity downclock;

architecture synthese of downclock is

signal compteur	:	std_logic_vector(9 downto 0);

begin

process(i_clock_50M, i_reset)
begin
	if i_reset='1' then
		compteur <= "0000000001";
	else
		if i_clock_50M='1' and i_clock_50M'event then
			if (compteur<10) then
				compteur <= compteur+1;
				o_slow_clock<='0';
			else
				compteur <= "0000000001";
				o_slow_clock<='1';
			end if;
		end if;
	end if;
end process;

end architecture synthese;
			
		

