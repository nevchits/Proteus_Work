
_Set_Traffic:

;set_tf2.c,6 :: 		unsigned short Set_Traffic() {
;set_tf2.c,7 :: 		counterB = TMR0;        //take counterB's value from Timer0
	MOVF       TMR0+0, 0
	MOVWF      _counterB+0
;set_tf2.c,8 :: 		counterA = TMR1L;       //also take counterA's value form Timer1
	MOVF       TMR1L+0, 0
	MOVWF      _counterA+0
;set_tf2.c,9 :: 		delayLenA = 10;          //10s is the default value of our delays
	MOVLW      10
	MOVWF      _delayLenA+0
;set_tf2.c,10 :: 		delayLenB = 10;
	MOVLW      10
	MOVWF      _delayLenB+0
;set_tf2.c,13 :: 		if(counterA>5){       //when counter has counted more than 5 cars...
	MOVF       _counterA+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_Set_Traffic0
;set_tf2.c,15 :: 		countOffset = counterA - 5;
	MOVLW      5
	SUBWF      _counterA+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      _countOffset+0
;set_tf2.c,16 :: 		delayLen2A = 2*countOffset;   //add 2 seconds for each
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	MOVWF      _delayLen2A+0
;set_tf2.c,18 :: 		delayLenA += delayLen2A;
	MOVF       R0+0, 0
	ADDWF      _delayLenA+0, 1
;set_tf2.c,19 :: 		}
L_Set_Traffic0:
;set_tf2.c,21 :: 		if (counterB>5){         //this is identical to the code above,
	MOVF       _counterB+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_Set_Traffic1
;set_tf2.c,23 :: 		countOffset = counterB - 5;
	MOVLW      5
	SUBWF      _counterB+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      _countOffset+0
;set_tf2.c,24 :: 		delayLen2B = 2*countOffset;
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	MOVWF      _delayLen2B+0
;set_tf2.c,25 :: 		delayLenB += delayLen2B;
	MOVF       R0+0, 0
	ADDWF      _delayLenB+0, 1
;set_tf2.c,26 :: 		}
L_Set_Traffic1:
;set_tf2.c,27 :: 		delayLen_msA = delayLenA*1000;         //change values into milliseconds
	MOVF       _delayLenA+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _delayLen_msA+0
	MOVF       R0+1, 0
	MOVWF      _delayLen_msA+1
	MOVLW      0
	BTFSC      _delayLen_msA+1, 7
	MOVLW      255
	MOVWF      _delayLen_msA+2
	MOVWF      _delayLen_msA+3
;set_tf2.c,28 :: 		delayLen_msB = delayLenB*1000;
	MOVF       _delayLenB+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _delayLen_msB+0
	MOVF       R0+1, 0
	MOVWF      _delayLen_msB+1
	MOVLW      0
	BTFSC      _delayLen_msB+1, 7
	MOVLW      255
	MOVWF      _delayLen_msB+2
	MOVWF      _delayLen_msB+3
;set_tf2.c,30 :: 		TMR0 = 0;                //reset your counters immediately
	CLRF       TMR0+0
;set_tf2.c,31 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;set_tf2.c,32 :: 		return delayLen_msA, delayLen_msB;
	MOVF       _delayLen_msB+0, 0
	MOVWF      R0+0
;set_tf2.c,33 :: 		}
	RETURN
; end of _Set_Traffic

_default_Seq:

