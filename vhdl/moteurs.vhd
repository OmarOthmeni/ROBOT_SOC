library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity moteurs is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif à 1
		i_adresse			: in	std_logic_vector(1 downto 0); --adresse du registre concerné sur le périphérique
		i_DATA				: in	std_logic_vector(15 downto 0);--bus de données entrantes
		i_CS				: in	std_logic; --signal de chip select, validant la lecture sur le bus de DATA
		o_sig_mot_gauche	: out	std_logic;  --signal carré de commande du moteurs
		o_sig_mot_droit		: out	std_logic  --signal carré de commande du moteurs
		);
end entity moteurs;

architecture synthese of moteurs is

signal cpt_dix_micro	:	std_logic_vector(8 downto 0);--compteur permettant de générer une horloge secondaire à 100kHz
signal dix_micro		:	std_logic; --signal d'horloge cadencé à 10kHz

signal registre_N0			:	std_logic_vector(15 downto 0); -- registre contenant l'information sur la fréquence des signaux moteur de sortie
signal registre_N1			:	std_logic_vector(15 downto 0); -- registre contenant l'information de durée du pulse du signal moteur droit
signal registre_N2			:	std_logic_vector(15 downto 0); -- registre contenant l'information de durée du pulse du signal moteur gauche
signal registre_start_stop	:	std_logic_vector(15 downto 0); -- registre dont seuls les trois lsb sont intéressants pour le moment: ils contiennent 
															   -- les information marche/arrêt sur le signal maitre, le signal moteur droit et le signal moteur gauche

signal cpt_sig_astable		:	std_logic_vector(9 downto 0);  -- compteur permettant de générer le signal astable commandé par N0
signal sig_astable			:	std_logic;	--porte le signal astable à période commandée par N0

signal cpt_sig_mot_gauche	:	std_logic_vector(8 downto 0); -- compteur permettant de générer le signal monostable commandé par N2
signal sig_mot_gauche		:	std_logic;  --porte le signal monostable à période commandée par N0 et N2

signal cpt_sig_mot_droit	:	std_logic_vector(8 downto 0); -- compteur permettant de générer le signal monostable commandé par N1
signal sig_mot_droit		:	std_logic;  --porte le signal monostable à période commandée par N0 et N1

begin								 

--------------------------------------------------------------------------------------------------
--Acquisition des données
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,i_adresse,i_DATA,i_CS)
begin
	if i_reset='1' then
		registre_N0			<= (others=>'0');
		registre_N1			<= (others=>'0');
		registre_N2			<= (others=>'0');
		registre_start_stop	<= (others=>'0');
	else
		if i_clock'event and i_clock = '1'  then
			if i_CS='0' then
				case i_adresse is
					when "00" 	=> registre_N0 			<= i_DATA;
					when "01" 	=> registre_N1 			<= i_DATA;
					when "10" 	=> registre_N2 			<= i_DATA;
					when others	=> registre_start_stop 	<= i_DATA; --(cas i_adresse="11")
				end case;
			end if;
		end if;
	end if;
end process;


--------------------------------------------------------------------------------------------------
--Génération d'un pulse à 100 kHz
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset)
begin
	if i_reset='1' then
		cpt_dix_micro <= (others=>'0');
		dix_micro<='0';
	else
		if i_clock'event and i_clock = '1'  then
			if cpt_dix_micro < 50 then                
				cpt_dix_micro<=cpt_dix_micro+1;
				dix_micro<='0';
			else
				cpt_dix_micro<="000000001";
				dix_micro<='1';
			end if;
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Génération d'un signal astable de rapport cyclique 50% et période commandée par N0
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,dix_micro,registre_N0,registre_start_stop)
begin
	if i_reset='1' or registre_start_stop(0)='0' then
--initialisation des variables
		cpt_sig_astable <="0000000001";
		sig_astable <= '0';		
	else
--generation du signal
		if i_clock'event and i_clock = '1'  then

				if dix_micro='1' then --toutes les 10 us
					if cpt_sig_astable < registre_N0 then		
					
						if cpt_sig_astable < registre_N0(15 downto 1) then 	-- division de la période par deux pour avoir un rapport cyclique de 50%! 
							sig_astable<='1';				-- donc le pulse est maintenu
						
						else								-- on se situe au delà du rapport cyclique de 50% 
							sig_astable<='0'; 				-- donc le pulse n'a pas de raison d'être
						end if;
					
						cpt_sig_astable<=cpt_sig_astable+1;		-- incrémentation systématique
					
					else								
						cpt_sig_astable<="0000000001";		-- réinitialisation du compteur: on est reparti pour une nouvelle période
					end if;
				end if;		
			
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Génération d'un signal monostable de rapport cyclique commandé par N1 et période commandée par N0
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,dix_micro,registre_N1,registre_start_stop,sig_astable)
begin
	if i_reset='1' or registre_start_stop(1)='0' then
--initialisation des variables
		cpt_sig_mot_droit <=(others=>'0');
		sig_mot_droit <= '0';		
	else
--generation du signal
		if i_clock'event and i_clock = '1'  then
			if sig_astable='1' then
				
				if dix_micro='1' then --toutes les 10 us
											
					if cpt_sig_mot_droit < registre_N1 then		
											
						sig_mot_droit<='1';				-- donc le pulse est maintenu
						
					else								 

						sig_mot_droit<='0'; 			-- donc le pulse n'a pas de raison d'être

					end if;
					
					cpt_sig_mot_droit<=cpt_sig_mot_droit+1;		-- incrémentation systématique
				
				end if;
				
			else								
				cpt_sig_mot_droit<="000000000";		-- réinitialisation du compteur: on est reparti pour une nouvelle période					end if;
				sig_mot_droit<='0';
			end if;		
			
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Génération d'un signal monostable de rapport cyclique commandé par N2 et période commandée par N0
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,dix_micro,registre_N2,registre_start_stop,sig_astable)
begin
	if i_reset='1' or registre_start_stop(2)='0' then
--initialisation des variables
		cpt_sig_mot_gauche <=(others=>'0');
		sig_mot_gauche <= '0';		
	else
--generation du signal
		if i_clock'event and i_clock = '1'  then
			if sig_astable='1' then
				
				if dix_micro='1' then --toutes les 10 us
											
					if cpt_sig_mot_gauche < registre_N2 then		
											
						sig_mot_gauche<='1';				-- donc le pulse est maintenu
						
					else								

						sig_mot_gauche<='0'; 			-- donc le pulse n'a pas de raison d'être

					end if;
					
					cpt_sig_mot_gauche<=cpt_sig_mot_gauche+1;		-- incrémentation systématique
				
				end if;
				
			else								
				cpt_sig_mot_gauche<="000000000";		-- réinitialisation du compteur: on est reparti pour une nouvelle période					end if;
				sig_mot_gauche<='0';
			end if;		
			
		end if;
	end if;
end process;

o_sig_mot_gauche	<= sig_mot_gauche;
o_sig_mot_droit		<= sig_mot_droit;

end architecture synthese;