
 const short num = 64;
 char rxchar, i = 0, k = 0, flag = 0,feedflag = 0, character_check;
 short iterate;
 char uart_rd; // Variable for storing the data from UART and array counter
 //bit encode_flag, AWGN_Flag, Test_Flag;    //flags to control operation
 bit one_run;     //flag to limit operations to one each. placed because of
                      //the endless loop
 unsigned char rxarray[num];   // array to store the received charaters

 #include "Hamming Nibble.c"

// flags linked to PORTD LEDs
 sbit encode_flag at RD1_Bit;
 sbit AWGN_Flag at RD2_Bit;
 sbit Test_Flag at RD0_Bit;
/**************Procedure Declarations*************/
 void encodeMessage(), AddNoise();
 void nibble(char nibbled);
 /***********************************************/

void interrupt () {
  if (RCIF_Bit) {          // test the interrupt for uart rx
    feedflag = 0;
    rxchar = UART1_Read();  //
    rxarray[i] = rxchar;
    i++;
    // ******************************************************
    // Only select one of the following statements
    if (rxchar == 13) {  // select this if looking for a terminating character
     flag = 1;
      } // end if (rxchar == 13)
    } // end  if (PIR1.RCIF)
  if (INT0IF_Bit) {         //for the Encode Button
     encode_flag=~encode_flag;  //toggle flag when button is pressed
     one_run = 0;
     INT0IF_Bit = 0;
     }
  if (INT1IF_Bit) {             //for the "Add Noise" button
     AWGN_Flag=~AWGN_Flag;
     one_run = 0;
     INT1IF_Bit = 0;
     }
  if (INT2IF_Bit) {             //For the "Send Test Message" Button
     Test_Flag=~Test_Flag;
     one_run = 0;
     INT2IF_Bit = 0;
     }
  } // end interrupt

void main () {
unsigned short j;


 INT0IE_Bit=1;              //Enable the three intcon interrupts
 INT1IE_Bit = 1;
 INT2IE_Bit=1;
 INTCON.PEIE = 1;
 RCIE_Bit = 1;              //enable UART interrupt.
 GIE_Bit = 1;
 Delay_ms(2000);
 UART1_Init(9600);
 PSPMODE_Bit = 0;           //certaining that PORTD is general I/O
 one_run = 0;

 PORTD = 0;
 TRISD = ~7;
 PORTD = 7;             //test LEDs by flashing them once.
 delay_ms(1000);
 PORTD = 0;


 UART1_Write_Text("Rita M. \r\nHIT Project 2014\r\nWaiting for Data>");

 while(1) {   // Begin endless loop
  // This section is where you tell the program what to do with the data once it
  // has all arrived
  k=0;
  while(!flag &&!feedflag) {
    UART1_Write(rxchar);        //   and send data via UART
    feedflag = 1;
    }

  if (flag ==1) {
    j = 0;

    UART1_Write_Text("\r\n Received: ");
    while(j < (i-1)) {
    /* Convert small letter to capital: */
    /* (no parentheses are actually necessary) */
//rxarray[j] = (rxarray[j] >= 'a' && c <= 'z') ? ( rxarray[j]-32 ) : rxarray[j];
     UART1_Write(rxarray[j]);
     j++;
     } // end while(rxarray[i])

    i = 0;
    flag = 0;
    UART1_Write_Text("\r\n> ");
  } // end if (flag)

  if (encode_flag&& !one_run) {
     encodeMessage();         //Procedure to encode the message
     UART1_Write_Text("... sent.\r\n> ");   //send encoded message to Rx
     one_run = 1;
  }

  if (test_flag && !one_run) {
     UART1_Write_Text("Test: \r\n");
     UART1_Write(2);            //send "Start of text"
     delay_ms(20);              //stabilize...
     UART1_Write_Text("This is a test message to check the connection");
     UART1_Write(3);           //send "end of text"
     UART1_Write_Text("... sent.\r\n> ");       //send encoded message to Rx
     one_run = 1;
  }

  if (AWGN_flag && !one_run) {
     AddNoise();    //Procedure to add AWGN to  the message (Still Blank)
     UART1_Write_Text("... sent.\r\n> ");       //send encoded message to Rx
     one_run = 1;
  }

 } // end while
} // end main

/************Procedure Definitions*************/
void encodeMessage() {
 char encodeStore[num];


     for(k = 0;k< (i-1); k++) {
     encodeStore[k] = (hammingHigh(rxarray[k]));
     k++;
     encodeStore[k] = (hammingLow(rxarray[k]));
     k++;
     } // end while(rxarray[i])


//Encoding Procedure:
     for (iterate = 0; iterate< num; iterate++) {
         character_check = rxarray[iterate];
         switch (character_check) {
                //case 'r':   rxarray[iterate] = '1';
                case 'R':   rxarray[iterate] = '1';
         }//switch
     }//for loop

     UART1_Write_Text("Encoded: ");
     UART1_Write(2);            //send "Start of text"
     delay_ms(2);              //stabilise...
     for (k = 0; k<(i-1); k++) {
     nibble(rxarray[k]);
     }
      delay_ms(2);
     UART1_Write(3);           //send "end of text"
     UART1_Write_Text("\r\n");
}

void AddNoise() {
     UART1_Write_Text("Noise Added: ");
     UART1_Write(2);            //send "Start of text"
     delay_ms(20);              //stabilize...
     UART1_Write_Text(rxarray);
     UART1_Write(3);           //send "end of text"
     UART1_Write_Text("\r\n");
}

void nibble(char nibbled) {
char HighNibble, LowNibble, TestByte, FinalByte;
bit p1, p2, p4, preserved;     //parity bit variables
unsigned short shiftTemp1, shiftedMessage;

HighNibble = nibbled & 0xF0;
LowNibble = nibbled & 0x0F;

Testbyte = HighNibble + LowNibble;
UART1_Write(TestByte);
UARt1_Write_Text(" : ");

UART1_Write_Text("\r\n");
}
