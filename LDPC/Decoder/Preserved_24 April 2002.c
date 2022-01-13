 const short num = 32;
 bit rxStart, decodeCollect;
 char rxchar, i = 0, flag = 0,feedflag = 0, uart_rd; // Variable for storing the data from UART and array counter
 unsigned char rxarray[num], rxstore[num];   // array to store the received charaters
 char HighNibble, HighNibbleShifted, LowNibble, TestByte, FinalByte;
 
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
    //IRP_Bit = 1;

    rxarray[i] = rxchar;


    if (rxStart) {
    rxarray[i] = rxchar;
    //rxarray[i] = rxchar; // old normal statement
    if (i!=0 && i%2) decodeCollect =1;
    else decodeCollect = 0;
    i++;
    }
    // ******************************************************
    if (rxchar == 2) {  // act when you receive "start of text" command
      rxStart = 1;
       } // end if (rxchar == 2)

    if (rxchar == 3) {  // act when you receive "end of text" command
      rxStart = 0;
      flag = 1;
      } // end if (rxchar == 3)


    }
  } // end interrupt


void main () {
unsigned short j, k;

 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 PIE1.RCIE = 1; //enable interrupt.
 Delay_ms(20);
 rxStart = 0;
 decodeCollect = 0;
 UART1_Init(9600);


 UART1_Write_Text("Ready to receive... ");

 while(1) {   // Begin endless loop

  if (flag ==1) {
    j = 0;
    k = 0;

//encoding
    UART1_Write_Text("\r\n Received characters:\r\n");
    while(j < (i-1)) {
    //UART1_Write(rxarray[j]);
    while(decodeCollect) {
    nibble(rxarray[j-1],rxarray[j]);
    }
    j++;
   } // end while(rxarray[i])

    i = 0;
    flag = 0;
  } // end if (flag);
 } // end while
} // end main

void nibble(char nibbledHigh, char nibbledLow){    //nibble extractor

HighNibble = HammingDecode(nibbledHigh);

LowNibble = HammingDecode(nibbledLow);

HighNibble <<=4;
FinalByte = nibbledHigh + nibbledLow;
UART1_Write(FinalByte);
UART1_Write_Text("\r\n ");
}

char HammingDecode(char message){

pcheck1 = message.B2 ^ message.B4;
pcheck1 = pcheck1 ^ message.B6;

pcheck2 = message.B2 ^ message.B5;
pcheck2 = pcheck2 ^ message.B6;

pcheck4 = message.B4 ^ message.B5;
pcheck4 = pcheck4 ^ message.B6;

preserved = message.B2;
message>>=1;
message.B2 = preserved;
message >>=2;

/*
p1 = message.B2 ^ message.B4;
p1 = p1 ^ message.B6;
message.B0 = p1;

p2 = message.B2 ^ message.B5;
p2 = p2 ^ message.B6;
message.B1 = p2;

p4 = message.B4 ^ message.B5;
p4 = p4 ^ message.B6;
message.B3 = p4;
*/

return message;
}