;TOCK_Counter.c,3 :: 		void default_Seq(){
;TOCK_Counter.c,6 :: 		PORTB = 0b00010010;        //All Amber
	MOVLW      18
	MOVWF      PORTB+0
;TOCK_Counter.c,7 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_default_Seq2:
	DECFSZ     R13+0, 1
	GOTO       L_default_Seq2
	DECFSZ     R12+0, 1
	GOTO       L_default_Seq2
	DECFSZ     R11+0, 1
	GOTO       L_default_Seq2
	NOP
	NOP
;TOCK_Counter.c,8 :: 		PORTB = 0b00001001;        //All Red
	MOVLW      9
	MOVWF      PORTB+0
;TOCK_Counter.c,9 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_default_Seq3:
	DECFSZ     R13+0, 1
	GOTO       L_default_Seq3
	DECFSZ     R12+0, 1
	GOTO       L_default_Seq3
	DECFSZ     R11+0, 1
	GOTO       L_default_Seq3
	NOP
	NOP
;TOCK_Counter.c,11 :: 		while(1){
L_default_Seq4:
;TOCK_Counter.c,12 :: 		Set_Traffic();           //check for traffic count
	CALL       _Set_Traffic+0
;TOCK_Counter.c,13 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_default_Seq6:
	DECFSZ     R13+0, 1
	GOTO       L_default_Seq6
	DECFSZ     R12+0, 1
	GOTO       L_default_Seq6
	DECFSZ     R11+0, 1
	GOTO       L_default_Seq6
	NOP
	NOP
;TOCK_Counter.c,14 :: 		PORTB = 0b00100001;       //NS Red, EW Green
	MOVLW      33
	MOVWF      PORTB+0
;TOCK_Counter.c,15 :: 		Vdelay_ms(delayLen_msA);
	MOVF       _delayLen_msA+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVF       _delayLen_msA+1, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;TOCK_Counter.c,16 :: 		PORTA = delayLenA;        //show delay length on 7 seg display
	MOVF       _delayLenA+0, 0
	MOVWF      PORTA+0
;TOCK_Counter.c,17 :: 		PORTB = 0b00010001;       //NS Red, EW Amber
	MOVLW      17
	MOVWF      PORTB+0
;TOCK_Counter.c,18 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_default_Seq7:
	DECFSZ     R13+0, 1
	GOTO       L_default_Seq7
	DECFSZ     R12+0, 1
	GOTO       L_default_Seq7
	DECFSZ     R11+0, 1
	GOTO       L_default_Seq7
	NOP
	NOP
;TOCK_Counter.c,19 :: 		PORTB = 0b00001001;       //NS Red, EW Red
	MOVLW      9
	MOVWF      PORTB+0
;TOCK_Counter.c,20 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_default_Seq8:
	DECFSZ     R13+0, 1
	GOTO       L_default_Seq8
	DECFSZ     R12+0, 1
	GOTO       L_default_Seq8
	DECFSZ     R11+0, 1
	GOTO       L_default_Seq8
	NOP
	NOP
;TOCK_Counter.c,21 :: 		PORTB = 0b00001100;        //NS Green, EW Red
	MOVLW      12
	MOVWF      PORTB+0
;TOCK_Counter.c,22 :: 		Vdelay_ms(delayLen_msB);
	MOVF       _delayLen_msB+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVF       _delayLen_msB+1, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;TOCK_Counter.c,23 :: 		PORTA = delayLenB;
	MOVF       _delayLenB+0, 0
	MOVWF      PORTA+0
;TOCK_Counter.c,24 :: 		PORTB = 0b00001010;        //NS Amber, EW Red
	MOVLW      10
	MOVWF      PORTB+0
;TOCK_Counter.c,25 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_default_Seq9:
	DECFSZ     R13+0, 1
	GOTO       L_default_Seq9
	DECFSZ     R12+0, 1
	GOTO       L_default_Seq9
	DECFSZ     R11+0, 1
	GOTO       L_default_Seq9
	NOP
	NOP
;TOCK_Counter.c,26 :: 		PORTB = 0b00001001;        //NS Red, EW Red
	MOVLW      9
	MOVWF      PORTB+0
;TOCK_Counter.c,27 :: 		}
	GOTO       L_default_Seq4
;TOCK_Counter.c,28 :: 		}
	RETURN
; end of _default_Seq

_main:

;TOCK_Counter.c,30 :: 		void main() {
;TOCK_Counter.c,33 :: 		T0SE_bit = 0;    //increment at rising edge of T0CK
	BCF        T0SE_bit+0, 4
;TOCK_Counter.c,34 :: 		TMR1ON_bit = 1;
	BSF        TMR1ON_bit+0, 0
;TOCK_Counter.c,35 :: 		T1OSCEN_bit = 1;
	BSF        T1OSCEN_bit+0, 3
;TOCK_Counter.c,36 :: 		TMR1CS_bit = 1;
	BSF        TMR1CS_bit+0, 1
;TOCK_Counter.c,37 :: 		T0CS_bit = 1;
	BSF        T0CS_bit+0, 5
;TOCK_Counter.c,40 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;TOCK_Counter.c,41 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;TOCK_Counter.c,42 :: 		TRISA = 0xF0;
	MOVLW      240
	MOVWF      TRISA+0
;TOCK_Counter.c,43 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;TOCK_Counter.c,44 :: 		TMR0 = 0;
	CLRF       TMR0+0
;TOCK_Counter.c,45 :: 		TMR1L= 0;
	CLRF       TMR1L+0
;TOCK_Counter.c,48 :: 		default_Seq();
	CALL       _default_Seq+0
;TOCK_Counter.c,52 :: 		}
	GOTO       $+0
; end of _main
