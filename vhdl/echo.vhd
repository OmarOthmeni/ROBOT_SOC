library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity echo is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif à 1
--		i_adresse			: in	std_logic_vector(1 downto 0); --adresse du registre concerné sur le périphérique
--		i_DATA				: in	std_logic_vector(15 downto 0);
--		i_CS				: in	std_logic; --signal de chip select, validant la lecture sur le bus de DATA
		i_echo				: in	std_logic; --signal renvoyé par le capteur à ultrason SRF05
		i_limit				: in	std_logic_vector(9 downto 0);
		o_DATA_echo			: out	std_logic_vector(15 downto 0)  --bus de données représentant l'écho du SRF05
		);
end entity echo;

architecture synthese of echo is

signal registre_start_CAPTEUR	:	std_logic_vector(15 downto 0);
signal echo						:	std_logic; --variable récupérant le signal du capteur
signal limit_ok					:	std_logic; --variable validant le signal echo ou non en fonctino de la limite imposée

signal cpt_DATA_echo 			:	std_logic_vector(15 downto 0);--compteur permettant de récupérer le signal écho
signal DATA_echo				:	std_logic_vector(15 downto 0);--compteur permettant de garder le signal écho précedent en mémoire
signal DATA_echo_cm				:	std_logic_vector(9 downto 0);--compteur permettant de garder le signal écho précedent en mémoire

begin

--------------------------------------------------------------------------------------------------
--transformation du signal echo en bus de données
--------------------------------------------------------------------------------------------------
process(i_clock,i_reset,registre_start_CAPTEUR,cpt_DATA_echo,echo)
begin
	if i_reset='1'  then --or registre_start_CAPTEUR(0)='0'
--initialisation des variables
		cpt_DATA_echo <="0000000000000000";	
	else
--génération de la donnée
		if i_clock'event and i_clock='1'then
			if i_echo='1' then
				cpt_DATA_echo <= cpt_DATA_echo + 1;	
			else
-- cpt_DATA_echo/="0000000000000001" then
				if cpt_DATA_echo /="0000000000000000" then
				DATA_echo <= cpt_DATA_echo;
				end if;
			--cpt_DATA_echo <="0000000000000001";
			end if;
		end if;
		
	
	end if;
	

end process;	
--------------------------------------------------------------------------------------------------
-- Mise en forme du bus de données																--
--------------------------------------------------------------------------------------------------
process(DATA_echo,i_limit,DATA_echo_cm,limit_ok)
begin
	DATA_echo_cm(0) <= DATA_echo(6);
	DATA_echo_cm(1) <= DATA_echo(7);
	DATA_echo_cm(2) <= DATA_echo(8);
	DATA_echo_cm(3) <= DATA_echo(9);
	DATA_echo_cm(4) <= DATA_echo(10);
	DATA_echo_cm(5) <= DATA_echo(11);
	DATA_echo_cm(6) <= DATA_echo(12);
	DATA_echo_cm(7) <= DATA_echo(13);
	DATA_echo_cm(8) <= DATA_echo(14);
	DATA_echo_cm(9) <= DATA_echo(15);
	if DATA_echo_cm > i_limit then
		limit_ok <='1';
	else
		limit_ok <='0';
	end if;
end process;
		
--------------------------------------------------------------------------------------------------
--Affectation de la sortie
--------------------------------------------------------------------------------------------------		

o_DATA_echo(0) <= DATA_echo_cm(0) ;
o_DATA_echo(1) <= DATA_echo_cm(1) ;
o_DATA_echo(2) <= DATA_echo_cm(2) ;
o_DATA_echo(3) <= DATA_echo_cm(3) ;
o_DATA_echo(4) <= DATA_echo_cm(4) ;
o_DATA_echo(5) <= DATA_echo_cm(5) ;
o_DATA_echo(6) <= DATA_echo_cm(6) ;
o_DATA_echo(7) <= DATA_echo_cm(7) ;
o_DATA_echo(8) <= DATA_echo_cm(8) ;
o_DATA_echo(9) <= DATA_echo_cm(9) ;
o_DATA_echo(10) <= '0' ;
o_DATA_echo(11) <= '0' ;
o_DATA_echo(12) <= '0' ;
o_DATA_echo(13) <= '0' ;
o_DATA_echo(14) <= '0' ;
o_DATA_echo(15) <= limit_ok ;



end architecture synthese;
	