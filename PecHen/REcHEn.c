/*******************************************************
This program was created by the
CodeWizardAVR V3.10 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 16.12.2015
Author  : 
Company : 
Comments: 


Chip type               : ATmega8
Program type            : Application
AVR Core Clock frequency: 4,000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include <mega8.h>
#include <delay.h>

void main(void)
{
	/*
		0: default mode, all diods blink
		1: switch 1 by 1 to right
		2: switch 1 by 1 to left
		3: snake move
		4: deviation indicator
	*/
	int MODE = 0;

	PORTD=0b00000001;
	DDRD=0b00000000;

	PORTC=0x00;
	DDRC=0x00;

	PORTB=0b00000000;
	DDRB=0b00111111;


	while (1){
		//debugging
		PORTB.6 = 1;
		PORTB.7 = 1;

		// checking button state, changing mode if needed
		// 1 is off, 0 is on
		if (PIND.0 == 1){
			if (MODE>=3){//should be variable
				MODE = 0;
			}else{
				MODE = MODE + 1;
			}
		}

		// party time !!!

		// resetting state
		PORTB.0 = 0; 
		PORTB.1 = 0; 
		PORTB.2 = 0; 
		PORTB.3 = 0; 
		PORTB.4 = 0; 
		PORTB.5 = 0; 

		switch(MODE){
			case 0:
				PORTB.0 = 1;
				PORTB.1 = 1;
				PORTB.2 = 1;
				PORTB.3 = 1;
				PORTB.4 = 1;
				PORTB.5 = 1;
				delay_ms(500);
				PORTB.0 = 0;
				PORTB.1 = 0;
				PORTB.2 = 0;
				PORTB.3 = 0;
				PORTB.4 = 0;
				PORTB.5 = 0;
				delay_ms(500);
				break;
			case 1:
				// turning on 1st indicator
				PORTB.0 = 1; 
				delay_ms(100);
				
				// turning off 1st indicator, turning on 2nd indicator
				PORTB.0 = 0;
				PORTB.1 = 1; 
				delay_ms(100);
				
				// turning off 2nd indicator, turning on 3rd indicator
				PORTB.1 = 0;
				PORTB.2 = 1; 
				delay_ms(100);

				// same ...
				PORTB.2 = 0;
				PORTB.3 = 1; 
				delay_ms(100);

				PORTB.3 = 0;
				PORTB.4 = 1; 
				delay_ms(100);

				PORTB.4 = 0;
				PORTB.5 = 1; 
				delay_ms(100);

				// turning off last indicator
				PORTB.5 = 0;
				delay_ms(100);
				
				break;
			case 2:

				// turning on last indicator
				PORTB.5 = 1; 
				delay_ms(100);

				PORTB.5 = 0;
				PORTB.4 = 1; 
				delay_ms(100);

				PORTB.4 = 0;
				PORTB.3 = 1; 
				delay_ms(100);

				PORTB.3 = 0;
				PORTB.2 = 1; 
				delay_ms(100);

				PORTB.2 = 0;
				PORTB.1 = 1; 
				delay_ms(100);

				PORTB.1 = 0;
				PORTB.0 = 1; 
				delay_ms(100);
				
				// turning off first indicator
				PORTB.0 = 0;
				delay_ms(100);
				
				break;
			case 3:
				PORTB.0 = 1; 
				delay_ms(100);
				PORTB.1 = 1; 
				delay_ms(100);
				PORTB.2 = 1; 
				delay_ms(100);

				PORTB.0 = 0;
				PORTB.3 = 1; 
				delay_ms(100);
				PORTB.1 = 0;
				PORTB.4 = 1; 
				delay_ms(100);

				PORTB.2 = 0;
				PORTB.5 = 1; 
				delay_ms(100);

				PORTB.3 = 0;
				delay_ms(100);

				PORTB.4 = 0;
				delay_ms(100);

				PORTB.5 = 0;
				delay_ms(100);

				break;
			default:
				PORTB.0 = 1; 
				delay_ms(500);
				PORTB.0 = 0;
		}
	}
}