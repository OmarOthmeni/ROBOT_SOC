library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity capteurs_robot is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif à 1
		i_CS				: in 	std_logic;	--signal de chip select actif à 0
		i_R_W				: in	std_logic;
		i_DATA				: in	std_logic_vector(15 downto 0);
		i_adresse			: in 	std_logic_vector(1 downto 0);
		i_joystick			: in	std_logic_vector(4 downto 0);
		i_capteurs			: in	std_logic_vector(2 downto 0);		
		o_emission_droite	: out	std_logic;
		o_emission_gauche	: out	std_logic;
		o_DATA_proxi		: out	std_logic_vector(15 downto 0)
		);
end entity capteurs_robot;

architecture synthese of capteurs_robot is

signal registre_emeteur	: std_logic_vector(15 downto 0);
signal DATA_proxi		: std_logic_vector(15 downto 0);

begin

--------------------------------------------------------------------------------------------------
--Acquisition des données
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,i_DATA,i_CS,i_adresse,i_capteurs,i_joystick)
begin
	if i_reset='1' then
		registre_emeteur			<= (others=>'0');
		DATA_proxi					<= (others=>'0');
	else
		if i_clock'event and i_clock = '1'  then
			if i_CS='0' then
				case i_adresse is
					
					when "00" 	=> DATA_proxi <= "0000000000000" & i_capteurs;
					when "01" 	=> DATA_proxi <= "00000000000" & NOT(i_joystick);
					when "10" 	=> registre_emeteur <= i_DATA;
					when others => registre_emeteur <= i_DATA;
					
				end case;	
			end if;
		end if;
	end if;

end process;

--------------------------------------------------------------------------------------------------
--Sortie
--------------------------------------------------------------------------------------------------


o_emission_droite <= registre_emeteur(0);
o_emission_gauche <= registre_emeteur(1);

o_DATA_proxi<=DATA_proxi;

end architecture synthese;