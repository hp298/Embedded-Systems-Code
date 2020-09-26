#include "score.h"
#include "utils.h"
#include "tools.h"
#include <stdio.h> 
#include <stdlib.h> 
#include <time.h> 
#include <MK64F12.h>

/*-------------------
 Test LED functionality
*-------------------*/
void LED_test (void) {
	// BEGIN TEST
	delay();
	
	// RED
	LEDRed_Toggle();
	delay();
	LEDRed_Toggle();
	delay();
	
	// GREEN
	LEDGreen_Toggle();
	delay();
	LEDGreen_Toggle();
	delay();
	
	// BLUE
	LEDBlue_Toggle();
	delay();
	LEDBlue_Toggle();
	delay();
	
	// YELLOW
	LEDRed_Toggle();
	LEDGreen_Toggle();
	delay();
	LEDRed_Toggle();
	LEDGreen_Toggle();
	delay();
	
  // CYAN
	LEDGreen_Toggle();
	LEDBlue_Toggle();
	delay();
	LEDGreen_Toggle();
	LEDBlue_Toggle();
	delay();
	
	// Purple
	LEDBlue_Toggle();
	LEDRed_Toggle();
	delay();
	LEDBlue_Toggle();
	LEDRed_Toggle();
	delay();
	
  // WHITE
	LEDRed_Toggle();
	LEDGreen_Toggle();
	LEDBlue_Toggle();
	delay();
	LEDRed_Toggle();
	LEDGreen_Toggle();
	LEDBlue_Toggle();
	delay();
	
	LEDGreen_On();
	// END TEST
}

/*-------------------
 Test LED functionality
*-------------------*/
void pattern_test (void){
	// BEGIN TEST
		int num = 1111111111; // test number
	
		int next;
	
		for (int i = 0; i < 10000; i++){ // continue forever
			half_delay();
			
		  // use square to not have guessable pattern
			next = ( num / ((i+1)^2)) % 2; // binary digit at pos n
				
			if (next == 0) { // if 0 : right
				red();
			}
			else { // if 1 : left
				blue();
			}
		}
		
	LEDGreen_On(); // it wont reach this
	
	// END TEST
}

/* ------------------
 Test randomness
*-------------------*/
void random_test (void) {
	// BEGIN TEST
	for (int i=0; i<2; i++) {
		srand(NULL); // random seed
		int random = rand(); // randome number
		random = random % 1000;
		relay_score(random); // show it in morse
		half_delay();
		game_start();
	}
	LEDGreen_On();
	
	// END TEST
}

/* ------------------
 Test Morse Code values
*-------------------*/
void morse_test (void) {
	// BEGIN TEST
	
	// check every Morse Code ValueS
	for (int i=0; i<10; i++) {
		space();
		delay();
		morse(i);
	}
	LEDGreen_On();
	
	// END TEST
}

/* ------------------
 Test score displaying
*-------------------*/
void score_test (void){
	// BEGIN TEST
	
	relay_score(420);
	
	// END TEST
}