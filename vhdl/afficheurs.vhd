library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity afficheurs is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif � 1
		i_CS				: in 	std_logic;	--signal de chip select actif � 0
		i_DATA				: in	std_logic_vector(15 downto 0);
		i_adresse			: in 	std_logic_vector(1 downto 0);
		o_afficheur_1_1		: out	std_logic_vector(6 downto 0);
		o_afficheur_1_2		: out	std_logic_vector(6 downto 0);
		o_afficheur_2_1		: out	std_logic_vector(6 downto 0);
		o_afficheur_2_2		: out	std_logic_vector(6 downto 0);
		o_afficheur_3_1		: out	std_logic_vector(6 downto 0);
		o_afficheur_3_2		: out	std_logic_vector(6 downto 0)
		);
end entity afficheurs;

architecture synthese of afficheurs is

signal afficheur1_bin	:	std_logic_vector(15 downto 0);
signal afficheur2_bin	:	std_logic_vector(15 downto 0);
signal afficheur3_bin	:	std_logic_vector(15 downto 0);

signal afficheur1_bcd	:	std_logic_vector(7 downto 0);
signal afficheur2_bcd	:	std_logic_vector(7 downto 0);
signal afficheur3_bcd	:	std_logic_vector(15 downto 0);

signal nombre_courant	: 	std_logic_vector(1 downto 0);
signal bcd_conv			:	std_logic_vector(15 downto 0);
signal reste			:	std_logic_vector(15 downto 0);
signal conv_en_cours	: 	std_logic;

signal cpt_afficheur	: 	std_logic_vector(2 downto 0);
signal a_afficher		: 	std_logic_vector(3 downto 0);
signal sortie			:	std_logic_vector(6 downto 0);

begin

--------------------------------------------------------------------------------------------------
--Acquisition des donn�es
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,i_adresse,i_DATA,i_CS)
begin
	if i_reset='1' then
		afficheur1_bin			<= (others=>'0');
		afficheur2_bin			<= (others=>'0');
		afficheur3_bin			<= (others=>'0');
		
	else
		if i_clock'event and i_clock = '1'  then
			if i_CS='0' then
				case i_adresse is
					when "00" 	=> 	afficheur1_bin <= i_DATA;  
					when "01" 	=> 	afficheur2_bin <= i_DATA; 
					when others	=> 	afficheur3_bin <= i_DATA; 
													
				end case;				
			end if;
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
-- convertisseur binaire/bcd d'un nombre inf�rieur ou �gal � 9999
--------------------------------------------------------------------------------------------------

