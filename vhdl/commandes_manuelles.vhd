library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity commandes_manuelles is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif � 1
		i_CS				: in 	std_logic;	--signal de chip select actif � 0		
		i_switches			: in	std_logic_vector(9 downto 0);
		i_adresse			: in 	std_logic_vector(1 downto 0);
		o_DATA				: out	std_logic_vector(15 downto 0)

		);
end entity commandes_manuelles;

architecture synthese of commandes_manuelles is

signal registre_sortie : std_logic_vector(15 downto 0);

begin

--------------------------------------------------------------------------------------------------
--Acquisition des donn�es
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,i_CS,i_adresse,i_switches)
begin
	if i_reset='1' then
		
		registre_sortie		<= (others=>'0');

		
	else
		if i_clock'event and i_clock = '1'  then
			if i_CS='0' then
				registre_sortie <= "000000" & i_switches;
				--case i_adresse is 
				--	when "00" 	=> registre_sortie <= "000000" & i_switches;
				--	when "01" 	=> registre_sortie <= "00000000000000" & i_switches_menu;
				--	when others => registre_sortie <= (others=>'0');
				--end case;
			end if;
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Sortie
--------------------------------------------------------------------------------------------------
o_DATA<=registre_sortie;

end architecture synthese;