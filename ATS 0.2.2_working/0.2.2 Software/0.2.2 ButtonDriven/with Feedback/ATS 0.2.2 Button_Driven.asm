
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;ATS 0.2.2 Button_Driven.c,87 :: 		void interrupt() {       //TMR0 Interrupt Handler
;ATS 0.2.2 Button_Driven.c,91 :: 		GIE_Bit = 0;
	BCF        GIE_bit+0, 7
;ATS 0.2.2 Button_Driven.c,93 :: 		if (T0IF_Bit) {         //TMR0 Interrupt
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;ATS 0.2.2 Button_Driven.c,95 :: 		T0IF_Bit = 0;        //reset interrupt flag
	BCF        T0IF_bit+0, 2
;ATS 0.2.2 Button_Driven.c,96 :: 		TMR0 = 0;            //reset timer
	CLRF       TMR0+0
;ATS 0.2.2 Button_Driven.c,97 :: 		ProgTimer++;         //timer that is incremented whenever TMR0
	INCF       _ProgTimer+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ProgTimer+1, 1
;ATS 0.2.2 Button_Driven.c,99 :: 		if (progTimer == 1953)
	MOVF       _ProgTimer+1, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVLW      161
	XORWF      _ProgTimer+0, 0
L__interrupt53:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;ATS 0.2.2 Button_Driven.c,101 :: 		RealTimer++;      //one-second timer
	INCF       _RealTimer+0, 1
	BTFSC      STATUS+0, 2
	INCF       _RealTimer+1, 1
;ATS 0.2.2 Button_Driven.c,104 :: 		if (RunTimer == RunTime) { //when Run Time Reaches Max, Cooldown
	MOVF       _RunTimer+1, 0
	XORWF      _RunTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt54
	MOVF       _RunTime+0, 0
	XORWF      _RunTimer+0, 0
L__interrupt54:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;ATS 0.2.2 Button_Driven.c,105 :: 		RunTimer = 0;
	CLRF       _RunTimer+0
	CLRF       _RunTimer+1
;ATS 0.2.2 Button_Driven.c,106 :: 		Run_flag = 0;         //Stop Procedure requested.
	BCF        _Run_Flag+0, BitPos(_Run_Flag+0)
;ATS 0.2.2 Button_Driven.c,107 :: 		CoolDown_Flag = 1;
	BSF        _CoolDown_Flag+0, BitPos(_CoolDown_Flag+0)
;ATS 0.2.2 Button_Driven.c,108 :: 		}
L_interrupt2:
;ATS 0.2.2 Button_Driven.c,110 :: 		if (CoolDownTimer == CoolDownTime) {
	MOVF       _CoolDownTimer+1, 0
	XORWF      _CoolDownTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt55
	MOVF       _CoolDownTime+0, 0
	XORWF      _CoolDownTimer+0, 0
L__interrupt55:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;ATS 0.2.2 Button_Driven.c,111 :: 		CoolDownTimer = 0;
	CLRF       _CoolDownTimer+0
	CLRF       _CoolDownTimer+1
;ATS 0.2.2 Button_Driven.c,113 :: 		CoolDown_Flag = 0;
	BCF        _CoolDown_Flag+0, BitPos(_CoolDown_Flag+0)
;ATS 0.2.2 Button_Driven.c,114 :: 		}
L_interrupt3:
;ATS 0.2.2 Button_Driven.c,117 :: 		if (Run_Flag && Feedback) RunTimer++;
	BTFSS      _Run_Flag+0, BitPos(_Run_Flag+0)
	GOTO       L_interrupt6
	BTFSS      RA4_bit+0, 4
	GOTO       L_interrupt6
L__interrupt47:
	INCF       _RunTimer+0, 1
	BTFSC      STATUS+0, 2
	INCF       _RunTimer+1, 1
L_interrupt6:
;ATS 0.2.2 Button_Driven.c,118 :: 		if (CoolDown_Flag) CoolDownTimer++;
	BTFSS      _CoolDown_Flag+0, BitPos(_CoolDown_Flag+0)
	GOTO       L_interrupt7
	INCF       _CoolDownTimer+0, 1
	BTFSC      STATUS+0, 2
	INCF       _CoolDownTimer+1, 1
L_interrupt7:
;ATS 0.2.2 Button_Driven.c,120 :: 		SQOUT=~SQOUT;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;ATS 0.2.2 Button_Driven.c,121 :: 		SQOUT=~SQOUT;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;ATS 0.2.2 Button_Driven.c,122 :: 		progTimer = 0;        //reset prog timer
	CLRF       _ProgTimer+0
	CLRF       _ProgTimer+1
;ATS 0.2.2 Button_Driven.c,123 :: 		}
L_interrupt1:
;ATS 0.2.2 Button_Driven.c,124 :: 		}
L_interrupt0:
;ATS 0.2.2 Button_Driven.c,125 :: 		if (INTF_Bit) {           //Pressing "Stop" forced Stop, Turn Off all
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt8
;ATS 0.2.2 Button_Driven.c,126 :: 		INTF_Bit = 0;          //reset interrupt
	BCF        INTF_bit+0, 1
;ATS 0.2.2 Button_Driven.c,128 :: 		CrankTrials = 6;      //just to kick it out of the crank...
	MOVLW      6
	MOVWF      _CrankTrials+0
;ATS 0.2.2 Button_Driven.c,129 :: 		RBValue = 19;          //so that it falls into "Default"
	MOVLW      19
	MOVWF      _RBValue+0
;ATS 0.2.2 Button_Driven.c,130 :: 		Auto_Flag = 0;
	BCF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,131 :: 		Run_Flag = 0;
	BCF        _Run_Flag+0, BitPos(_Run_Flag+0)
;ATS 0.2.2 Button_Driven.c,132 :: 		}
L_interrupt8:
;ATS 0.2.2 Button_Driven.c,133 :: 		GIE_Bit = 1;
	BSF        GIE_bit+0, 7
