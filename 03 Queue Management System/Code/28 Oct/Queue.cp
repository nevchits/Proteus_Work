#line 1 "C:/Documents and Settings/Neville/My Documents/PROTEUS/AAA Mbuwa_Queue Management System/Code/28 Oct/Queue.c"
#line 8 "C:/Documents and Settings/Neville/My Documents/PROTEUS/AAA Mbuwa_Queue Management System/Code/28 Oct/Queue.c"
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


unsigned short const segDig[12] = {63,6,91,79,102,109,125,7,127,111,64,0};




unsigned short i, tokenValue, tokenTens, tokenUnits, counterValue;
bit counter_press_state, PortBCheck, RB_Pressed, RB_State_High, RB_State_Low;
#line 35 "C:/Documents and Settings/Neville/My Documents/PROTEUS/AAA Mbuwa_Queue Management System/Code/28 Oct/Queue.c"
void main() {
PORTA = PORTB = PORTC = PORTD = 0;
TRISB = 0xF0;
TRISD = 0;
TRISC0_Bit = 1;
TRISA4_Bit = 1;


ADCON1 &= 0b11110111;







T0CS_Bit = 1;

TMR0 = 0;

RBIE_bit = 1;




PORTB = 0x0F;
PORTD = segDig[8];
delay_ms(1000);
PORTD = segDig[11];
PORTB = 0;

while(1) {
RB_Pressed = RB4_Bit^RB5_Bit^RB6_Bit^RB7_Bit;
counter_press_state = RBIF_Bit & RB_Pressed;

 if (counter_press_state) {

 tokenValue++;

 if (tokenValue>9) {
 tokenTens++;
 tokenValue = 0;
 }
 RBIF_Bit = 0;

 counterValue = PORTB>>4;
 switch (counterValue)
 {
 case 0b0001: counterValue = 1; break;
 case 0b0010: counterValue = 2; break;
 case 0b0100: counterValue = 3; break;
 case 0b1000: counterValue = 4; break;

 }


 buzzer = 1;
 delay_ms(1000);
 buzzer = 0;

 dig4 = 1;
 PORTD = segDig[counterValue];
 dig4 = 0;


 dig2 = 1;
 PORTD = segDig[tokenValue];
 dig2 = 0;

 dig1 = 1;
 PORTD = segDig[tokenTens];
 dig1 = 0;
 counter_press_state = 0;
 }


 }

}
