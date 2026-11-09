/*
 * BoB robot firmware (Nios II, HAL small C library).
 *
 * Memory-mapped peripherals are defined in robot_def.h:
 *   - joystick and switches (inputs), 3 seven-segment displays (outputs)
 *   - 3 ultrasonic distance sensors (left / centre / right) with programmable
 *     trigger period, duty cycle and echo limit
 *   - 2 PWM motor channels (direction + duty cycle)
 */
#include "sys/alt_stdio.h"
#include <system.h>

// @ des E/S
#include "robot_def.h"


void PILOTAGE_AFFICHEUR_1 (short valeur)
{
	*AFFICHEUR_1=valeur;
}
void PILOTAGE_AFFICHEUR_2 (short valeur)
{
	*AFFICHEUR_2=valeur;
}
void PILOTAGE_AFFICHEUR_3 (short valeur)
{
	*AFFICHEUR_3=valeur;
}
short LECTURE_SWs ()
{
	return *SWITCHES;
}
short JOY_TEST_BOUTON (short valeur)
{
		short joy_arret=valeur & 1;
		if (joy_arret==1)
			return 1;
		else
			return 0;
}
short  TEST_JOY_DROITE (short valeur)
{
		short joy_droite=valeur & 2;
		if (joy_droite==2)
			return 1;
		else
			return 0;
}
short  TEST_JOY_GAUCHE (short valeur)
{
		short joy_gauche=valeur & 4;
		if (joy_gauche==4)
			return 1;
		else
			return 0;
}
short TEST_JOY_HAUT (short valeur)
{
		short joy_avant=valeur & 16;
		if (joy_avant==16)
			return 1;
		else
			return 0;
}
short TEST_JOY_BAS (short valeur)
{
		short joy_arriere=valeur & 8;
		if (joy_arriere==8)
			return 1;
		else
			return 0;
}
void GESTION_JOYSTICK()
{
	short vtestJoy;
	while (1) {
		vtestJoy=*CAPTEURS_JOYSTICK;
		if (JOY_TEST_BOUTON(vtestJoy)==1)
			PILOTAGE_AFFICHEUR_1(9);
		else
		{
			if( TEST_JOY_HAUT (vtestJoy)==1)
			{
				if(TEST_JOY_DROITE(vtestJoy)==1)
					PILOTAGE_AFFICHEUR_1(2);
				else if(TEST_JOY_GAUCHE (vtestJoy)==1)
					PILOTAGE_AFFICHEUR_1(8);
				else
					PILOTAGE_AFFICHEUR_1(1);
			}
			else if( TEST_JOY_BAS(vtestJoy)==1)
			{
				if(TEST_JOY_DROITE(vtestJoy)==1)
					PILOTAGE_AFFICHEUR_1(4);
				else if(TEST_JOY_GAUCHE (vtestJoy)==1)
					PILOTAGE_AFFICHEUR_1(6);
				else
					PILOTAGE_AFFICHEUR_1(5);
			}
			else if(TEST_JOY_GAUCHE (vtestJoy)==1)
				PILOTAGE_AFFICHEUR_1(7);
			else if(TEST_JOY_DROITE(vtestJoy)==1)
				PILOTAGE_AFFICHEUR_1(3);
			else
				PILOTAGE_AFFICHEUR_1(0);

		}
	}
}
void INIT_CAPTEURS_DISTANCE()
{

	*COMMANDE_TRIGGER_ASTABLE_CENTRE=5000;
	*COMMANDE_TRIGGER_RAPPORT_CENTRE=1;
	*ECHO_LIMITE_CENTRE=1000;
	*COMMANDE_TRIGGER_ASTABLE_GAUCHE=5000;
	*COMMANDE_TRIGGER_RAPPORT_GAUCHE=1;
	*ECHO_LIMITE_GAUCHE=1000;
	*COMMANDE_TRIGGER_ASTABLE_DROITE=5000;
	*COMMANDE_TRIGGER_RAPPORT_DROITE=1;
	*ECHO_LIMITE_DROITE=1000;


}
int MESURE_CAPTEUR_CENTRE()
{
	short vdist=*ECHO_CENTRE;
	return(vdist);
}
int MESURE_CAPTEUR_GAUCHE()
{
	short vdist=*ECHO_GAUCHE;
	return(vdist);
}
int MESURE_CAPTEUR_DROITE()
{
	short vdist=*ECHO_DROITE;
	return(vdist);
}
short TEST_CAPTEUR_CENTRE(short valeur)
{
	short test_capteur=valeur&2;
	if(test_capteur==2)
		return 0;
	else
		return 1;
}
short TEST_CAPTEUR_GAUCHE(short valeur)
{
	short test_capteur=valeur&1;
	if(test_capteur==1)
		return 0;
	else
		return 1;
}
short TEST_CAPTEUR_DROIT(short valeur)
{
	short test_capteur=valeur&4;
	if(test_capteur==4)
		return 0;
	else
		return 1;
}
short DETECT_OBSTACLE()
{
	return(MESURE)
}
int main()
{
	*COMMANDE_MOTEUR_MAITRE = 1000;
	*COMMANDE_MOTEUR_DROIT = STOP;
	*COMMANDE_MOTEUR_GAUCHE = STOP;
	*START_MOTEURS= 7;

	short capteurs ;
	while(1) {
	capteurs = *CAPTEURS_ROBOT ;
	if ( TEST_CAPTEUR_CENTRE( capteurs ) == 1)
	{
	*COMMANDE_MOTEUR_GAUCHE = STOP + MARCHE_AV;
	*COMMANDE_MOTEUR_DROIT = STOP + MARCHE_AV;
	}
	else if ( TEST_CAPTEUR_GAUCHE( capteurs ) == 1)
	{
	*COMMANDE_MOTEUR_GAUCHE = STOP ;
	*COMMANDE_MOTEUR_DROIT =STOP + MARCHE_AV;
	}
	else if ( TEST_CAPTEUR_DROIT( capteurs ) == 1)
	{
	*COMMANDE_MOTEUR_GAUCHE = STOP+ MARCHE_AV ;
	*COMMANDE_MOTEUR_DROIT =STOP ;
	}
	}
	return 0;
}
