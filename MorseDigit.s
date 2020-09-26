		AREA Myprog, CODE, READONLY
		ENTRY
		EXPORT __main
			
;don't change these addresses!
PCR22 	  EQU 0x4004A058 ;PORTB_PCR22  address
SCGC5 	  EQU 0x40048038 ;SIM_SCGC5    address
PDDR 	  EQU 0x400FF054 ;GPIOB_PDDR   address
PCOR 	  EQU 0x400FF048 ;GPIOB_PCOR   address
PSOR      EQU 0x400FF044 ;GPIOB_PSOR   address

ten		  EQU 0x00000400 ; 1 << 10
eight     EQU 0x00000100 ; 1 << 8
twentytwo EQU 0x00400000 ; 1 << 22

__main
	;;; r0-r3 scrach registers, r0-r1 result registers
	;;;r4-r8 callee save registers
	
	; Your code goes here!
			MOV   R3, #7
			MOV   R7, #19
			MOV   R1, #0xbeef
			BL    LEDSETUP
			;test 0
			MOV   R0, #0
			BL    MorseDigit
			BL    Delay
			;test 1
			MOV   R0, #1
			BL    MorseDigit
			BL    Delay
			;test 2
			MOV   R0, #2
			BL    MorseDigit
			BL    Delay
			;test 3
			MOV   R0, #3
			BL    MorseDigit
			BL    Delay
			;test 4
			MOV   R0, #4
			BL    MorseDigit
			BL    Delay
			;test 5
			MOV   R0, #5
			BL    MorseDigit
			BL    Delay
			;test 6
			MOV   R0, #6
			BL    MorseDigit
			BL    Delay
			;test 7
			MOV   R0, #7
			BL    MorseDigit
			BL    Delay
			;test 8
			MOV   R0, #8
			BL    MorseDigit
			BL    Delay
			;test 9
			MOV   R0, #9
			BL    MorseDigit
			BL    Delay
			;test 0
			MOV   R0, #0
			BL    MorseDigit
			BL    Delay
			B	  forever
			
;function call for MorseDigit
MorseDigit ;void MorseDigit( int R0 ){
            PUSH {R0, R4, R6}
			;int n = 5;
			MOV   R4, #5 
			ADDS  R0, #0
			;if R0 == 0 { // if R0 is 0
			;  Is0( n , R0 ); 
			;}
			BEQ   Is0 
			;else if R0 < 6 { // if R0 > 0 && R0 < 6
			;  LTS( n , R0 ); 
			;}
			CMP   R0, #6
			BMI   LTS
		    ;else { // if R0 > 5
			;  R0 = R0 - 5; 
			;  GTF( n , R0);
			;}
			SUB   R0, #5
		   ;} // end of MorseDigit Function
		   
		  
GTF        ;void GTF( int n, int R0) { 
            ;for( i=0; i<R0; i++ ){ // 'print' correct # of dashes
			  ;LEDON();
			PUSH  {LR}
			BL    LEDON
			POP   {LR}
			  ;sleep(10);
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L1          
			SUBS  R6, #1
			BNE   L1
			  ;LEDOFF();
			PUSH  {LR}
			BL	  LEDOFF
			POP   {LR}
			  ;sleep(10);
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L2
			SUBS  R6, #1
			BNE   L2
			  ;n = n - 1
			SUB   R4, #1 
			SUBS  R0, #1 
			BNE   GTF 
			;}
			;if ( n != 0 ) {
			;  cont2( n, R0); // to 'print' dots
			; }
			B     cont2 
check0
			ADDS   R4, #0
			BEQ    endroutine
		   ;} // end of GTF function

Is0        ;void Is0( int n, int R0 ) { 
cont1
            ;for( i=0; i<n; i++) { // 'prints' dashes
			  ;LEDON();
			  ;sleep(10);
			PUSH  {LR}
			BL    LEDON
			POP   {LR}
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L3
			SUBS  R6, #1
			BNE   L3
			  ;LEDOFF();
			  ;sleep(10);
			PUSH  {LR}
			BL	  LEDOFF
			POP   {LR}
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L4 
			SUBS  R6, #1
			BNE   L4
			SUBS  R4, #1 
			BNE   cont1
			;} // end of for loop
			BEQ	  endroutine
		   ;} // end of Is0 function
		   
cont2 	   ;void const2( int n, int R0 ) {
            ;for( i=0; i<n; i++) { // 'prints' dots
			 ;LEDON();
			 ;sleep(5);
			PUSH  {LR}
			BL	  LEDON
			POP   {LR}
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L5
			SUBS  R6, #1
			BNE   L5
			 ;LEDOFF();
			 ;sleep(5);
			PUSH  {LR}
			BL    LEDOFF
			POP   {LR}
			MOV   R6, #0x0000ffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L6
			SUBS  R6, #1
			BNE   L6
			SUBS  R4, #1
			BNE   cont2 
			;} // end of loop
			B     endroutine
		   ;} // end of cont2 function
		
LTS        ;void LTS( int n, int R0) {
            ;for( i=0; i<R0; i++) { // 'prints' dots
			  ;LEDON();
			PUSH  {LR}
			BL    LEDON
			POP   {LR}
			  ;sleep(5);
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L7
			SUBS  R6, #1
			BNE   L7
			  ;LEDOFF();
			PUSH  {LR}
			BL    LEDOFF
			POP   {LR}
			  ;sleep(5);
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L8
			SUBS  R6, #1
			BNE   L8
			  ;n = n - 1;
			SUB   R4, #1 
			SUBS  R0, #1 
			BNE	  LTS 
			;} // end of for loop
			B     check0 
			; Is0( n, R0); to 'print' the dashes
endroutine 
            POP {R0, R4, R6}
			BX	LR
		   ;} // end of LTS function

			
		
fib		
	; Your code goes here!

; Call this function first to set up the LED
LEDSETUP
				PUSH  {R4, R5} ; To preserve R4 and R5
				LDR   R4, =ten ; Load the value 1 << 10
				LDR		R5, =SCGC5
				STR		R4, [R5]
				
				LDR   R4, =eight
				LDR   R5, =PCR22
				STR   R4, [R5]
				
				LDR   R4, =twentytwo
				LDR   R5, =PDDR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR

; The functions below are for you to use freely      
LEDON				
				PUSH  {R4, R5}
				LDR   R4, =twentytwo
				LDR   R5, =PCOR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
LEDOFF				
				PUSH  {R4, R5}
				LDR   R4, =twentytwo
				LDR   R5, =PSOR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
; This function delays the processor by 0x00ffffff cycles
Delay
				PUSH  {R4}
				LDR   R4,=0x00ffffff
Delay1
				SUBS  R4, #1
				BNE   Delay1
				POP   {R4}
				BX    LR
				
forever
			B		forever						; wait here forever	
			END
 				
