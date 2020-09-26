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
	; Your code goes here!
			MOV   R3, #7
			MOV   R7, #19
			MOV   R1, #0xbeef
			
			BL    LEDSETUP
			MOV   R6, #0xffff

			
L0 ; delay a bit
			SUBS  R6, #1
			BNE   L0
			MOV   R0, #5 ; our test number | int test = value(R0)
			MOV   R2, #5 ; total of 5 dashes and dots in the morse code sequence | int tot = 5;
			ADDS  R0, #0
			BEQ   Is0 ; if(test == 0) {do 5 dashes}
			CMP   R0, #6; 
			BMI   LTS
			; if(test < 6) {do n dots where n is equal to the number}
			; else if(test > 5) {do n dashes where n is equal to test - 5}
			SUB   R0, #5 ; test = test -5;
GTF			;while(test>0)
			; do 'k' dashes where 'k' is the initial number in R0 - 5
			; toggle LED sequence
			BL    LEDON
			; no ops to make the LED turn on longer
			MOV   R6, #0xffff ;count down using 6*0xffff for delay
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L1 ; xffff * 6 cycle delay for visibility
			SUBS  R6, #1
			BNE   L1
			BL	  LEDOFF
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L2 ; xffff * 6 cycle delay for visibility
			SUBS  R6, #1
			BNE   L2
			SUB   R2, #1 ; total = total - 1; decrement the total number of morse code symbols left |
			SUBS  R0, #1 ; test = test - 1; decrement the total number of dashes left
			BNE   GTF ; loop if we still need more dashes
			B     cont2 ; else go the the dot sequence
check0 ;if(total = 0) check if R2 is already 0 in case of input "5"
			ADDS   R2, #0
			BEQ    finish ; finish the program
Is0 ; If the input is 0 | if(test == 0) {do 5 dashes}
cont1 ; dash sequence for numbers less than 6
	  ; toggle LED sequence
			BL    LEDON
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L3 ; xffff * 6 cycle delay for visibility
			SUBS  R6, #1
			BNE   L3
			BL	  LEDOFF
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L4 ; xffff * 6 cycle delay for visibility
			SUBS  R6, #1
			BNE   L4
			SUBS  R2, #1 ; decrement total number of morse code symbols left
			BNE   cont1 ; loop if we still need more dashes
			BEQ	  finish ; else finish the program
cont2 ; for(total>0) ; dot sequence for numbers greater than 5 (or special case 0)
			; NOP operations to make LED stay on
			; toggle LED sequence
			BL	  LEDON
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L5 ; xffff * 4 cycle delay for visibility
			SUBS  R6, #1
			BNE   L5
			BL    LEDOFF
			MOV   R6, #0x0000ffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L6 ; xffff * 6 cycle delay for visibility
			SUBS  R6, #1
			BNE   L6
			SUBS  R2, #1 ; total = total - 1 decrement total number of morse code symbols left
			BNE   cont2 ; loop if we still need more dots
			;else {finish the program}
finish
			B     forever ;program ends
		; if number is less than 6
LTS ;while(test > 0)
			; do 'n' dots where 'n' is the number in r0
			; toggle LED sequence
			BL    LEDON
			; NOP operations to make LED stay on
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L7 ; xffff * 4 cycle delay for visibility
			SUBS  R6, #1
			BNE   L7
			BL    LEDOFF
			MOV   R6, #0xffff
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
			ADD   R6, R6
L8 ; xffff * 6 cycle delay for visibility
			SUBS  R6, #1
			BNE   L8
			SUB   R2, #1 ;total = total-1; decrement the number of symbols left
			SUBS  R0, #1 ; test = test-1; tdecretment the number of dots left
			BNE	  LTS ; loop if we still need dots
			B     check0 ; else go the the dash sequence			
		
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
				
forever
			B		forever						; wait here forever	
			END
 				
