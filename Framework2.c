#include <MK64F12.h>

/*
     Main program: entry point
*/

#ifndef F_CPU
#define F_CPU 120000000UL
#endif


//Sets Up Green LED
void setUpGreenLED(){
	SIM->SCGC5 |= (1 << 13); //Enable clock to port 26
	PORTE->PCR[26] |= PORT_PCR_MUX(001); //Set up port 26 for output
	PTE->PDDR |= (1 << 26); //set direction for green LED
	PTE->PSOR |= (1 << 26); //set off at default
}

//Toggles Green LED
void toggleGreenLED() {
	PTE->PTOR |= (1 << 26); //Toggle green LED
}

//Sets Up Blue LED
void setUpBlueLED(){
	SIM->SCGC5 |= (1 << 10); //Enable clock to port 21
	PORTB->PCR[21] |= PORT_PCR_MUX(001); //Set up port 21 for output
	PTB->PDDR |= (1 << 21); //set direction for blue LED
	PTB->PSOR |= (1 << 21); //set off at default
}

//Toggles Blue LED
void toggleBlueLED() {
	PTB->PTOR |= (1 << 21); //Toggle blue LED
}

//Enables PIT Timer for Green LED
void enableTimer(){
	SIM->SCGC6 = SIM_SCGC6_PIT_MASK; // Enable clock to PIT module
	PIT->MCR =0x00; // Allows me to turn timer on
	PIT->CHANNEL[0].LDVAL = 45000000/3; // Set load value of zeroth PIT NOTE PIT has 50Mhz Clock so this is 1 sec
	PIT->CHANNEL[0].TCTRL |= (1 << 1); // Enable Interrupts
	PIT->CHANNEL[0].TCTRL |= (1 << 0); // Start timer
}

int main (void)
{
	  NVIC_EnableIRQ(PIT0_IRQn); /* enable PIT0 Interrupts (for part 2) */
		setUpGreenLED();
		setUpBlueLED();
		enableTimer();

	  /* your code goes here */
		int k; //for loop variable
		while(1) {
			for(k = 0; k < F_CPU/(8*10); ++k){ //there are about 8 instructions in a for loop iterations therefore divide by 8
				
			}
			//toggleBlueLED();
		}
}


/* 
     PIT Interrupt Handler
*/
void PIT0_IRQHandler(void)
{
	  /* code goes here */
		PIT->CHANNEL[0].TFLG = 1;
		toggleGreenLED();
		PIT->CHANNEL[0].TCTRL |=(1 << 0); 
}

