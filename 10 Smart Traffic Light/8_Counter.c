#include "Set_TF3.c"
unsigned short const All_Red = 0x09, NRedEGreen = 0x21, NRedEAmber = 0x11;
unsigned short const NGreenERed = 0x0C, NAmberERed = 0x0A;
//unsigned short const AmberDelay = 5000; //5-second delay. to use 0.5 sec for
                                        //demonstrative purposes now.

void default_Seq(){

     PORTB = All_Red;        //All Red
     delay_ms(2000);
     delayLen =  5;
     delayLen_ms = 5000;    //default length set to 5s for demonstration

  while(1){
  East_Seq:
       PORTB = NRedEGreen;      //NS Red, EW Green
       PORTC = delayLen<<2;       //show delay length on 7 seg display
                                  //shifted twice because of TMR1 Pins
       Vdelay_ms(delayLen_ms);
       PORTB = NRedEAmber;      //NS Red, EW Amber
       Set_North();           //check for traffic count, to set N delay
       delay_ms(500);           //AmberDelay
       PORTB = All_Red;         //NS Red, EW Red
       delay_ms(150);           //SettleDown Delay
       
  North_Seq:
       PORTB = NGreenERed;      //NS Green, EW Red
       PORTC = delayLen<<2;       //Show delay length on 7 Seg Display
                                  //shifted twice because of TMR1 Pins
       Vdelay_ms(delayLen_ms);
       PORTB = NAmberERed;      //NS Amber, EW Red
       Set_East();           //check for traffic count, to set E Delay
       delay_ms(500);           //AmberDelay
       PORTB = All_Red;         //NS Red, EW Red
       delay_ms(150);           //SettleDown Delay
       }
}

void main() {

//initialise ports
PORTA = 0x00;
PORTB = 0x00;
PORTC = 0x00;
TRISA = 0xFF;
TRISB = 0x00;
TRISC = 0x00;
TMR0 = 0;
TMR1L= 0;

//set the Counters
T0SE_bit = 0;    //increment at rising edge of T0CK
TMR1ON_bit = 1;  //timer1 on
T1OSCEN_bit = 0; //timer on RC0
TMR1CS_bit = 1;
T0CS_bit = 1;
T1SYNC_bit = 1;

//run the main sequence please!
default_Seq();



}