process(i_reset, i_clock, nombre_courant,i_adresse)
begin
	if i_reset='1' then
			conv_en_cours <= '0';
			bcd_conv <= (others=>'0');
			reste <= (others=>'0');
			nombre_courant <= (others=>'0');
	else 
		if i_clock'event and i_clock = '1' then
			if conv_en_cours='0' then
				if ((afficheur1_bin > 99)AND((nombre_courant=0)OR(nombre_courant=3)))then 
					afficheur1_bcd<=(others=>'1');
					conv_en_cours <= '0';
					nombre_courant<=nombre_courant+1;
				elsif ((afficheur2_bin > 99)AND(nombre_courant=1))then 
					afficheur2_bcd<=(others=>'1');
					conv_en_cours <= '0';
					nombre_courant<=nombre_courant+1;
				elsif ((afficheur3_bin > 99)AND(nombre_courant=2)) then
					afficheur3_bcd<=(others=>'1');
					conv_en_cours <= '0';
					nombre_courant<=nombre_courant+1;					
				else
					case nombre_courant is
						when "00" 	=> reste <= afficheur1_bin;
						when "01" 	=> reste <= afficheur2_bin;
						when "10" 	=> reste <= afficheur3_bin;
						when others	=> reste <= afficheur1_bin; nombre_courant <= "00";
					end case; 
			
					conv_en_cours<='1';
					bcd_conv<=(others=>'0');
					
				end if;
			else 
				-- Affectation du chiffre des milliers
				if reste > 8999 then
					bcd_conv(15 downto 12) <= "1001";
					reste <= reste - 9000;
				elsif reste > 7999 then
					bcd_conv(15 downto 12) <= "1000";
					reste <= reste - 8000;
				elsif reste > 6999 then
					bcd_conv(15 downto 12) <= "0111";
					reste <= reste - 7000;
				elsif reste > 5999 then
					bcd_conv(15 downto 12) <= "0110";
					reste <= reste - 6000;
				elsif reste > 4999 then
					bcd_conv(15 downto 12) <= "0101";
					reste <= reste - 5000;
				elsif reste > 3999 then
					bcd_conv(15 downto 12) <= "0100";
					reste <= reste - 4000;
				elsif reste > 2999 then
					bcd_conv(15 downto 12) <= "0011";
					reste <= reste - 3000;
				elsif reste > 1999 then
					bcd_conv(15 downto 12) <= "0010";
					reste <= reste - 2000;
				elsif reste > 999 then
					bcd_conv(15 downto 12) <= "0001";
					reste <= reste - 1000;
				-- Affectation du chiffre des centaines
				elsif reste > 899 then
					bcd_conv(11 downto 8) <= "1001";
					reste <= reste - 900;
				elsif reste > 799 then
					bcd_conv(11 downto 8) <= "1000";
					reste <= reste - 800;
				elsif reste > 699 then
					bcd_conv(11 downto 8) <= "0111";
					reste <= reste - 700;
				elsif reste > 599 then
					bcd_conv(11 downto 8) <= "0110";
					reste <= reste - 600;
				elsif reste > 499 then
					bcd_conv(11 downto 8) <= "0101";
					reste <= reste - 500;
				elsif reste > 399 then
					bcd_conv(11 downto 8) <= "0100";
					reste <= reste - 400;
				elsif reste > 299 then
					bcd_conv(11 downto 8) <= "0011";
					reste <= reste - 300;
				elsif reste > 199 then
					bcd_conv(11 downto 8) <= "0010";
					reste <= reste - 200;
				elsif reste > 99 then
					bcd_conv(11 downto 8) <= "0001";
					reste <= reste - 100;
				-- Affectation du chiffre des dizaines
				elsif reste > 89 then
					bcd_conv(7 downto 4) <= "1001";
					reste <= reste - 90;
				elsif reste > 79 then
					bcd_conv(7 downto 4) <= "1000";
					reste <= reste - 80;
				elsif reste > 69 then
					bcd_conv(7 downto 4) <= "0111";
					reste <= reste - 70;
				elsif reste > 59 then
					bcd_conv(7 downto 4) <= "0110";
					reste <= reste - 60;
				elsif reste > 49 then
					bcd_conv(7 downto 4) <= "0101";
					reste <= reste - 50;
				elsif reste > 39 then
					bcd_conv(7 downto 4) <= "0100";
					reste <= reste - 40;
				elsif reste > 29 then
					bcd_conv(7 downto 4) <= "0011";
					reste <= reste - 30;
				elsif reste > 19 then
					bcd_conv(7 downto 4) <= "0010";
					reste <= reste - 20;
				elsif reste > 9 then
					bcd_conv(7 downto 4) <= "0001";
					reste <= reste - 10;
				-- Affectation du chiffre des unit�s
				else 
					bcd_conv(3 downto 0) <= reste(3 downto 0);
				-- gagne un coup d'horloge...
					case nombre_courant is
						when "00" 	=> 	afficheur1_bcd <= bcd_conv(7 downto 0)+reste(3 downto 0);
						when "01" 	=> 	afficheur2_bcd <= bcd_conv(7 downto 0)+reste(3 downto 0);
						when "10" 	=> 	afficheur3_bcd <= bcd_conv+reste;
						when others	=> 	conv_en_cours <= '0';
					end case;
					conv_en_cours <= '0';
					nombre_courant<=nombre_courant+1;
				end if;
			end if;
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Affichage sur l'afficheur 7 segments HEX7 ... HEX0
--------------------------------------------------------------------------------------------------


-- !!!!!! Cette fonction int�gre une structure de pipeline!!!!!
-- Les trois case successifs traitent des nombres diff�rents pour un coup d'horloge donn�

process(i_clock,i_reset,afficheur1_bcd,afficheur2_bcd,afficheur3_bcd)
begin
	if i_reset='1' then

		a_afficher		<=(others=>'0');
		cpt_afficheur	<=(others=>'0');
		sortie			<=(others=>'0');
		
	else
		if i_clock'event and i_clock = '1'  then
			case cpt_afficheur is
				when "010" 	=> a_afficher <= afficheur3_bcd(7 downto 4);
				when "011" 	=> a_afficher <= afficheur3_bcd(3 downto 0);
				when "100" 	=> a_afficher <= afficheur2_bcd(7 downto 4);
				when "101" 	=> a_afficher <= afficheur2_bcd(3 downto 0);
				when "110" 	=> a_afficher <= afficheur1_bcd(7 downto 4);
				when others => a_afficher <= afficheur1_bcd(3 downto 0);
			end case;
			
			case a_afficher is
				when "0000"	=>  sortie <= "1000000";
				when "0001"	=>  sortie <= "1111001";
				when "0010"	=>  sortie <= "0100100";
				when "0011"	=>  sortie <= "0110000";
				when "0100"	=>  sortie <= "0011001";
				when "0101"	=>  sortie <= "0010010";
				when "0110"	=>  sortie <= "0000010";
				when "0111"	=>  sortie <= "1111000";
				when "1000"	=>  sortie <= "0000000";
				when "1001"	=>  sortie <= "0010000";
				when others =>  sortie <= "0000110"; -- E pour erreur...
			end case;
			
			case cpt_afficheur is
				when "100" 	=> o_afficheur_3_2 <= sortie;
				when "101" 	=> o_afficheur_3_1 <= sortie;
				when "110" 	=> o_afficheur_2_2 <= sortie;
				when "111" 	=> o_afficheur_2_1 <= sortie;
				when "000" 	=> o_afficheur_1_2 <= sortie;
				when others => o_afficheur_1_1 <= sortie;
			end case; 
			
			cpt_afficheur<=cpt_afficheur+1;
		end if;
	end if;
end process;

end architecture synthese;