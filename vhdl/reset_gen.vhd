library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reset_gen is
	port(
		i_clock		: in 	std_logic;	--signal d'horloge
		o_reset		: out	std_logic --signal de reset actif à 1
		);
end entity reset_gen;

architecture RTL of reset_gen is

signal cpt_reset  	: std_logic_vector(7 downto 0):="00000000";
signal reset	 	: std_logic;
begin

process(i_clock,cpt_reset)
begin
	if i_clock'event and i_clock = '1'  then

		if cpt_reset < 200 then
			cpt_reset <= cpt_reset + 1;
			reset <= '1';
		else 
			reset <= '0';
		end if;
	end if;
end process;

o_reset<=reset;


end architecture RTL;