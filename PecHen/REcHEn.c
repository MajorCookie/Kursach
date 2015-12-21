/*******************************************************
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
		0: Default mode, all diods blink
		1: Switch 1 by 1 to right
		2: Switch 1 by 1 to left
		3: Snake move  
        4: Blink alternately odd and even LEDs
        4: Sequencing LEDs (one, two, blink)
	*/
	int MODE = 0;

	PORTD=0b00000001;
	DDRD=0b00000000;

	PORTC=0x00;
	DDRC=0x00;

	PORTB=0b00000000;
	DDRB=0b00111111;


	while (1){

		// checking button state, changing mode if needed
		// 1 is off, 0 is on
		if (PINC.0 == 0){
			MODE++; //increasing mode variable
			if (MODE>=6){
				MODE = 0; //resetting mode if we're out of em
			}
			PORTB.0 = 1; 
			PORTB.1 = 1; 
			PORTB.2 = 1; 
			PORTB.3 = 1; 
			PORTB.4 = 1; 
			PORTB.5 = 1;
			delay_ms(1500);
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
				{
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
				}
			case 1:
				{
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
					delay_ms(100);
                    PORTB.5 = 1;
                    PORTB.4 = 0;
                    delay_ms(100);
                    PORTB.4 = 1;
                    PORTB.3 = 0;
                    delay_ms(100);
                    PORTB.3 = 1;
                    PORTB.2 = 0;
                    delay_ms(100);
                    PORTB.2 = 1;
                    PORTB.1 = 0;
                    delay_ms(100);
                    PORTB.1 = 1;
                    PORTB.0 = 0;
                    delay_ms(100);
                    PORTB.0 = 1;
                    delay_ms(100);
					
					break;
				}
			case 2:
				{
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
				}
			case 3:
				{
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
				}     
            case 4:
                {
                  PORTB.0 = 1;
				  PORTB.1 = 0;
				  PORTB.2 = 1;
				  PORTB.3 = 0;
				  PORTB.4 = 1;
				  PORTB.5 = 0;
				  delay_ms(100);
				  PORTB.0 = 0;
			  	  PORTB.1 = 1;
				  PORTB.2 = 0;
				  PORTB.3 = 1;
				  PORTB.4 = 0;
				  PORTB.5 = 1;
				  delay_ms(100);
				  break;
                }       
            case 5:
                {
                  PORTB.0 = 1;
                  PORTB.1 = 1;
				  delay_ms(100);
                  PORTB.0 = 0;
				  PORTB.1 = 0;
				  PORTB.2 = 1;
                  delay_ms(100);
				  PORTB.2 = 0;
				  PORTB.3 = 1;
				  delay_ms(100);
				  PORTB.3 = 0;
			  	  PORTB.4 = 1;
                  delay_ms(100);
				  PORTB.4 = 0;
				  PORTB.5 = 1;
                  delay_ms(100);
				  PORTB.5 = 0;
				  delay_ms(100);
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
                  
                  PORTB.0 = 1;
                  PORTB.1 = 1;
				  delay_ms(100);
                  PORTB.0 = 0;
				  PORTB.1 = 0;
				  PORTB.2 = 1;
                  delay_ms(100);
				  PORTB.2 = 0;
				  PORTB.3 = 1;
				  delay_ms(100);
				  PORTB.3 = 0;
			  	  PORTB.4 = 1;
                  delay_ms(100);
				  PORTB.4 = 0;
				  PORTB.5 = 1;
                  delay_ms(100);
				  PORTB.5 = 0;
				  delay_ms(100);
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
                  
                  PORTB.0 = 1;
                  PORTB.1 = 1;
				  delay_ms(300);
                  PORTB.0 = 0;
				  PORTB.1 = 0;
                  PORTB.2 = 1;
                  PORTB.3 = 1;
                  delay_ms(300);
				  PORTB.2 = 0;
				  PORTB.3 = 0;
                  PORTB.4 = 1;
                  PORTB.5 = 1;
				  delay_ms(300);
				  PORTB.4 = 0;
			  	  PORTB.5 = 0;
                  PORTB.3 = 1;
                  PORTB.2 = 1;
                  delay_ms(300);
				  PORTB.3 = 0;
				  PORTB.2 = 0;
                  PORTB.1 = 1;
                  PORTB.0 = 1;
                  delay_ms(300);
                  PORTB.1 = 0;
				  PORTB.0 = 0;
				  delay_ms(300);        
                  
                  PORTB.0 = 1;
                  PORTB.1 = 1;
				  delay_ms(300);
                  PORTB.0 = 0;
				  PORTB.1 = 0;
                  PORTB.2 = 1;
                  PORTB.3 = 1;
                  delay_ms(300);
				  PORTB.2 = 0;
				  PORTB.3 = 0;
                  PORTB.4 = 1;
                  PORTB.5 = 1;
				  delay_ms(300);
				  PORTB.4 = 0;
			  	  PORTB.5 = 0;
                  PORTB.3 = 1;
                  PORTB.2 = 1;
                  delay_ms(300);
				  PORTB.3 = 0;
				  PORTB.2 = 0;
                  PORTB.1 = 1;
                  PORTB.0 = 1;
                  delay_ms(300);
                  PORTB.1 = 0;
				  PORTB.0 = 0;
				  delay_ms(300); 
                  
                  PORTB.0 = 1;
				  PORTB.1 = 0;
				  PORTB.2 = 1;
				  PORTB.3 = 0;
				  PORTB.4 = 1;
				  PORTB.5 = 0;
				  delay_ms(100);
				  PORTB.0 = 0;
			  	  PORTB.1 = 1;
				  PORTB.2 = 0;
				  PORTB.3 = 1;
				  PORTB.4 = 0;
				  PORTB.5 = 1;
				  delay_ms(100);          
				  break;  
                  
                  PORTB.0 = 1;
				  PORTB.1 = 0;
				  PORTB.2 = 1;
				  PORTB.3 = 0;
				  PORTB.4 = 1;
				  PORTB.5 = 0;
                  PORTB.0 = 0;
			  	  PORTB.1 = 1;
				  PORTB.2 = 0;
				  PORTB.3 = 1;
				  PORTB.4 = 0;
				  PORTB.5 = 1;
				  delay_ms(100);
				  PORTB.0 = 0;
			  	  PORTB.1 = 1;
				  PORTB.2 = 0;
				  PORTB.3 = 1;
				  PORTB.4 = 0;
				  PORTB.5 = 1;
                  PORTB.0 = 1;
				  PORTB.1 = 0;
				  PORTB.2 = 1;
				  PORTB.3 = 0;
				  PORTB.4 = 1;
				  PORTB.5 = 0;
				  delay_ms(100);
                  
                }
			default:
				{
					PORTB.0 = 1; 
					delay_ms(500);
					PORTB.0 = 0;
				}
		}
	
	
	}
}