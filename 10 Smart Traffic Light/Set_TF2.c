unsigned short counterA, counterB, delayLenA, delayLenB;
unsigned short delayLen2A, delayLen2B, countOffset;
unsigned long delayLen_msA, delayLen_msB;  //long var increases max time to
                                           //4,000,000 seconds!

unsigned short Set_Traffic() {
     counterB = TMR0;        //take counterB's value from Timer0
     counterA = TMR1L;       //also take counterA's value form Timer1
     delayLenA = 10;          //10s is the default value of our delays
     delayLenB = 10;

     
     if(counterA>5){       //when counter has counted more than 5 cars...
                            //..in less than 10 seconds...
                     countOffset = counterA - 5;
                     delayLen2A = 2*countOffset;   //add 2 seconds for each
                                                   //additional car after 5s
                     delayLenA += delayLen2A;
                     }
                     
     if (counterB>5){         //this is identical to the code above,
                               //but its meant for counterB
                      countOffset = counterB - 5;
                     delayLen2B = 2*countOffset;
                     delayLenB += delayLen2B;
                      }
     delayLen_msA = delayLenA*1000;         //change values into milliseconds
     delayLen_msB = delayLenB*1000;
     
     TMR0 = 0;                //reset your counters immediately
     TMR1L = 0;
     return delayLen_msA, delayLen_msB;
     }
