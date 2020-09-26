#include "utils.h"

// delay
void delay(void){
	int j;
	for(j=0; j<1000000; j++);
}

// half delay
void half_delay(void){
	int j;
	for(j=0; j<500000; j++);
}

// quarter delay
void q_delay(void){
	int j;
	for(j=0; j<250000; j++);
}

// 1 red light
void red(void) {
	LEDRed_Toggle();
	delay();
	LEDRed_Toggle();	
}

// 1 blue light
void blue(void) {
	LEDBlue_Toggle();
	delay();
	LEDBlue_Toggle();	
}

// 1 green light
void correct(void)
{
	LEDGreen_Toggle();
	q_delay();
	LEDGreen_Toggle();
}

// 2 green lights
void next_round (void)
{
	for (int i=0; i<2; i++) { 
		correct(); 
		q_delay(); 
	}
}

// 3 red lights
void incorrect(void)
{
	for (int i=0; i<3; i++) {
	half_delay();
	LEDRed_Toggle();
	half_delay();
	LEDRed_Toggle();
	}
	delay();
}

// 3 white
void game_start (void){
	for (int i = 0; i<6; i++) {
		delay();
		LEDBlue_Toggle();
		LEDRed_Toggle();
		LEDGreen_Toggle();
	}
}

// 2 white
void space (void) {
		for (int i = 0; i<4; i++) {
		delay();
		LEDBlue_Toggle();
		LEDRed_Toggle();
		LEDGreen_Toggle();
	}
}

// 1 white
void round_start (void) {
	for (int i = 0; i<2; i++) {
		delay();
		LEDBlue_Toggle();
		LEDRed_Toggle();
		LEDGreen_Toggle();
	}
}

// gets user attention
void attention (void)
{
	delay();
	delay();
	
	LEDRed_Toggle();
	half_delay();
	LEDRed_Toggle();
	
	half_delay();
	
	LEDBlue_Toggle();
	half_delay();
	LEDBlue_Toggle();
	
	half_delay();
	
	LEDGreen_Toggle();
	half_delay();
	LEDGreen_Toggle();
	
	delay();
	delay();
}