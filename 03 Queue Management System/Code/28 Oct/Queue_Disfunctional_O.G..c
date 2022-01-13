/*
  Date: 28 October 2013
  Authors: N. Nyandoro - +26373
  and N. Chitiyo - +263734005590

*/

sbit dig1 at RB0_Bit;
sbit dig2 at RB1_Bit;
sbit dig3 at RB2_Bit;
sbit dig4 at RB3_bit;
sbit buzzer at RD7_Bit;
sbit token at RA4_Bit;
sbit counter at RC0_Bit;
sbit counter1 at RB4_bit;
sbit counter2 at RB5_Bit;
sbit counter3 at RB6_Bit;
sbit counter4 at RB7_Bit;

//seven segment referrence array. order: {0,1,2,3,4,5,6,7,8,9,-,<blank>}
unsigned short const segDig[12] = {63,6,91,79,102,109,125,7,127,111,64,0};

//unsigned short counterSelectArray[4];
//long digSel[4] = {dig1,dig2,dig3,dig4};

unsigned short i, tokenValue, counterValue;
bit counter_press_state;

void interrupt()
{
 GIE_bit = 0;
 RBIE_Bit = 0;
    if (RBIF_bit){
    RBIF_Bit = 0;
    counter_press_state = 1;
    counterValue = PORTB;
    }
 GIE_Bit = 1;
}

void counter_select ()
{
 if (counter_press_state) {
         buzzer = 1;
         delay_ms(1000);
         buzzer = 0;

         counter_press_state = 0;

  }//if
         counterValue = counterValue>>4;   //only RB4..7 values are important
         switch (counterValue)
         {
                case 0b0001:  counterValue = 1; break;
                case 0b0010:  counterValue = 2; break;
                case 0b0100:  counterValue = 3; break;
                case 0b1000:  counterValue = 4; break;
                default:      counterValue = 0; break;
         }//switch
  return counterValue;
}


void main() {
PORTA = PORTB = PORTC = PORTD = 0;
TRISB = 0xF0;
TRISD = 0;
TRISC0_Bit = 1;
TRISA4_Bit = 1;
ANS4_Bit = 0;  //pin RA4 set as digital

T0CS_Bit = 1;        //set TIMER0 as counter (counting on Pin RA4)
IOCB = 0xF0;         //set RB4..7 as interrupt sources
TMR1CS_bit = 1;      //set TMR1 as a counter incremented by pin RC0
TMR0 = 0;
TMR1L = TMR1H = 0;

RBIE_bit = 1;
GIE_bit = 1;


/***TEST*/
PORTB = 0x0F;
PORTD = segDig[8];   //flash '8' on all digits for one second
delay_ms(1000);
PORTD = segDig[0];
PORTB = 0;

while(1) {
//tokenValue = TMR0;

//remember to add the tens_units converter routine!!!!
 counter_select();
 dig4 = 1;
 PORTD =  segDig[counterValue]; //to read: units(segDig[counter_select()]);
 dig3 = 1;
//PORTD = segDig[counter_select()];  //to read: tens(segDig[counter_select()]);

 PORTD = segDig[0];

// dig2 = 1;
// PORTD = segDig[tokenValue];         //to read: units(segDig[tokenvalue]);
 //dig1 = 1;
 //PORTD = segDig[tokenvalue];         //to read: tens(segDig[tokenvalue]);

 }//while




}
