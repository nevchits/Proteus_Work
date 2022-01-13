
_main:

;01_Set_Traffic.c,7 :: 		void main() {
;01_Set_Traffic.c,11 :: 		PORTA = 0xFF;       //Port A for the counter Values
	MOVLW      255
	MOVWF      PORTA+0
;01_Set_Traffic.c,12 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;01_Set_Traffic.c,13 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;01_Set_Traffic.c,14 :: 		delay_ms(250);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;01_Set_Traffic.c,15 :: 		PORTB = 0xff;       //Run a Light Test
	MOVLW      255
	MOVWF      PORTB+0
;01_Set_Traffic.c,16 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;01_Set_Traffic.c,17 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;01_Set_Traffic.c,18 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;01_Set_Traffic.c,19 :: 		PORTB = 0b01000010;// One Red, one Green
	MOVLW      66
	MOVWF      PORTB+0
;01_Set_Traffic.c,22 :: 		T0IF_bit = 0;
	BCF        T0IF_bit+0, 2
;01_Set_Traffic.c,23 :: 		TMR0 = 0;      //no offset
	CLRF       TMR0+0
;01_Set_Traffic.c,24 :: 		T0IE_bit = 1;
	BSF        T0IE_bit+0, 5
;01_Set_Traffic.c,26 :: 		RB7_bit = 1;       //Reserve RB7 for selecting the counter.
	BSF        RB7_bit+0, 7
;01_Set_Traffic.c,29 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;01_Set_Traffic.c,30 :: 		PORTB = 0x00;      //RB7 = 0, check the value at the 7 seg Display
	CLRF       PORTB+0
;01_Set_Traffic.c,31 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;01_Set_Traffic.c,35 :: 		RB7_bit = 0;       //choose counter A
	BCF        RB7_bit+0, 7
;01_Set_Traffic.c,36 :: 		counterA = PORTA;  //set the count at PORTA to counterA variable
	MOVF       PORTA+0, 0
	MOVWF      _counterA+0
;01_Set_Traffic.c,37 :: 		RB7_bit = 1;       //select counter B
	BSF        RB7_bit+0, 7
;01_Set_Traffic.c,38 :: 		counterB = PORTA;   //set the count at PORTA to counterB variable
	MOVF       PORTA+0, 0
	MOVWF      _counterB+0
;01_Set_Traffic.c,41 :: 		}
	GOTO       $+0
; end of _main
