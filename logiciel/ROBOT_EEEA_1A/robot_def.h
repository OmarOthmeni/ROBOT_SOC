/* 
 * @ definition for EEEA Robot application.
 * 
 *
 */

// Définition de la valeur d'arrêt des moteurs
#define STOP 150
#define MARCHE_AV 20
#define MARCHE_AR -20

// Adressage des différents périphériques

//CS0
	// Adressage des afficheurs
	#define AFFICHEUR_1 ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE))
	#define AFFICHEUR_2 ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 2))
	#define AFFICHEUR_3 ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 4))

//CS1
	// Adressage des LEDs
	#define LED_ROUGES ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 8))

//CS2
	// Adressage des capteurs robots à l'exception du SRF05
	#define CAPTEURS_ROBOT ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 16))
	#define CAPTEURS_JOYSTICK ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 18))


//	#define EMETTEURS ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 20))

//CS3
	// Adressage des boutons
	#define SWITCHES ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 24))

//CS4
	// Adressage des commandes du moteurs
	#define COMMANDE_MOTEUR_MAITRE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 32))
	#define COMMANDE_MOTEUR_DROIT ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 36))
	#define COMMANDE_MOTEUR_GAUCHE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 34))
	#define START_MOTEURS ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 38))

//CS5 - Capteur Ultra Son Centre

// Adressage des commandes d'émission du SRF05
	#define COMMANDE_TRIGGER_ASTABLE_CENTRE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 40))
	#define COMMANDE_TRIGGER_RAPPORT_CENTRE  ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 42))
	#define ECHO_LIMITE_CENTRE  ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 44))		//Borne limite de détection
	// Adressage des commandes de réception du SRF05
	#define ECHO_CENTRE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 46))

//CS56 - Capteur Ultra Son Gauche

// Adressage des commandes d'émission du SRF05
	#define COMMANDE_TRIGGER_ASTABLE_GAUCHE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 48))
	#define COMMANDE_TRIGGER_RAPPORT_GAUCHE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 50))
	#define ECHO_LIMITE_GAUCHE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 52))		//Borne limite au delà de laquelle on considère qu'on ne détecte rien
	// Adressage des commandes de réception du SRF05
	#define ECHO_GAUCHE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 54))

//CS56 - Capteur Ultra Son Gauche

// Adressage des commandes d'émission du SRF05
	#define COMMANDE_TRIGGER_ASTABLE_DROITE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 56))
	#define COMMANDE_TRIGGER_RAPPORT_DROITE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 58))
	#define ECHO_LIMITE_DROITE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 60))		//Borne limite au delà de laquelle on considère qu'on ne détecte rien
	// Adressage des commandes de réception du SRF05
	#define ECHO_DROITE ((volatile short*) (TO_EXTERNAL_BUS_BRIDGE_0_BASE + 62))

