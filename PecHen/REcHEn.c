/*******************************************************
This program was created by the
CodeWizardAVR V3.10 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
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

PORTD=0b00000001;
DDRD=0b00000000;

PORTC=0x00;
DDRC=0x00;

PORTB=0b00000000;
DDRB=0b00111111;


while (1)
      {  
       
       if (PIND.0 == 1) {
        PORTB.0 = 1; 
        PORTB.1 = 1; 
        PORTB.2 = 1; 
        delay_ms(500);
        PORTB.3 = 1; 
        PORTB.4 = 1; 
        PORTB.5 = 1; 
        delay_ms(500);
        PORTB.0 = 1; 
        PORTB.2 = 1; 
        PORTB.4 = 1; 
        delay_ms(500);
        PORTB.1 = 1; 
        PORTB.3 = 1; 
        PORTB.5 = 1; 
        delay_ms(500); 
       
         
              PORTB.0 = 1; 
        PORTB.1 = 1; 
        PORTB.2 = 1; 
        PORTB.3 = 1; 
        PORTB.4 = 1; 
        PORTB.5 = 1;  
        delay_ms(500);
        PORTB.0 = 0; 
        PORTB.2 = 0; 
        PORTB.4 = 0; 
        PORTB.1 = 0; 
        PORTB.3 = 0; 
        PORTB.5 = 0; 
        delay_ms(500); 
         };
      }
}
