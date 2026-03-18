library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity trigger is
port(
		i_clock				: in 	std_logic;	--signal d'horloge
		i_reset				: in	std_logic;	--signal de reset, actif à 1
		i_adresse			: in	std_logic_vector(1 downto 0); --adresse du registre concerné sur le périphérique
		i_DATA				: in	std_logic_vector(15 downto 0);--bus de données entrantes
		i_CS				: in	std_logic; --signal de chip select, validant la lecture sur le bus de DATA
		o_sig_trigger		: out	std_logic;  --signal carré de commande du trigger du SRF05
		o_sig_limit			: out	std_logic_vector(9 downto 0)--bus donnant la limite de détection
		);
end entity trigger;

architecture synthese of trigger is

signal cpt_dix_micro	:	std_logic_vector(8 downto 0);--compteur permettant de générer une horloge secondaire à 100kHz
signal dix_micro		:	std_logic; --signal d'horloge cadencé à 10kHz

signal registre_NASTABLE			:	std_logic_vector(15 downto 0); -- registre contenant l'information sur la fréquence des signaux moteur de sortie
signal registre_NRAPPORT			:	std_logic_vector(15 downto 0); -- registre contenant l'information de durée du pulse du signal moteur droit 
signal registre_limite				:	std_logic_vector(9 downto 0);  -- registre contenant la limite fixée de détection du signal echo														   -- les information marche/arrêt sur le signal maitre, le signal moteur droit et le signal moteur gauche
signal registre_not_used			:	std_logic_vector(15 downto 0);  -- registre 4iem adresse en écriture du CS5 NON UTILISE

signal cpt_sig_astable		:	std_logic_vector(15 downto 0);  -- compteur permettant de générer le signal astable commandé par N0
signal sig_astable			:	std_logic;	--porte le signal astable à période commandée par N0

signal cpt_sig_trigger	:	std_logic_vector(15 downto 0); -- compteur permettant de générer le signal monostable commandé par N1
signal sig_trigger		:	std_logic;  --porte le signal monostable à période commandée par N0 et N1

begin								 

--------------------------------------------------------------------------------------------------
--Acquisition des données
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,i_adresse,i_DATA,i_CS)
begin
	if i_reset='1' then
		registre_NASTABLE			<= (others=>'0');
		registre_NRAPPORT			<= (others=>'0');
		registre_limite				<= (others=>'0');
		registre_not_used			<= (others=>'0');
	else
		if i_clock'event and i_clock = '1'  then
			if i_CS='0' then
				case i_adresse is
					when "00" 	=>  registre_NASTABLE 			<= i_DATA;
					when "01" 	=>  registre_NRAPPORT 			<= i_DATA;
					when "10"	=>  registre_limite(0) <= i_DATA(0);
									registre_limite(1) <= i_DATA(1);
									registre_limite(2) <= i_DATA(2);
									registre_limite(3) <= i_DATA(3);
									registre_limite(4) <= i_DATA(4);
									registre_limite(5) <= i_DATA(5);
									registre_limite(6) <= i_DATA(6);
									registre_limite(7) <= i_DATA(7);
									registre_limite(8) <= i_DATA(8);
									registre_limite(9) <= i_DATA(9); 
					when others => 	registre_not_used	<= (others=>'0');-- NOT USED
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

process(i_clock,i_reset,dix_micro,registre_NASTABLE)
begin
	if i_reset='1' then
--initialisation des variables
		cpt_sig_astable <="0000000000000001";
		sig_astable <= '0';		
	else
--generation du signal
		if i_clock'event and i_clock = '1'  then

				if dix_micro='1' then --toutes les 10 us
					if cpt_sig_astable < registre_NASTABLE then		
					
						if cpt_sig_astable < registre_NASTABLE(15 downto 1) then 	-- division de la période par deux pour avoir un rapport cyclique de 50%! 
							sig_astable<='1';				-- donc le pulse est maintenu
						
						else								-- on se situe au delà du rapport cyclique de 50% 
							sig_astable<='0'; 				-- donc le pulse n'a pas de raison d'être
						end if;
					
						cpt_sig_astable<=cpt_sig_astable+1;		-- incrémentation systématique
					
					else								
						cpt_sig_astable<="0000000000000001";		-- réinitialisation du compteur: on est reparti pour une nouvelle période
					end if;
				end if;		
			
		end if;
	end if;
end process;

--------------------------------------------------------------------------------------------------
--Génération d'un signal monostable de rapport cyclique commandé par N1 et période commandée par N0
--------------------------------------------------------------------------------------------------

process(i_clock,i_reset,dix_micro,registre_NRAPPORT,sig_astable)
begin
	if i_reset='1' then
--initialisation des variables
		cpt_sig_trigger <=(others=>'0');
		sig_trigger <= '0';		
	else
--generation du signal
		if i_clock'event and i_clock = '1'  then
			if sig_astable='1' then
				
				if dix_micro='1' then --toutes les 10 us
											
					if cpt_sig_trigger < registre_NRAPPORT then		
											
						sig_trigger<='1';				-- donc le pulse est maintenu
						
					else								 

						sig_trigger<='0'; 			-- donc le pulse n'a pas de raison d'être

					end if;
					
					cpt_sig_trigger<=cpt_sig_trigger+1;		-- incrémentation systématique
				
				end if;
				
			else								
				cpt_sig_trigger<="0000000000000000";		-- réinitialisation du compteur: on est reparti pour une nouvelle période					end if;
				sig_trigger<='0';
			end if;		
			
		end if;
	end if;
end process;


o_sig_trigger <= sig_trigger;
o_sig_limit  <= registre_limite;

end architecture synthese;