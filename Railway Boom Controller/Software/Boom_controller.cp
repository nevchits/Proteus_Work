#line 1 "C:/Documents and Settings/Neville/My Documents/PROTEUS/19 Railway boom Controller/Software/Boom_controller.c"
sbit boom_down at RC4_bit;
sbit boom_up at RC5_bit;

unsigned int proc_timer;
#line 1 "c:/documents and settings/neville/my documents/proteus/19 railway boom controller/software/boom_lcd.c"


sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;


bit LCDWriteFlag;
char i;


void write_LCD(){
 lcd_cmd(_lcd_clear);
 lcd_out(1,1, "No Train");
 lcd_out(2,1, "Ready...");
}
#line 1 "c:/documents and settings/neville/my documents/proteus/19 railway boom controller/software/boom_7seg.c"

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
PORTC = 0xF0 & 0;


 for (i=(countD+1);i>0;i--){
 inttostr(i-1,counting);
 LCD_OUT(2,1,"                ");
 LCD_OUT(2,7, counting);
 LCD_OUT(2,1,"time: ");
 LCD_OUT(2,13,"s");
 tens = (i-1)/10;
 units = (i-1)%10;
 seg_tens = 1;
 PORTC = 0xF0 | tens;
 delay_ms(5);
 seg_tens = 0;
 seg_units = 1;
 PORTC = 0xF0 | units;
 seg_units = 0;
 PORTC = 0xF0 & 0;
 delay_ms(994);
 }

}
#line 1 "c:/documents and settings/neville/my documents/proteus/19 railway boom controller/software/vehicle_sensor.c"



sbit tr_off at RB0_Bit;
sbit car_off at RB1_Bit;
sbit car_bridge at RB2_Bit;
sbit tr_appr at RB3_Bit;
sbit car_appr at RB4_Bit;
sbit tr_bridge at RB5_Bit;
sbit tr_warn at RB6_Bit;


bit tr_warn_flag, tr_appr_flag, tr_bridge_flag, tr_off_flag;
bit car_appr_flag, car_bridge_flag, car_off_flag;
bit tr_stop_flag, tf_stop_flag;
#line 1 "c:/documents and settings/neville/my documents/proteus/19 railway boom controller/software/traffic_control.c"


sbit tf_red at RA0_Bit;
sbit tf_amber at RA1_Bit;
sbit tf_green at RA2_Bit;
sbit tr_stop at RA3_Bit;
const short red = 1, amber = 2, green = 4;




void tf_test() {
 PORTA = 0;
 TRISA = 0;
 PORTA =0xFF;
 delay_ms(500);
 PORTA = 0;
 }

void tf_stop()
 {

 delay_ms(250);
 PORTA |= amber;
 boom_down = 1;
 boom_up = 0;
 delay_ms(3000);
 PORTA |= red;
 }
#line 11 "C:/Documents and Settings/Neville/My Documents/PROTEUS/19 Railway boom Controller/Software/Boom_controller.c"
void init_main(), interrupt();



void main() {


 TRISB = 127;
 PORTC = 0;
 TRISC = 0;
 TRISD = 0;
 PORTD = 0;
 TRISD = 0;

 ADCON1 = 7;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 TRISB7_Bit = 0;
 proc_timer = 0;



 TMR0H = 0;
 TMR0L = 0;
 T0CON = 0;
 T08BIT_bit = 1;

 TMR0ON_bit = 1;
 TMR0IF_bit = 0;
 TMR0IE_bit = 1;

 INTEDG2_bit = 0;
 INT2IE_bit = 1;
 car_bridge_flag = 0;

 GIE_Bit = 1;


 tr_warn_flag = 1;
 tr_appr_flag = tr_bridge_flag = tr_off_flag = car_appr_flag = 1;
 car_bridge_flag = car_off_flag = tr_stop_flag = tf_stop_flag = 1;


 TRISC = 0;
 TRISD = 0;
 PORTC = 0;


 lcd_cmd(_LCD_CLEAR);
 Lcd_Out(1,1, "MHAZO, M.");
 Lcd_out(2,1,"HIT400");
 delay_ms(1000);
 lcd_cmd(_LCD_CLEAR);
 Lcd_Out(1,1, "BRIDGE TRAFFIC");
 Lcd_out(2,1,"CONTROLLER");
 delay_ms(2000);
 write_LCD();


 PORTA = 0;
 PORTC = 0;
 TRISA = 0;
 PORTA =0xFF;
 PORTC = 8;
 seg_tens = 1;
 seg_units = 1;
 delay_ms(500);
 PORTA = 0;
 LCDWriteFlag = 0;


while(1) {
 while (tr_warn && tr_warn_flag)

 {
 boom_down = 0;
 boom_up = 1;
 PORTA = green;
 delay_ms(100);
 }

 if (!tr_warn && tr_warn_flag)
 {
 tr_warn_flag = 0;
 LCD_Out(1,1,"Train Approaches");
 countDwn = 15;



 LCD_OUT(2,1, "15s Countdown");
 delay_ms(1000);
 countdown(countDwn);
 lcd_cmd(_lcd_clear);

 while (RB1_Bit) {
 if(!car_bridge_flag)
 {

 INTEDG2_Bit = ~INTEDG2_Bit;
 if(!LCDWriteFlag) {
 lcd_cmd(_lcd_clear);
 lcd_out(1,1, "There's a car");
 lcd_out(2,1, "on the bridge!");
 }
 if (tr_stop_flag) {
 tr_stop = 1;
 tr_stop_flag = 0;
 }
 }

 if (tf_stop_flag) {
 tf_stop();
 tf_stop_flag = 0;
 }


 if(!tr_stop_flag){
 if (!LCDWriteFlag) {
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"Train Stopped.");
 }
 }
 LCDWriteFlag = 1;
 }
 }

 lcd_cmd(_lcd_clear);


 while(!tr_bridge) {
 tr_bridge_flag = 0;
 if (tr_stop_flag)lcd_out(1,1,"TRAIN ON BRIDGE");
 }
 while(!tr_off && tr_off_flag && !tr_bridge_flag)
 {
 tr_off_flag = 0;

 }
 while(tr_off && !tr_off_flag)
 {
 tr_off_flag = 1;
 tr_warn_flag = 1;
 tr_bridge_flag = 1;
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"Train Passed");
 delay_ms(500);
 PORTA |= green;
 boom_up = 1;
 boom_down = 0;
 write_LCD();
 }

 }

}



void interrupt()
 {
 if (TMR0IF_bit)
 {TMR0IF_bit = 0;
 proc_timer++;
 if (proc_timer == 1953)
 {
 RB7_bit=~RB7_bit;
 proc_timer = 0;
 }
 }

 if (INT2IF_Bit) {
 INT2IF_bit = 0;
 car_bridge_flag = ~car_bridge_flag;
 }
 }
