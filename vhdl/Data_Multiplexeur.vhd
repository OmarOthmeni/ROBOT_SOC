library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Data_Multiplexeur is

port(
		i_R_W				: in	std_logic;
		i_DATA_com_man		: in 	std_logic_vector(15 downto 0); --entrée commandes manuelles carte Altera		
		i_DATA_capteurs		: in 	std_logic_vector(15 downto 0); --entrée des capteurs robot par le GPIO1
		i_DATA_echo_centre	: in	std_logic_vector(15 downto 0); --entrée capteurs SRF05 (ultrason) par le GPIO1
		i_DATA_echo_gauche	: in	std_logic_vector(15 downto 0); --entrée capteurs SRF05 (ultrason) par le GPIO1
		i_DATA_echo_droite	: in	std_logic_vector(15 downto 0); --entrée capteurs SRF05 (ultrason) par le GPIO1
		i_CS2				: in	std_logic; --signal de chip select de la zone capteurs, validant l'écriture sur le bus de DATA
		i_CS3				: in	std_logic; --signal de chip select de la zone "switch'n push buttons", validant l'écriture sur le bus de DATA
		i_CS5				: in	std_logic; --signal de chip select de la zone ultrason, validant l'écriture sur le bus DATA
		i_CS6				: in	std_logic; --signal de chip select de la zone ultrason, validant l'écriture sur le bus DATA
		i_CS7				: in	std_logic; --signal de chip select de la zone ultrason, validant l'écriture sur le bus DATA
		o_DATA				: out	std_logic_vector(15 downto 0)--bus de données sortantes
		);
end entity Data_Multiplexeur;

architecture synthese of Data_Multiplexeur is

begin

--------------------------------------------------------------------------------------------------
--Sortie des données
--------------------------------------------------------------------------------------------------
--o_DATA(0)<=i_R_W AND ((i_DATA_com_man(0) AND NOT(i_CS3)) OR (i_DATA_capteurs(0) AND NOT(i_CS2)) OR (i_DATA_echo(0) AND NOT(i_CS5)));
--o_DATA(1)<=i_R_W AND ((i_DATA_com_man(1) AND NOT(i_CS3)) OR (i_DATA_capteurs(1) AND NOT(i_CS2)) OR (i_DATA_echo(1) AND NOT(i_CS5)));
--o_DATA(2)<=i_R_W AND ((i_DATA_com_man(2) AND NOT(i_CS3)) OR (i_DATA_capteurs(2) AND NOT(i_CS2)) OR (i_DATA_echo(2) AND NOT(i_CS5)));
--o_DATA(3)<=i_R_W AND ((i_DATA_com_man(3) AND NOT(i_CS3)) OR (i_DATA_capteurs(3) AND NOT(i_CS2)) OR (i_DATA_echo(3) AND NOT(i_CS5)));
--o_DATA(4)<=i_R_W AND ((i_DATA_com_man(4) AND NOT(i_CS3)) OR (i_DATA_capteurs(4) AND NOT(i_CS2)) OR (i_DATA_echo(4) AND NOT(i_CS5)));
--o_DATA(5)<=i_R_W AND ((i_DATA_com_man(5) AND NOT(i_CS3)) OR (i_DATA_capteurs(5) AND NOT(i_CS2)) OR (i_DATA_echo(5) AND NOT(i_CS5)));
--o_DATA(6)<=i_R_W AND ((i_DATA_com_man(6) AND NOT(i_CS3)) OR (i_DATA_capteurs(6) AND NOT(i_CS2)) OR (i_DATA_echo(6) AND NOT(i_CS5)));
--o_DATA(7)<=i_R_W AND ((i_DATA_com_man(7) AND NOT(i_CS3)) OR (i_DATA_capteurs(7) AND NOT(i_CS2)) OR (i_DATA_echo(7) AND NOT(i_CS5)));
--o_DATA(8)<=i_R_W AND ((i_DATA_com_man(8) AND NOT(i_CS3)) OR (i_DATA_capteurs(8) AND NOT(i_CS2)) OR (i_DATA_echo(8) AND NOT(i_CS5)));
--o_DATA(9)<=i_R_W AND ((i_DATA_com_man(9) AND NOT(i_CS3)) OR (i_DATA_capteurs(9) AND NOT(i_CS2)) OR (i_DATA_echo(9) AND NOT(i_CS5)));
--o_DATA(10)<=i_R_W AND ((i_DATA_com_man(10) AND NOT(i_CS3)) OR (i_DATA_capteurs(10) AND NOT(i_CS2)) OR (i_DATA_echo(10) AND NOT(i_CS5)));
--o_DATA(11)<=i_R_W AND ((i_DATA_com_man(11) AND NOT(i_CS3)) OR (i_DATA_capteurs(11) AND NOT(i_CS2)) OR (i_DATA_echo(11) AND NOT(i_CS5)));
--o_DATA(12)<=i_R_W AND ((i_DATA_com_man(12) AND NOT(i_CS3)) OR (i_DATA_capteurs(12) AND NOT(i_CS2)) OR (i_DATA_echo(12) AND NOT(i_CS5)));
--o_DATA(13)<=i_R_W AND ((i_DATA_com_man(13) AND NOT(i_CS3)) OR (i_DATA_capteurs(13) AND NOT(i_CS2)) OR (i_DATA_echo(13) AND NOT(i_CS5)));
--o_DATA(14)<=i_R_W AND ((i_DATA_com_man(14) AND NOT(i_CS3)) OR (i_DATA_capteurs(14) AND NOT(i_CS2)) OR (i_DATA_echo(14) AND NOT(i_CS5)));
--o_DATA(15)<=i_R_W AND ((i_DATA_com_man(15) AND NOT(i_CS3)) OR (i_DATA_capteurs(15) AND NOT(i_CS2)) OR (i_DATA_echo(15) AND NOT(i_CS5)));