;ATS 0.2.2 Button_Driven.c,134 :: 		}
L__interrupt52:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;ATS 0.2.2 Button_Driven.c,137 :: 		void main() {
;ATS 0.2.2 Button_Driven.c,140 :: 		ProgTimer = 0;
	CLRF       _ProgTimer+0
	CLRF       _ProgTimer+1
;ATS 0.2.2 Button_Driven.c,141 :: 		RealTimer = 0;
	CLRF       _RealTimer+0
	CLRF       _RealTimer+1
;ATS 0.2.2 Button_Driven.c,142 :: 		RunTimer = 0;
	CLRF       _RunTimer+0
	CLRF       _RunTimer+1
;ATS 0.2.2 Button_Driven.c,143 :: 		CoolDownTimer = 0;
	CLRF       _CoolDownTimer+0
	CLRF       _CoolDownTimer+1
;ATS 0.2.2 Button_Driven.c,144 :: 		Auto_Flag = 0;
	BCF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,145 :: 		Run_Flag = 0;
	BCF        _Run_Flag+0, BitPos(_Run_Flag+0)
;ATS 0.2.2 Button_Driven.c,146 :: 		CoolDown_Flag = 0;
	BCF        _CoolDown_Flag+0, BitPos(_CoolDown_Flag+0)
;ATS 0.2.2 Button_Driven.c,147 :: 		GenFeedFlag = 0;
	BCF        _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
;ATS 0.2.2 Button_Driven.c,148 :: 		RunTime = 0;
	CLRF       _RunTime+0
	CLRF       _RunTime+1
;ATS 0.2.2 Button_Driven.c,149 :: 		CoolDownTime = 0;
	CLRF       _CoolDownTime+0
	CLRF       _CoolDownTime+1
;ATS 0.2.2 Button_Driven.c,150 :: 		RBValue = 0;
	CLRF       _RBValue+0
;ATS 0.2.2 Button_Driven.c,151 :: 		CrankTrials = 0;
	CLRF       _CrankTrials+0
;ATS 0.2.2 Button_Driven.c,156 :: 		RunTime = 14388;   //4 hours - 12 seconds run time
	MOVLW      52
	MOVWF      _RunTime+0
	MOVLW      56
	MOVWF      _RunTime+1
;ATS 0.2.2 Button_Driven.c,158 :: 		CoolDownTime = 3599;   //1 hour (- 1 second) cooldown time
	MOVLW      15
	MOVWF      _CoolDownTime+0
	MOVLW      14
	MOVWF      _CoolDownTime+1
;ATS 0.2.2 Button_Driven.c,160 :: 		PORTA = 0;
	CLRF       PORTA+0
;ATS 0.2.2 Button_Driven.c,161 :: 		TRISA = 0b10110;       //Following the I-O Table Above(line 50)
	MOVLW      22
	MOVWF      TRISA+0
;ATS 0.2.2 Button_Driven.c,162 :: 		PORTB = 0;
	CLRF       PORTB+0
;ATS 0.2.2 Button_Driven.c,163 :: 		TRISB = 0b00001111;   //Following the I-O Table Above
	MOVLW      15
	MOVWF      TRISB+0
;ATS 0.2.2 Button_Driven.c,165 :: 		ADCON1 = 0x07;          //PORTA all digital. (16F716)
	MOVLW      7
	MOVWF      ADCON1+0
;ATS 0.2.2 Button_Driven.c,167 :: 		T0IE_Bit = 1;           //Enable TMR0 Interrupt
	BSF        T0IE_bit+0, 5
;ATS 0.2.2 Button_Driven.c,168 :: 		INTE_Bit = 1;          //Enable RB0 Interrupt...
	BSF        INTE_bit+0, 4
;ATS 0.2.2 Button_Driven.c,169 :: 		INTEDG_Bit = 1;        //...on rising edge of RB0
	BSF        INTEDG_bit+0, 6
;ATS 0.2.2 Button_Driven.c,170 :: 		GIE_bit = 1;
	BSF        GIE_bit+0, 7
;ATS 0.2.2 Button_Driven.c,174 :: 		T0CS_Bit = 0;    //Select Timer Mode. Timer Starts Now
	BCF        T0CS_bit+0, 5
;ATS 0.2.2 Button_Driven.c,175 :: 		TMR0 = 0;        //reset the TMR0 Register
	CLRF       TMR0+0
;ATS 0.2.2 Button_Driven.c,176 :: 		PSA_Bit = 0;     //Assign Prescaler from WDT to Timer0 when value = 0
	BCF        PSA_bit+0, 3
;ATS 0.2.2 Button_Driven.c,177 :: 		OPTION_REG &=248;         //Clear Previous Prescaler Values
	MOVLW      248
	ANDWF      OPTION_REG+0, 1
;ATS 0.2.2 Button_Driven.c,178 :: 		OPTION_REG |=0;     //set Prescaler to 1:2
;ATS 0.2.2 Button_Driven.c,183 :: 		while(1) {                           //Main Endless Loop
L_main9:
;ATS 0.2.2 Button_Driven.c,185 :: 		delay_ms(100);                     //delay for latency (To allow system
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	NOP
	NOP
;ATS 0.2.2 Button_Driven.c,191 :: 		if (RBValue != 19) RBValue = PORTB & 0x07;   // 19 is the fallback value
	MOVF       _RBValue+0, 0
	XORLW      19
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVLW      7
	ANDWF      PORTB+0, 0
	MOVWF      _RBValue+0
L_main12:
;ATS 0.2.2 Button_Driven.c,194 :: 		if (!Run_flag && CoolDown_flag) RBValue = 19;   //it's time to cool down
	BTFSC      _Run_Flag+0, BitPos(_Run_Flag+0)
	GOTO       L_main15
	BTFSS      _CoolDown_Flag+0, BitPos(_CoolDown_Flag+0)
	GOTO       L_main15
L__main48:
	MOVLW      19
	MOVWF      _RBValue+0
L_main15:
;ATS 0.2.2 Button_Driven.c,212 :: 		switch(RBValue) {
	GOTO       L_main16
;ATS 0.2.2 Button_Driven.c,215 :: 		case 4:                                 //Gen Auto Mode Selected
L_main18:
;ATS 0.2.2 Button_Driven.c,216 :: 		Auto_Flag = 1;                     // Gen is in Auto Mode
	BSF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,217 :: 		RBValue = 0;
	CLRF       _RBValue+0
;ATS 0.2.2 Button_Driven.c,218 :: 		if (Auto_Flag) Poll();             //call Auto Mode Routine Here
	BTFSS      _Auto_Flag+0, BitPos(_Auto_Flag+0)
	GOTO       L_main19
	CALL       _Poll+0
L_main19:
;ATS 0.2.2 Button_Driven.c,219 :: 		break;
	GOTO       L_main17
;ATS 0.2.2 Button_Driven.c,221 :: 		case 6:                                 //Gen Auto Mode Selected
L_main20:
;ATS 0.2.2 Button_Driven.c,222 :: 		Auto_Flag = 1;                     // Gen is in Auto Mode
	BSF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,223 :: 		RBValue = 0;
	CLRF       _RBValue+0
;ATS 0.2.2 Button_Driven.c,224 :: 		if (Auto_Flag) Poll();             //call Auto Mode Routine Here
	BTFSS      _Auto_Flag+0, BitPos(_Auto_Flag+0)
	GOTO       L_main21
	CALL       _Poll+0
L_main21:
;ATS 0.2.2 Button_Driven.c,225 :: 		break;
	GOTO       L_main17
;ATS 0.2.2 Button_Driven.c,229 :: 		case 2:                                   //Start Button Pressed
L_main22:
;ATS 0.2.2 Button_Driven.c,230 :: 		Auto_Flag = 0;                     //Gen is in Manual Mode
	BCF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,231 :: 		GenStop = 1;                         //Turn Off GEN_OFF signal
	BSF        RB4_bit+0, 4
;ATS 0.2.2 Button_Driven.c,232 :: 		GenOn = 1;
	BSF        RB7_bit+0, 7
;ATS 0.2.2 Button_Driven.c,235 :: 		GenStart = 1;
	BSF        RB6_bit+0, 6
;ATS 0.2.2 Button_Driven.c,236 :: 		Run_Flag = 1;
	BSF        _Run_Flag+0, BitPos(_Run_Flag+0)
;ATS 0.2.2 Button_Driven.c,238 :: 		RBValue = 0;
	CLRF       _RBValue+0
;ATS 0.2.2 Button_Driven.c,239 :: 		break;
	GOTO       L_main17
;ATS 0.2.2 Button_Driven.c,243 :: 		case 0:
L_main23:
;ATS 0.2.2 Button_Driven.c,244 :: 		GenStart = 0;  //uncomment for manual cranking
	BCF        RB6_bit+0, 6
;ATS 0.2.2 Button_Driven.c,245 :: 		Auto_Flag = 0;
	BCF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,246 :: 		RBValue = 0;
	CLRF       _RBValue+0
;ATS 0.2.2 Button_Driven.c,247 :: 		break;
	GOTO       L_main17
;ATS 0.2.2 Button_Driven.c,251 :: 		default:
L_main24:
;ATS 0.2.2 Button_Driven.c,252 :: 		Auto_Flag = 0;
	BCF        _Auto_Flag+0, BitPos(_Auto_Flag+0)
;ATS 0.2.2 Button_Driven.c,253 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
	NOP
;ATS 0.2.2 Button_Driven.c,254 :: 		PORTB = 0;       //Turn the Gen Off if none of the conditions are met
	CLRF       PORTB+0
;ATS 0.2.2 Button_Driven.c,255 :: 		delay_ms(5000);  //wait for gen to fully stop
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
	NOP
;ATS 0.2.2 Button_Driven.c,256 :: 		if (!feedback) Run_Flag = 0; //Ensure Gen is off
	BTFSC      RA4_bit+0, 4
	GOTO       L_main27
	BCF        _Run_Flag+0, BitPos(_Run_Flag+0)
L_main27:
;ATS 0.2.2 Button_Driven.c,257 :: 		RBValue = 0;
	CLRF       _RBValue+0
;ATS 0.2.2 Button_Driven.c,258 :: 		break;         //We need an ERROR Condition Here
	GOTO       L_main17
;ATS 0.2.2 Button_Driven.c,259 :: 		} //switch
L_main16:
	MOVF       _RBValue+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _RBValue+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _RBValue+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _RBValue+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	GOTO       L_main24
L_main17:
;ATS 0.2.2 Button_Driven.c,262 :: 		}//While
	GOTO       L_main9
;ATS 0.2.2 Button_Driven.c,264 :: 		}
	GOTO       $+0
