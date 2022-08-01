#include "msp.h"
#include "stdint.h"


/**
 * main.c
 * LRW's version for learning
 * Lab 8 ADC
 *
 *
 */

#define ADC_PORT    P4      // Potentiometer output tied to 4.7
#define ADC_BITIN   BIT7    // Potentiometer bit is 7
#define SWITCH_PORT P1      // LEDs are on PORT P1
#define LED_PORT    P1      // Simple_LED is on PORT P1
#define RGBLED_PORT P2      // RGB_LEDs are on PORT P2
#define LED1        BIT0
#define LED2_RED    BIT0    //P2.0
#define LED2_GREEN  BIT1    //P2.1
#define LED2_BLUE   BIT2    //P2.2
#define S1          BIT1    // Switch bit
#define DEBOUNCE_DELAY  1000
#define LED_DELAY       100000

int lowest_bit_of_adc_to_show = 8;
int i; // gp loop counter
int led_3bits =0x0; // only use the last 3, but keep track
int adc_result;

struct ADC14_Control0_struct{
    unsigned int ADC14PDIV      : 2;  //[31:30]
    unsigned int ADC14SHSx      : 2;  //[29:27]
    unsigned int ADC14ISSP      : 1;  //[26]
    unsigned int ADC14ISSH      : 1;  //[25]
    unsigned int ADC14DIVx      : 3;  //[24:22]
    unsigned int ADC14SSELx     : 3;  //[21:19]
    unsigned int ADC14CONSEQx   : 2;  //[18:17]
    unsigned int ADC14BUSY      : 1;  //[16]
    unsigned int ADC14SHT1x     : 4;  //[15:12]
    unsigned int ADC14SHT0x     : 3;  //[11:8]
    unsigned int ADC14MSC       : 1;  //[7]
    unsigned int ADC14reserved1 : 2;  //[6:5]
    unsigned int ADC14ON        : 1;  //[4]
    unsigned int ADC14reserved2 : 2;  //[3:2]  always 00
    unsigned int ADC14ENC       : 1;  //[1]
    unsigned int ADC14SC        : 1;  //[0]
    } ;

                        // 33222222222211111111110000000000
                        // 10987654321098765432109876543210
int ADC14_Control0_off = 0b00000100000010000000001100010000;  // ADC14 off, and disabled
int ADC14_Control0_on  = 0b00000100000010000000001100010000;  // ADC14 on, and enabled
int ADC14_Control1     = 0b00000000000001010000000000100000;  // 20:16 are memory reg:  0b00101
int ADC14_MCTXx        = 0b00000100000000101000000000000110;  //

/*******************/
void cycle_thru()
/*******************/
        {
        // Red
        P2->OUT = LED2_GREEN;// Toggle P2.1
        for(i=0;i<LED_DELAY;i++){}  // Delay for debounce
        P2->OUT = LED2_RED;// Toggle P2.1
        for(i=0;i<LED_DELAY;i++){}  // Delay for debounce
        P2->OUT = LED2_BLUE;// Toggle P2.1
        for(i=0;i<LED_DELAY;i++){}  // Delay for debounce
        }

/*******************/
void main(void)
/*******************/
    {
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;		// stop watchdog timer

    SWITCH_PORT->IFG    = 0x0;          // flag is cleared of any previous
    for(i=0;i<DEBOUNCE_DELAY;i++){}  // Delay for debounce

	// Configure SW1 as an input button
	SWITCH_PORT->DIR &= ~S1;             // Set Pl.1 as input for switch
	SWITCH_PORT->REN = S1;               // Set P1.1 resister enabled
	SWITCH_PORT->OUT = BIT1;               // Set P1.1 resister as pull-up
	SWITCH_PORT->SEL0 = 0x0;               // Set P1.1 resister as GPIO
	SWITCH_PORT->SEL1 = 0x0;               // Set P1.1 resister as GPIO
	SWITCH_PORT->REN = BIT1;                // Set the Switch for  pullup

	// Configure the RGB LED  -- Really only red and green lights in the LED
    RGBLED_PORT->DIR = LED2_RED | LED2_GREEN | LED2_BLUE;    // Set P2.0 and P2.1 as output
    RGBLED_PORT->OUT = 0x00;                     // LED2 is turned off

    LED_PORT->DIR |=   LED1;    // Set P2.0 and P2.1 as output
    LED_PORT->OUT &=  ~LED1;                     // LED1 is turned off

    // Set up an interrupt, so when the button is pushed, something happens
    // Configure an interrupt to happen on SW1 -- pin-level

    SWITCH_PORT->IES    |= S1;          // Set the signal edge to be falling on the port bit
    SWITCH_PORT->IE     |= S1;          // Set the port to be interrupts
    SWITCH_PORT->IFG    = 0x0;          // flag is cleared of any previous
    NVIC->ISER[1]       = 0x00000008;   // Port P1 interrupt is enabled
    // also can be referred to as "PORT1_IRQn"
    _enable_interrupts();               // turn on all interrupts

    // Setup ADC
    // Using Pin 4.7 => ADC14 input channel A6
    // Configure PORT4.7 for analog in:
    ADC_PORT->SEL0 |= ADC_BITIN;
    ADC_PORT->SEL1 |= ADC_BITIN;
    ADC14->CTL0  = ADC14_Control0_off;
    ADC14->CTL1  = ADC14_Control1;

    ADC14->MCTL[5] = 0x06; //Memory register 5 gets input channel 6
                           // Input channel 6 is Port 4.7 with VREF AVCC (3.3Volts), single-ended


    i=0;
    while(1)
        {
        // flash_only();
        // Enable the ADC:
        ADC14->CTL0 |= ADC14_CTL0_ON | ADC14_CTL0_SC | ADC14_CTL0_ENC;        // Start sampling/conversion
        while(!ADC14->IFGR0);   // Wait for conversion complete
        adc_result = ADC14->MEM[5];
        // Output the 3 highest bits
        RGBLED_PORT->OUT = (adc_result & 0xf00)>> lowest_bit_of_adc_to_show;

        }
    }

void flash_only(void) {

        // Just flash on/off
        RGBLED_PORT->OUT = led_3bits;
        for(i=0;i<LED_DELAY;i++){}  // Delay for LED On/Off
        RGBLED_PORT->OUT &= 0x11111000;
        for(i=0;i<LED_DELAY;i++){}  // Delay for LED On/Off
}

void PORT1_IRQHandler(void)
    // This is a reserved name
    {
    int d=0;
    int b=0;
    // Debounce
    // Disable more interrupts here ??

    for(d=0;d<DEBOUNCE_DELAY;d++){}  // Delay for debounce
    if (lowest_bit_of_adc_to_show ==3)
        {
        lowest_bit_of_adc_to_show = 8;
        }
    else
        {
        lowest_bit_of_adc_to_show--;
        }

    led_3bits = (led_3bits + 1) % 8; // only use the last 3, but keep track
    // flash LED1 2 times quickly to show I got here
    LED_PORT->OUT |=  LED1; for(b=0;b<LED_DELAY/10;b++){}  // Delay for LED On/Off
    LED_PORT->OUT &= ~LED1; for(b=0;b<LED_DELAY/10;b++){}  // Delay for LED On/Off
    LED_PORT->OUT |=  LED1; for(b=0;b<LED_DELAY/10;b++){}  // Delay for LED On/Off
    LED_PORT->OUT &= ~LED1; for(b=0;b<LED_DELAY/10;b++){}  // Delay for LED On/Off
    // Clear the interrupt flag
    SWITCH_PORT->IFG    = 0x0;          // flag is cleared of any previous

    }



