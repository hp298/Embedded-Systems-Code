#include <MK64F12.h>

void setUpRedLED(){
	SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK; //Enable clock to port B
	PORTB->PCR[22] |= PORT_PCR_MUX(001); //Set up pin 22 for output
	PTB->PDDR |= (1 << 22); //set direction for red LED
	PTB->PSOR |= (1 << 22); //set off at default
}

void toggleRedLED(){
	PTB->PTOR |= (1 << 22); //Toggle Red LED
}

int main (void)
{
	setUpRedLED();
	SIM->SCGC6 = SIM_SCGC6_PIT_MASK; // Enable clock to PIT module
	PIT->MCR =0x00;
	PIT->CHANNEL[0].LDVAL = 22430000; // Set load value of zeroth PIT NOTE PIT has 50Mhz Clock so this is 1 sec
	PIT->CHANNEL[0].TCTRL = (1 << 0); // Start timer 
	while(1){
		if(PIT->CHANNEL[0].TFLG){
			toggleRedLED();
			PIT->CHANNEL[0].TFLG = 0x1;
			PIT->CHANNEL[0].TCTRL = (1 << 0); //restart timer
		}
	}
	return(0);
}

