//7 segment display module
short tens;
short units;
short countDwn;
sbit seg_tens at RD0_Bit;
sbit seg_units at RD1_Bit;

int iterate;

void init_seg() {
TRISC = 0;
TRISD = 0;
PORTC = 0;
}

void testseg(){
PORTC = 0;
PORTC = 8;
seg_tens = 1;
seg_units = 1;
delay_ms(500);
PORTC = 0;
}

void countdown(int countD) {
char counting[7];
PORTC = 0xF0 & 0;          //Clear Segments, preserve PORTC4-7


  for (i=(countD+1);i>0;i--){
      inttostr(i-1,counting);
      LCD_OUT(2,1,"                ");
      LCD_OUT(2,7, counting);
      LCD_OUT(2,1,"time: ");
      LCD_OUT(2,13,"s");
      tens = (i-1)/10;
      units = (i-1)%10;
      seg_tens = 1;              //select the "tens" seven segment digit
      PORTC = 0xF0 | tens;
      delay_ms(5);
      seg_tens = 0;
      seg_units = 1;             //select the "units" seven segment digit
      PORTC = 0xF0 | units;
      seg_units = 0;
      PORTC = 0xF0 & 0;       //Clear contents to Segments, preserve PORTC4-7
      delay_ms(994);
      }

}
