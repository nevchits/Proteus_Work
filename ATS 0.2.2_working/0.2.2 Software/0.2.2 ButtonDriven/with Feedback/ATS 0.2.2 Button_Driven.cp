#line 1 "C:/Documents and Settings/Neville/My Documents/PROTEUS/02 ATS/ATS 0.2.2_working/0.2.2 Software/0.2.2 ButtonDriven/with Feedback/ATS 0.2.2 Button_Driven.c"
#line 45 "C:/Documents and Settings/Neville/My Documents/PROTEUS/02 ATS/ATS 0.2.2_working/0.2.2 Software/0.2.2 ButtonDriven/with Feedback/ATS 0.2.2 Button_Driven.c"
unsigned int ProgTimer, RealTimer, RunTimer, CoolDownTimer;
bit Auto_Flag, Run_Flag, CoolDown_Flag;
bit GenFeedFlag;
unsigned int RunTime, CoolDownTime;
unsigned short RBValue, CrankTrials;
#line 73 "C:/Documents and Settings/Neville/My Documents/PROTEUS/02 ATS/ATS 0.2.2_working/0.2.2 Software/0.2.2 ButtonDriven/with Feedback/ATS 0.2.2 Button_Driven.c"
sbit SQOUT at RA0_Bit;
sbit ZESA at RA2_Bit;
sbit feedback at RA4_bit;
sbit GenStop at RB4_Bit;
sbit ChangeOver at RB5_Bit;
sbit GenStart at RB6_Bit;
sbit GenOn at RB7_Bit;


void crank();
void Poll();



void interrupt() {



 GIE_Bit = 0;

 if (T0IF_Bit) {

 T0IF_Bit = 0;
 TMR0 = 0;
 ProgTimer++;

 if (progTimer == 1953)
 {
 RealTimer++;


 if (RunTimer == RunTime) {
 RunTimer = 0;
 Run_flag = 0;
 CoolDown_Flag = 1;
 }

 if (CoolDownTimer == CoolDownTime) {
 CoolDownTimer = 0;

 CoolDown_Flag = 0;
 }


 if (Run_Flag && Feedback) RunTimer++;
 if (CoolDown_Flag) CoolDownTimer++;

 SQOUT=~SQOUT;
 SQOUT=~SQOUT;
 progTimer = 0;
 }
 }
 if (INTF_Bit) {
 INTF_Bit = 0;

 CrankTrials = 6;
 RBValue = 19;
 Auto_Flag = 0;
 Run_Flag = 0;
 }
 GIE_Bit = 1;
}


void main() {


ProgTimer = 0;
RealTimer = 0;
RunTimer = 0;
CoolDownTimer = 0;
Auto_Flag = 0;
Run_Flag = 0;
CoolDown_Flag = 0;
GenFeedFlag = 0;
RunTime = 0;
CoolDownTime = 0;
RBValue = 0;
CrankTrials = 0;




 RunTime = 14388;

 CoolDownTime = 3599;

 PORTA = 0;
 TRISA = 0b10110;
 PORTB = 0;
 TRISB = 0b00001111;

 ADCON1 = 0x07;

 T0IE_Bit = 1;
 INTE_Bit = 1;
 INTEDG_Bit = 1;
 GIE_bit = 1;



 T0CS_Bit = 0;
 TMR0 = 0;
 PSA_Bit = 0;
 OPTION_REG &=248;
 OPTION_REG |=0;




while(1) {

 delay_ms(100);





 if (RBValue != 19) RBValue = PORTB & 0x07;


 if (!Run_flag && CoolDown_flag) RBValue = 19;
#line 212 "C:/Documents and Settings/Neville/My Documents/PROTEUS/02 ATS/ATS 0.2.2_working/0.2.2 Software/0.2.2 ButtonDriven/with Feedback/ATS 0.2.2 Button_Driven.c"
 switch(RBValue) {


 case 4:
 Auto_Flag = 1;
 RBValue = 0;
 if (Auto_Flag) Poll();
 break;

 case 6:
 Auto_Flag = 1;
 RBValue = 0;
 if (Auto_Flag) Poll();
 break;



 case 2:
 Auto_Flag = 0;
 GenStop = 1;
 GenOn = 1;


 GenStart = 1;
 Run_Flag = 1;

 RBValue = 0;
 break;



 case 0:
 GenStart = 0;
 Auto_Flag = 0;
 RBValue = 0;
 break;



 default:
 Auto_Flag = 0;
 delay_ms(2000);
 PORTB = 0;
 delay_ms(5000);
 if (!feedback) Run_Flag = 0;
 RBValue = 0;
 break;
 }


 }

}



void crank() {
GenFeedFlag = feedback;
CrankTrials = 0;
while (!GenFeedFlag && CrankTrials <5) {
 GenStart = 1;
 delay_ms(5000);
 CrankTrials++;
 GenFeedFlag = feedback;
 if (CrankTrials == 5) {
 CrankTrials = 0;
 GenFeedFlag = 1;
 PORTB = 0;
 Run_Flag = 0;
 RBValue = 19;

 }
 else Run_Flag = 1;
GenStart = 0;
}
}


void Poll() {
 if (Auto_Flag && ZESA) {
 delay_ms(2000);
 ChangeOver = 0;
 RBValue = 19;

 }
 else {
 delay_ms(1000);
 if (!Run_flag) {
 if (!CoolDown_Flag) {
 GenStop = 1;
 GenOn = 1;
 crank();
 Delay_ms(5000);


 if (!ZESA && Run_Flag) {
 ChangeOver = 1;
 Run_Flag = 1;
 }
 }
 }
 }
}
