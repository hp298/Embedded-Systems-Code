#include "score.h"
#include "utils.h"
#include "tools.h"
#include <math.h>


/*-------------------------------------------------------
 A dot for morse code
 *---------------------------------------------------------*/
void dot (void)
{
	LEDBlue_Toggle();
	LEDGreen_Toggle();
	delay();
	LEDBlue_Toggle();
	LEDGreen_Toggle();
}

/*-------------------------------------------------------
 A dash for morse code
 *---------------------------------------------------------*/
void dash (void)
{
	LEDBlue_Toggle();
	LEDRed_Toggle();
	delay();
	delay();
	delay();
	LEDBlue_Toggle();
	LEDRed_Toggle();
}

/*-------------------------------------------------------
 Morse code representation of a number x (0-9)
 *---------------------------------------------------------*/
void morse (int x)
{
	// for # 0 - 5
	if (x<6) {
		for (int i=0; i<x; i++) {
			delay();
			half_delay();
			dot();
		}
		for (int i=0; i<(5-x); i++) {
			delay();
			half_delay();
			dash();
		}
	}
	
	// for # 6-9 lol
	if (x>5) {
		x=x-5;
		for (int i=0; i<x; i++) {
			delay();
			half_delay();
			dash();
		}
		for (int i=0; i<(5-x); i++) {
			delay();
			half_delay();
			dot();
		}
	}
}


/*-------------------------------------------------------
 Takes a number, n, and converts to morse code digits
 Up to 6 digits
 *---------------------------------------------------------*/
void relay_score (int n)
{
	attention();
	int decade;
	int digit;

	// make values from 9.99 million to 10
	for (int i=6; i>0; i--) {
		decade = pow(10,i);
		if (n >= decade) {
			digit = n / decade;
			morse( digit );
			n = n % decade;
			delay();
			space();
		}
	}
	
	// single digit values
	digit = n % 10;
	morse( digit );
	
	// delay
	delay();
	delay();
	
}