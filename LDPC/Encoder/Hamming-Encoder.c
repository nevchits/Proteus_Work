//Working - 24 apr 21:20

 char character_check;
 short iterate;
 char uart_rd; // Variable for storing the data from UART and array counter
 bit one_run;     //flag to limit operations to one each. placed because of
                      //the endless loop
 const short num = 32;
 char rxchar, i = 0, flag = 0,feedflag = 0;
 unsigned char rxarray[num], rxstore[num];   // array to store the received charaters
 char HighNibble, HighNibbleShifted, LowNibble, TestByte, FinalByte;
 int randomNumber;

// flags linked to PORTD LEDs
 sbit encode_flag at RD1_Bit;
 sbit AWGN_Flag at RD2_Bit;
 sbit Test_Flag at RD0_Bit;
/**************Procedure Declarations*************/
 void nibble(char nibbled);
 char HammingEncode(char message);
 void AddNoise(char noised);
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
unsigned short j, k;


 INT0IE_Bit=1;              //Enable the three intcon interrupts
 INT1IE_Bit = 1;
 INT2IE_Bit=1;
 INTCON.PEIE = 1;
 RCIE_Bit = 1;              //enable UART interrupt.
 GIE_Bit = 1;
 Delay_ms(20);
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
     UART1_Write(rxarray[j]);
     j++;
     } // end while(rxarray[i])
    //i = 0;  //Let's see if we really dont need this. so far, so good!
              //zvikanetsa we may just use the "One Run"
    flag = 0;
    UART1_Write_Text("\r\n> ");
  } // end if (flag)

  if (encode_flag&& !one_run) {
     j = 0;
     //encodeMessage();         //Procedure to encode the message
     //encoding
     UART1_Write_Text("\r\n Encoded characters:\r\n");
     while(j < (i-1)) {
     nibble(rxarray[j]);
     j++;
     } // end while(rxarray[i])
     UART1_Write_Text("... sent.\r\n> ");   //send encoded message to Rx
     one_run = 1;
  } // end if encode

  if (test_flag && !one_run) {
     UART1_Write_Text("Test: \r\n");
     UART1_Write(2);            //send "Start of text"
     delay_ms(20);              //stabilize...
     UART1_Write_Text("This is a test message to check the connection");
     UART1_Write(3);           //send "end of text"
     UART1_Write_Text("... sent.\r\n> ");       //send encoded message to Rx
     one_run = 1;
  }

  if (AWGN_flag && !one_run) {// && (HighNibble>0) && (LowNibble>0)) {
     j = 0;
     //encoding and adding noise
     UART1_Write_Text("\r\n Encoded With noise:\r\n");
     while(j < (i-1)) {
     AddNoise(rxarray[j]);
     j++;
     } // end while(rxarray[i])
     UART1_Write_Text("... sent.\r\n> ");   //send encoded message to Rx
     one_run = 1;
  }

 } // end while
} // end main

/************Procedure Definitions*************/
void nibble(char nibbled){    //nibble extractor
HighNibble = nibbled & 0xF0;
HighNibbleShifted = HighNibble>>4;
LowNibble = nibbled & 0x0F;

TestByte = HighNibble + LowNibble; //test to see if char is still the same.
//add 3 to each nibble:
//HighNibble +=3;
HighNibble = HammingEncode(HighNibbleShifted);

//LowNibble +=3;
LowNibble = HammingEncode(LowNibble);

FinalByte = HighNibble; + LowNibble;

UART1_Write(TestByte);
UART1_Write_Text(": ");
//UART1_Write(FinalByte);        //start of text
UART1_Write(HighNibble);        //end of text
UART1_Write_Text(" and ");
UART1_Write(LowNibble);

UART1_Write_Text(" (");
UART1_Write(2);          //start of text
UART1_Write(HighNibble);
UART1_Write(LowNibble);
UART1_Write(3);
UART1_Write_Text(")");
UART1_Write_Text("\r\n ");
delay_ms(20);
}

char HammingEncode(char message){
bit p1, p2, p4, preserved;     //parity bit variables
unsigned short shiftTemp1, shiftedMessage;

message <<=2;
preserved = message.B2;
message<<=1;
message.B2 = preserved;

p1 = message.B2 ^ message.B4;
p1 = p1 ^ message.B6;
message.B0 = p1;

p2 = message.B2 ^ message.B5;
p2 = p2 ^ message.B6;
message.B1 = p2;

p4 = message.B4 ^ message.B5;
p4 = p4 ^ message.B6;
message.B3 = p4;

return message;
}

void AddNoise(char noised) {
HighNibble = noised & 0xF0;
HighNibbleShifted = HighNibble>>4;
LowNibble = noised & 0x0F;

TestByte = HighNibble + LowNibble; //test to see if char is still the same.
//add 3 to each nibble:
//HighNibble +=3;
HighNibble = HammingEncode(HighNibbleShifted);

//LowNibble +=3;
LowNibble = HammingEncode(LowNibble);

FinalByte = HighNibble; + LowNibble;

//do randomNumber = rand();
//while (randomNumber >126);

HighNibble+=98; //randomNumber;
LowNibble+= 25;//randomnumber+3;

UART1_Write(TestByte);
UART1_Write_Text(": ");
//UART1_Write(FinalByte);        //start of text
UART1_Write(HighNibble);        //end of text
UART1_Write_Text(" and ");
UART1_Write(LowNibble);

UART1_Write_Text(" (");
UART1_Write(2);          //start of text
UART1_Write(HighNibble);
UART1_Write(LowNibble);
UART1_Write(3);
UART1_Write_Text(")");
UART1_Write_Text("\r\n ");
delay_ms(20);;
}
