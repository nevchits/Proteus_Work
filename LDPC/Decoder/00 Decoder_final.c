 const short num = 32;
 bit rxStart, decodeCollect;
 char rxchar, i = 0, flag = 0,feedflag = 0, uart_rd; // Variable for storing the data from UART and array counter
 unsigned char rxarray[num], rxstore[num];   // array to store the received charaters
 char HighNibble, HighNibbleShifted, LowNibble, TestByte, FinalByte;
  bit one_run;     //flag to limit operations to one each. placed because of
                      //the endless loop
 int j, k;

 sbit decode_flag at RD0_Bit;

 ///////////////////////For Decoding///////////////////////////////
 bit p1, p2, p4, preserved;     //parity bit variables
bit pcheck1, pcheck2, pcheck4;
bit test1, test2, test4;
unsigned short shiftTemp1, shiftedMessage;
 ////////////////////////////////////////////////////////////////////

 void nibble(char nibbledHigh, char nibbledLow);
 char HammingDecode(char message);

void interrupt () {
  if (PIR1.RCIF) {          // test the interrupt for uart rx
    feedflag = 0;
    rxchar = UART1_Read();  //
    if (rxStart) {
    rxarray[i] = rxchar;
    i++;
    } //end if rxStart
    // ******************************************************
    if (rxchar == 2) {  // act when you receive "start of text" command
      rxStart = 1;
       } // end if (rxchar == 2)

    if (rxchar == 3) {  // act when you receive "end of text" command
      rxStart = 0;
      flag = 1;
      } // end if (rxchar == 3)
    }
     if (INT0IF_Bit) {         //for the Encode Button
     decode_flag=~decode_flag;  //toggle flag when button is pressed
     one_run = 0;
     INT0IF_Bit = 0;
     }
  } // end interrupt


void main () {

 INT0IE_Bit=1;              //Enable RB0 interrupt
 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 PIE1.RCIE = 1; //enable interrupt.
 Delay_ms(20);
 rxStart = 0;
 decodeCollect = 0;
 UART1_Init(9600);
 PSPMODE_Bit = 0;           //certaining that PORTD is general I/O
 one_run = 0;

 PORTD = 0;
 TRISD = ~7;
 PORTD = 7;             //test LEDs by flashing them once.
 delay_ms(1000);
 PORTD = 0;


 UART1_Write_Text("Rita M.\r\nHIT400 Project\r\nReady to receive... \r\n");

 while(1) {   // Begin endless loop

  if (flag ==1) {
    j = 0;
    k = 0;

//decoding
 if (decode_flag) nibble(rxarray[0], rxarray[1]);
 else UART1_Write_Text(rxarray);
 
 i = 0;
 flag = 0;
  }
 } // end while
} // end main

void nibble(char nibbledHigh, char nibbledLow){    //nibble extractor

HighNibble = HammingDecode(nibbledHigh);

LowNibble = HammingDecode(nibbledLow);

HighNibble <<=4;
FinalByte = HighNibble + LowNibble;
UART1_Write(FinalByte);
}

char HammingDecode(char message){

pcheck1 = message.B2 ^ message.B4;
pcheck1 = pcheck1 ^ message.B6;

pcheck2 = message.B2 ^ message.B5;
pcheck2 = pcheck2 ^ message.B6;

pcheck4 = message.B4 ^ message.B5;
pcheck4 = pcheck4 ^ message.B6;

p1 = message.B0;
p2 = message.B1;
p4 = message.B3;

test1 = p1^pcheck1;
test2 = p2^pcheck2;
test4 = p4^pcheck4;

if ((test1^test2)^test4) UART1_Write_Text("Error!");

preserved = message.B2;
message>>=1;
message.B2 = preserved;
message >>=2;

return message;
}
