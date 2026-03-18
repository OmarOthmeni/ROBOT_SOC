/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
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
