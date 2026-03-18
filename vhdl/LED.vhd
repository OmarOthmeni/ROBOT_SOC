library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LED is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif � 1
		i_CS				: in 	std_logic;	--signal de chip select actif � 0
		i_DATA				: in	std_logic_vector(15 downto 0);
		i_adresse			: in 	std_logic_vector(1 downto 0);
		o_led_rouges		: out	std_logic_vector(9 downto 0)
		);
end entity LED;

architecture synthese of LED is

signal registre_led_rouges : std_logic_vector(15 downto 0);

begin
--------------------------------------------------------------------------------------------------
--Acquisition des donn�es
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,i_CS,i_DATA)
begin
	if i_reset='1' then
		
		--registre_led_vertes		<= (others=>'0');
		registre_led_rouges		<= (others=>'0');
		
	else
		if i_clock'event and i_clock = '1'  then
			if i_CS='0' then
				registre_led_rouges <= i_DATA;
				--case i_adresse is 
					--when "00" => registre_led_vertes <= i_DATA;
				--	when "00" => registre_led_rouges <= i_DATA;
				--	when others => registre_led_rouges<=(others=>'0'); 
					
				--end case;
			end if;
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Sortie
--------------------------------------------------------------------------------------------------

o_led_rouges <= registre_led_rouges(9 downto 0);

end architecture synthese;