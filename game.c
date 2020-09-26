#include <MK64F12.h>
#include "utils.h"
#include "score.h"
#include "test.h"
#include "tools.h"
#include <math.h>
#include <stdio.h> 
#include <stdlib.h> 
#include <time.h> 
  
// globals
int ttime = 420;
int bttnPrssd;
int RP = 0; // stop double input
int LP = 0; // " "
int score = 0;
int random = 0;

// TODO: create a large random number
void random_num(void)
{
	srand(ttime);
	random = rand();
	//random = 1111111111; // test
}

// LED sequence to follow, n length
void LED_sequence(int n)
{
	int next;
	
	for (int i=0; i<n; i++) {
		half_delay();
		
		// use squares to not have a pattern
		next =  ( random / ((i+1)^2)) % 2; // binary digit at pos n
		
		if (next == 0) { // if 0, right
			red();
		}
		else { // if 1, left
			blue();
		}
	}
}

// Check if correct sequence entered
int user_sequence(int n)
{
	int next;
	
	// for the round number
	for (int i=0; i<n; i++) {
		
		// same as LED_sequence to get correct response
		next = ( random / ((i+1)^2)) % 2; // binary digit at pos n
		
		// wait for a button to be pressed
		while ( bttnPrssd == 0 ){}
			bttnPrssd -= 1; // make so button pressed equivelent to corresponding pattern 
			
			// wrong button choice, round over, game over, failed!!!
			if ( next != bttnPrssd ) {
				incorrect();
				return 1;	
			}
		
			// correct button choice
			correct();
			q_delay();
			bttnPrssd = 0;
			RP = 0;
			LP = 0;
		}
	
	// completed round successfully
	next_round();
	RP = 0;
	LP = 0;
	return 0;
}

int main (void)
{
	// init IO
	LED_Initialize();
	bttn_Initialize();
	
	// set globals
	random_num(); 
	RP = 1; // not change bttnPrssd when 1
	LP = 1; // " "
	
	// keep track of level & if the user is has/hasn't lost
	int play = 0;
	int round = 0;

	// indicate start of game
	game_start();
	half_delay();
	
	// go until user fails a round
	while (play == 0) {
		round += 1; // next round
		
		half_delay();
		
		// pattern for user to follow
		LED_sequence(round); 
		
		// indicate to user to start
		round_start();
		
		// let buttons work
		RP = 0;
		LP = 0;
		
		// 0 if user succedded, 1 if failed
		play = user_sequence(round);
		
		// make buttons not work
		RP = 1;
		LP = 1;
		bttnPrssd = 0;
	}
 
	// give user score
  relay_score(round-1);
	
	// tell user game over
	game_start();
	
	
 while (1) ;
 
 return 0;
}

//right button
void PORTC_IRQHandler (void)
{
	if ( RP == 0) { // help stop double bouncing
		RP = 1; // " "
		bttnPrssd = 1; // update that button pressed
	}
	
	//LEDRed_Toggle // Used for testing buttons
	
	q_delay(); // help stop double bouncing
	
	PORTC->PCR[6] = 0x10A0100; /* Connect Switch as interrupt */
}

// left button
void PORTA_IRQHandler (void)
{
	if ( LP == 0) { //help stop double bouncing
		LP = 1; // " "
		bttnPrssd = 2; // update that button pressed
	}
	
	//LEDBlue_Toggle(); // Used for testing buttons
	
	q_delay(); // help stop double bouncing
	
	PORTA->PCR[4] = 0x10A0100; /* Connect Switch as interrupt */
}
