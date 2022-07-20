	.text
;  From Jason Allred

	.align 2
	.global main
main:
; Light the red LED on pin 1.0 when SW2 on p1.4 is released
; Initialize port 1
; Store address of P1IN in R7, P1OUT in R8, P1DIR in R9, P1REN in R10
; P1SEL0 (adr 40004C0A) & P1SEL1 (adr 40004C0C) are already initialized
; to 00 (GPIO) by reset
	MOV R7, #4c00h ; Put lower half-word of P1IN in R7
	MOVT R7, #4000h ; 4000h is upper half-word, R7 now holds 32 bit
                          ; address of P1IN
	MOV R8, #4c02h ; Put lower half-word of P1OUT in R8
	MOVT R8, #4000h ; 4000h is upper half-word, R8 now holds 32 bit
							  ; address of P1OUT
	MOV R9, #4c04h ; Put lower half-word of P1DIR in R9
	MOVT R9, #4000h ; 4000h is upper half-word, R9 now holds 32 bit
							  ; address of P1DIR
	MOV R10, #4c06h ; Put lower half-word of P1REN in R10
	MOVT R10, #4000h ; 4000h is upper half-word, R10 now holds 32 bit
							  ; address of P1REN
	; Set P1.0 as output and P1.4 as input in P1DIR
	MOV R6, #00000001b
	STRB R6, [R9]
	; Enable pull-up resistor on P1.4
	MOV R6, #00010000b
	STRB R6, [R10] ; Enable pull resistor (write 1 to pin 4 of P1REN)
	STRB R6, [R8] ; Make it a pull-up resistor (write 1 to pin 4 of
							  ; P1OUT)
	; Must make pin 4 = 1 every time P1OUT is written
							  ; (for pull-up resistor)!
	; Turn on LED
	MOV R6, #00010001b ; Pin 0 of P1OUT = 1, but pin 4 = 1 (for
									 ; pull-up resistor)
	STRB R6, [R8]
loop:
	; Read SW2 (P1.4)
	LDRB R6, [R7] ; Read 8 bits of port 1
	AND R6, R6, #00010000b ; Mask bit 4
	CMP R6, #00000000b ; See if bit 4 is 0 or 1
	BEQ led_off ; Branch to led_off if bit 4 is 0 (SW2
									 ; pushed)
	; Turn on LED
	MOV R6, #00010001b
	STRB R6, [R8] ; Write 1 to P1.0, but P1.4 is still 1 (for pull-up
							  ; resistor)
	B loop ; Read SW2 again
led_off:
	; Turn off LED
	MOV R6, #00010000b
	STRB R6, [R8] ; Write 0 to P1.0, but P1.4 is still 1 (for pull-up
							  ; resistor)
	B loop ; Read SW2 again
	.end