; end of _main

_crank:

;ATS 0.2.2 Button_Driven.c,268 :: 		void crank() { //Crank till there's feedback. 5X5 seconds before failing.
;ATS 0.2.2 Button_Driven.c,269 :: 		GenFeedFlag = feedback;
	BTFSC      RA4_bit+0, 4
	GOTO       L__crank56
	BCF        _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
	GOTO       L__crank57
L__crank56:
	BSF        _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
L__crank57:
;ATS 0.2.2 Button_Driven.c,270 :: 		CrankTrials = 0;
	CLRF       _CrankTrials+0
;ATS 0.2.2 Button_Driven.c,271 :: 		while (!GenFeedFlag && CrankTrials <5) {
L_crank28:
	BTFSC      _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
	GOTO       L_crank29
	MOVLW      5
	SUBWF      _CrankTrials+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_crank29
L__crank49:
;ATS 0.2.2 Button_Driven.c,272 :: 		GenStart = 1;
	BSF        RB6_bit+0, 6
;ATS 0.2.2 Button_Driven.c,273 :: 		delay_ms(5000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_crank32:
	DECFSZ     R13+0, 1
	GOTO       L_crank32
	DECFSZ     R12+0, 1
	GOTO       L_crank32
	DECFSZ     R11+0, 1
	GOTO       L_crank32
	NOP
;ATS 0.2.2 Button_Driven.c,274 :: 		CrankTrials++;
	INCF       _CrankTrials+0, 1
;ATS 0.2.2 Button_Driven.c,275 :: 		GenFeedFlag = feedback;
	BTFSC      RA4_bit+0, 4
	GOTO       L__crank58
	BCF        _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
	GOTO       L__crank59
L__crank58:
	BSF        _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
L__crank59:
;ATS 0.2.2 Button_Driven.c,276 :: 		if (CrankTrials == 5) {
	MOVF       _CrankTrials+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_crank33
;ATS 0.2.2 Button_Driven.c,277 :: 		CrankTrials = 0;
	CLRF       _CrankTrials+0
;ATS 0.2.2 Button_Driven.c,278 :: 		GenFeedFlag = 1;
	BSF        _GenFeedFlag+0, BitPos(_GenFeedFlag+0)
;ATS 0.2.2 Button_Driven.c,279 :: 		PORTB = 0;
	CLRF       PORTB+0
;ATS 0.2.2 Button_Driven.c,280 :: 		Run_Flag = 0;
	BCF        _Run_Flag+0, BitPos(_Run_Flag+0)
;ATS 0.2.2 Button_Driven.c,281 :: 		RBValue = 19;  //Falls to "Default
	MOVLW      19
	MOVWF      _RBValue+0
;ATS 0.2.2 Button_Driven.c,283 :: 		}
	GOTO       L_crank34
L_crank33:
;ATS 0.2.2 Button_Driven.c,284 :: 		else Run_Flag = 1;
	BSF        _Run_Flag+0, BitPos(_Run_Flag+0)
L_crank34:
;ATS 0.2.2 Button_Driven.c,285 :: 		GenStart = 0;      //Stop Cranking
	BCF        RB6_bit+0, 6
;ATS 0.2.2 Button_Driven.c,286 :: 		} //while
	GOTO       L_crank28
L_crank29:
;ATS 0.2.2 Button_Driven.c,287 :: 		}//crank
	RETURN
; end of _crank

_Poll:

;ATS 0.2.2 Button_Driven.c,290 :: 		void Poll() {
;ATS 0.2.2 Button_Driven.c,291 :: 		if (Auto_Flag && ZESA) {
	BTFSS      _Auto_Flag+0, BitPos(_Auto_Flag+0)
	GOTO       L_Poll37
	BTFSS      RA2_bit+0, 2
	GOTO       L_Poll37
L__Poll51:
;ATS 0.2.2 Button_Driven.c,292 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Poll38:
	DECFSZ     R13+0, 1
	GOTO       L_Poll38
	DECFSZ     R12+0, 1
	GOTO       L_Poll38
	DECFSZ     R11+0, 1
	GOTO       L_Poll38
	NOP
	NOP
;ATS 0.2.2 Button_Driven.c,293 :: 		ChangeOver = 0;    // make sure you revert to ZESA Supply
	BCF        RB5_bit+0, 5
;ATS 0.2.2 Button_Driven.c,294 :: 		RBValue = 19;       //Fall to Default
	MOVLW      19
	MOVWF      _RBValue+0
;ATS 0.2.2 Button_Driven.c,296 :: 		}
	GOTO       L_Poll39
L_Poll37:
;ATS 0.2.2 Button_Driven.c,298 :: 		delay_ms(1000);    //Just wait...
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Poll40:
	DECFSZ     R13+0, 1
	GOTO       L_Poll40
	DECFSZ     R12+0, 1
	GOTO       L_Poll40
	DECFSZ     R11+0, 1
	GOTO       L_Poll40
	NOP
	NOP
;ATS 0.2.2 Button_Driven.c,299 :: 		if (!Run_flag) {  //if the Gen is running, leave and Poll
	BTFSC      _Run_Flag+0, BitPos(_Run_Flag+0)
	GOTO       L_Poll41
;ATS 0.2.2 Button_Driven.c,300 :: 		if (!CoolDown_Flag) {
	BTFSC      _CoolDown_Flag+0, BitPos(_CoolDown_Flag+0)
	GOTO       L_Poll42
;ATS 0.2.2 Button_Driven.c,301 :: 		GenStop = 1;
	BSF        RB4_bit+0, 4
;ATS 0.2.2 Button_Driven.c,302 :: 		GenOn = 1;
	BSF        RB7_bit+0, 7
;ATS 0.2.2 Button_Driven.c,303 :: 		crank();   //...and run the Generator Start/ crank Routine.
	CALL       _crank+0
;ATS 0.2.2 Button_Driven.c,304 :: 		Delay_ms(5000);     //Stabilize
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_Poll43:
	DECFSZ     R13+0, 1
	GOTO       L_Poll43
	DECFSZ     R12+0, 1
	GOTO       L_Poll43
	DECFSZ     R11+0, 1
	GOTO       L_Poll43
	NOP
;ATS 0.2.2 Button_Driven.c,307 :: 		if (!ZESA && Run_Flag) {
	BTFSC      RA2_bit+0, 2
	GOTO       L_Poll46
	BTFSS      _Run_Flag+0, BitPos(_Run_Flag+0)
	GOTO       L_Poll46
L__Poll50:
;ATS 0.2.2 Button_Driven.c,308 :: 		ChangeOver = 1;
	BSF        RB5_bit+0, 5
;ATS 0.2.2 Button_Driven.c,309 :: 		Run_Flag = 1;
	BSF        _Run_Flag+0, BitPos(_Run_Flag+0)
;ATS 0.2.2 Button_Driven.c,310 :: 		}//if AutoMode
L_Poll46:
;ATS 0.2.2 Button_Driven.c,311 :: 		}//if !CoolDown_Flag
L_Poll42:
;ATS 0.2.2 Button_Driven.c,312 :: 		} // if !Run Flag
L_Poll41:
;ATS 0.2.2 Button_Driven.c,313 :: 		}//else ZESA is not there
L_Poll39:
;ATS 0.2.2 Button_Driven.c,314 :: 		} //Poll
	RETURN
; end of _Poll
