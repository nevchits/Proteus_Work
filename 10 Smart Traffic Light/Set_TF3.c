unsigned short NorthIn, EastIn, delayLen;
short Traff_Count;
unsigned short NorthOut, EastOut;
unsigned long delayLen_ms;  //long var increases max time to
                                           //4,000,000 seconds!

void Set_North() {
North_Set:
     NorthIn = TMR0;       //take counterB's value from Timer0
     RB7_Bit = 1;         //Select A (i.e North) from Encoder
     NorthOut = PORTA&&0x0F;    //take the counter value
     Traff_Count =  NorthIn - NorthOut;
     if (Traff_Count < 5) Traff_Count = 5; //Minimum Number of Cars is five!
     delayLen = 5 + ((Traff_Count - 5)*2); //add 2 seconds for every car
                                              //after 5 cars
     delayLen_ms = delayLen*1000;         //change values into milliseconds
     TMR0 = 0;                //reset your counters immediately
     RB6_Bit = 1;
     Delay_ms(1);
     //RB6_Bit = 0;
     }
                                              
void Set_East() {
East_Set:
     EastIn = TMR1L;      //also take counterA's value form Timer1
     RB7_Bit = 0;         //Select B (i.e East) from Encoder
     EastOut = PORTA&&0x0F;
     Traff_Count =  EastIn - EastOut;
     if (Traff_Count < 5) Traff_Count = 5; //Minimum Number of Cars is five!
     delayLen = 5 + ((Traff_Count - 5)*2); //add 2 seconds for every car
                                            //after 5 cars
     delayLen_ms = delayLen*1000;         //change values into milliseconds
     TMR1L = 0;                //reset your counters immediately
     RB6_Bit = 1;
     Delay_ms(1);
     //RB6_Bit = 0;
     }