o_DATA(0)<=i_R_W AND ((i_DATA_com_man(0) AND NOT(i_CS3)) OR (i_DATA_capteurs(0) AND NOT(i_CS2)) OR (i_DATA_echo_centre(0) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(0) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(0) AND NOT i_CS7  ) )  ;
o_DATA(1)<=i_R_W AND ((i_DATA_com_man(1) AND NOT(i_CS3)) OR (i_DATA_capteurs(1) AND NOT(i_CS2)) OR (i_DATA_echo_centre(1) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(1) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(1) AND NOT i_CS7  ));
o_DATA(2)<=i_R_W AND ((i_DATA_com_man(2) AND NOT(i_CS3)) OR (i_DATA_capteurs(2) AND NOT(i_CS2)) OR (i_DATA_echo_centre(2) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(2) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(2) AND NOT i_CS7  ));
o_DATA(3)<=i_R_W AND ((i_DATA_com_man(3) AND NOT(i_CS3)) OR (i_DATA_capteurs(3) AND NOT(i_CS2)) OR (i_DATA_echo_centre(3) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(3) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(3) AND NOT i_CS7  ));
o_DATA(4)<=i_R_W AND ((i_DATA_com_man(4) AND NOT(i_CS3)) OR (i_DATA_capteurs(4) AND NOT(i_CS2)) OR (i_DATA_echo_centre(4) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(4) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(4) AND NOT i_CS7  ));
o_DATA(5)<=i_R_W AND ((i_DATA_com_man(5) AND NOT(i_CS3)) OR (i_DATA_capteurs(5) AND NOT(i_CS2)) OR (i_DATA_echo_centre(5) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(5) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(5) AND NOT i_CS7  ));
o_DATA(6)<=i_R_W AND ((i_DATA_com_man(6) AND NOT(i_CS3)) OR (i_DATA_capteurs(6) AND NOT(i_CS2)) OR (i_DATA_echo_centre(6) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(6) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(6) AND NOT i_CS7  ));
o_DATA(7)<=i_R_W AND ((i_DATA_com_man(7) AND NOT(i_CS3)) OR (i_DATA_capteurs(7) AND NOT(i_CS2)) OR (i_DATA_echo_centre(7) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(7) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(7) AND NOT i_CS7  ));
o_DATA(8)<=i_R_W AND ((i_DATA_com_man(8) AND NOT(i_CS3)) OR (i_DATA_capteurs(8) AND NOT(i_CS2)) OR (i_DATA_echo_centre(8) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(8) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(8) AND NOT i_CS7  ));
o_DATA(9)<=i_R_W AND ((i_DATA_com_man(9) AND NOT(i_CS3)) OR (i_DATA_capteurs(9) AND NOT(i_CS2)) OR (i_DATA_echo_centre(9) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(9) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(9) AND NOT i_CS7  ));
o_DATA(10)<=i_R_W AND ((i_DATA_com_man(10) AND NOT(i_CS3)) OR (i_DATA_capteurs(10) AND NOT(i_CS2)) OR (i_DATA_echo_centre(10) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(10) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(10) AND NOT i_CS7  ));
o_DATA(11)<=i_R_W AND ((i_DATA_com_man(11) AND NOT(i_CS3)) OR (i_DATA_capteurs(11) AND NOT(i_CS2)) OR (i_DATA_echo_centre(11) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(11) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(11) AND NOT i_CS7  ));
o_DATA(12)<=i_R_W AND ((i_DATA_com_man(12) AND NOT(i_CS3)) OR (i_DATA_capteurs(12) AND NOT(i_CS2)) OR (i_DATA_echo_centre(12) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(12) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(12) AND NOT i_CS7  ));
o_DATA(13)<=i_R_W AND ((i_DATA_com_man(13) AND NOT(i_CS3)) OR (i_DATA_capteurs(13) AND NOT(i_CS2)) OR (i_DATA_echo_centre(13) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(13) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(13) AND NOT i_CS7  ));
o_DATA(14)<=i_R_W AND ((i_DATA_com_man(14) AND NOT(i_CS3)) OR (i_DATA_capteurs(14) AND NOT(i_CS2)) OR (i_DATA_echo_centre(14) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(14) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(14) AND NOT i_CS7  )) ;
o_DATA(15)<=i_R_W AND ((i_DATA_com_man(15) AND NOT(i_CS3)) OR (i_DATA_capteurs(15) AND NOT(i_CS2)) OR (i_DATA_echo_centre(15) AND NOT(i_CS5)) OR ( i_DATA_echo_Gauche(15) AND NOT i_CS6 ) OR (i_DATA_echo_Droite(15) AND NOT i_CS7  ));

end architecture synthese;