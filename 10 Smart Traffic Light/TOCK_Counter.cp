#line 1 "C:/Documents and Settings/Neville/My Documents/PROTEUS/10 Smart Traffic Light/TOCK_Counter.c"
#line 1 "c:/documents and settings/neville/my documents/proteus/10 smart traffic light/set_tf2.c"
unsigned short counterA, counterB, delayLenA, delayLenB;
unsigned short delayLen2A, delayLen2B, countOffset;
unsigned long delayLen_msA, delayLen_msB;


unsigned short Set_Traffic() {
 counterB = TMR0;
 counterA = TMR1L;
 delayLenA = 10;
 delayLenB = 10;


 if(counterA>5){

 countOffset = counterA - 5;
 delayLen2A = 2*countOffset;

 delayLenA += delayLen2A;
 }

 if (counterB>5){

 countOffset = counterB - 5;
 delayLen2B = 2*countOffset;
 delayLenB += delayLen2B;
 }
 delayLen_msA = delayLenA*1000;
 delayLen_msB = delayLenB*1000;

 TMR0 = 0;
 TMR1L = 0;
 return delayLen_msA, delayLen_msB;
 }
#line 3 "C:/Documents and Settings/Neville/My Documents/PROTEUS/10 Smart Traffic Light/TOCK_Counter.c"
void default_Seq(){


 PORTB = 0b00010010;
 delay_ms(500);
 PORTB = 0b00001001;
 delay_ms(2000);

 while(1){
 Set_Traffic();
 delay_ms(500);
 PORTB = 0b00100001;
 Vdelay_ms(delayLen_msA);
 PORTA = delayLenA;
 PORTB = 0b00010001;
 delay_ms(500);
 PORTB = 0b00001001;
 delay_ms(500);
 PORTB = 0b00001100;
 Vdelay_ms(delayLen_msB);
 PORTA = delayLenB;
 PORTB = 0b00001010;
 delay_ms(500);
 PORTB = 0b00001001;
 }
}

void main() {


T0SE_bit = 0;
TMR1ON_bit = 1;
T1OSCEN_bit = 1;
TMR1CS_bit = 1;
T0CS_bit = 1;


PORTA = 0x00;
PORTB = 0x00;
TRISA = 0xF0;
TRISB = 0x00;
TMR0 = 0;
TMR1L= 0;


default_Seq();



}
