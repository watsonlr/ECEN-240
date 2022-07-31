
#include "msp.h"
#define LED2_RED    BIT0
#define LED2_GREEN  BIT1
#define S1          BIT1
#define S2 BIT4
#define DELAY 500
int i;


/**
 * main.c
 */
void main(void)
    {
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;		// stop watchdog timer

	P1->DIR &= ~(S1 | S2);              // Set Pl.1 and Pl.4 as input
	P1->REN = S1 | S2;                  // Enable pull-up/down resistor for Pl.1 and Pl.4
	P1->OUT = S1 | S2;                  // Pull-up/down resistor is set as pull-up
	P2->DIR = LED2_RED | LED2_GREEN;    // Set P2.0 and P2.1 as output
	P2->OUT = 0x00;                     // LED2 is turned off

	while(1)
        {
        if((P1->IN & S1) == 0x00)   // Active low input
            {
            for(i=0;i<DELAY;i++){}  // Delay for debounce
            if( (P1->IN & S1) == 0x00)  // If button is pressed
                {
                P2->OUT ^= LED2_RED;    // Toggle P2.0
                while((P1->IN & S1) == 0x00); // Wait until S1 is released
                }
            }
           // Now S1 is released
        if((P1->IN & S2) == 0x00)
            {
            for(i=0;i<DELAY;i++){}  // Delay for debounce
            if( (P1->IN & S2) == 0x00)
                {
                P2->OUT ^= LED2_GREEN;// Toggle P2.1
                while((P1->IN & S2) == 0x00); // Wait until S2 is released
                }
            }
        }
    }
