
_write_LCD:

;boom_lcd.c,22 :: 		void write_LCD(){
;boom_lcd.c,23 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;boom_lcd.c,24 :: 		lcd_out(1,1, "No Train");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;boom_lcd.c,25 :: 		lcd_out(2,1, "Ready...");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;boom_lcd.c,26 :: 		}
	RETURN      0
; end of _write_LCD

_init_seg:

;boom_7seg.c,10 :: 		void init_seg() {
;boom_7seg.c,11 :: 		TRISC = 0;
	CLRF        TRISC+0 
;boom_7seg.c,12 :: 		TRISD = 0;
	CLRF        TRISD+0 
;boom_7seg.c,13 :: 		PORTC = 0;
	CLRF        PORTC+0 
;boom_7seg.c,14 :: 		}
	RETURN      0
; end of _init_seg

_testseg:

;boom_7seg.c,16 :: 		void testseg(){
;boom_7seg.c,17 :: 		PORTC = 0;
	CLRF        PORTC+0 
;boom_7seg.c,18 :: 		PORTC = 8;
	MOVLW       8
	MOVWF       PORTC+0 
;boom_7seg.c,19 :: 		seg_tens = 1;
	BSF         RD0_bit+0, 0 
;boom_7seg.c,20 :: 		seg_units = 1;
	BSF         RD1_bit+0, 1 
;boom_7seg.c,21 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_testseg0:
	DECFSZ      R13, 1, 0
	BRA         L_testseg0
	DECFSZ      R12, 1, 0
	BRA         L_testseg0
	DECFSZ      R11, 1, 0
	BRA         L_testseg0
	NOP
	NOP
;boom_7seg.c,22 :: 		PORTC = 0;
	CLRF        PORTC+0 
;boom_7seg.c,23 :: 		}
	RETURN      0
; end of _testseg

_countdown:

;boom_7seg.c,25 :: 		void countdown(int countD) {
;boom_7seg.c,27 :: 		PORTC = 0xF0 & 0;          //Clear Segments, preserve PORTC4-7
	CLRF        PORTC+0 
;boom_7seg.c,30 :: 		for (i=(countD+1);i>0;i--){
	MOVF        FARG_countdown_countD+0, 0 
	ADDLW       1
	MOVWF       _i+0 
L_countdown1:
	MOVF        _i+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_countdown2
;boom_7seg.c,31 :: 		inttostr(i-1,counting);
	DECF        _i+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	CLRF        FARG_IntToStr_input+1 
	MOVLW       0
	SUBWFB      FARG_IntToStr_input+1, 1 
	MOVLW       countdown_counting_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(countdown_counting_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;boom_7seg.c,32 :: 		LCD_OUT(2,1,"                ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;boom_7seg.c,33 :: 		LCD_OUT(2,7, counting);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       countdown_counting_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(countdown_counting_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;boom_7seg.c,34 :: 		LCD_OUT(2,1,"time: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;boom_7seg.c,35 :: 		LCD_OUT(2,13,"s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;boom_7seg.c,36 :: 		tens = (i-1)/10;
	DECF        _i+0, 0 
	MOVWF       FLOC__countdown+0 
	CLRF        FLOC__countdown+1 
	MOVLW       0
	SUBWFB      FLOC__countdown+1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__countdown+0, 0 
	MOVWF       R0 
	MOVF        FLOC__countdown+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _tens+0 
;boom_7seg.c,37 :: 		units = (i-1)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__countdown+0, 0 
	MOVWF       R0 
	MOVF        FLOC__countdown+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _units+0 
;boom_7seg.c,38 :: 		seg_tens = 1;              //select the "tens" seven segment digit
	BSF         RD0_bit+0, 0 
;boom_7seg.c,39 :: 		PORTC = 0xF0 | tens;
	MOVLW       240
	IORWF       _tens+0, 0 
	MOVWF       PORTC+0 
;boom_7seg.c,40 :: 		delay_ms(5);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_countdown4:
	DECFSZ      R13, 1, 0
	BRA         L_countdown4
	DECFSZ      R12, 1, 0
	BRA         L_countdown4
;boom_7seg.c,41 :: 		seg_tens = 0;
	BCF         RD0_bit+0, 0 
;boom_7seg.c,42 :: 		seg_units = 1;             //select the "units" seven segment digit
	BSF         RD1_bit+0, 1 
;boom_7seg.c,43 :: 		PORTC = 0xF0 | units;
	MOVLW       240
	IORWF       _units+0, 0 
	MOVWF       PORTC+0 
;boom_7seg.c,44 :: 		seg_units = 0;
	BCF         RD1_bit+0, 1 
;boom_7seg.c,45 :: 		PORTC = 0xF0 & 0;       //Clear contents to Segments, preserve PORTC4-7
	CLRF        PORTC+0 
;boom_7seg.c,46 :: 		delay_ms(994);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       227
	MOVWF       R13, 0
L_countdown5:
	DECFSZ      R13, 1, 0
	BRA         L_countdown5
	DECFSZ      R12, 1, 0
	BRA         L_countdown5
	DECFSZ      R11, 1, 0
	BRA         L_countdown5
;boom_7seg.c,30 :: 		for (i=(countD+1);i>0;i--){
	DECF        _i+0, 1 
;boom_7seg.c,47 :: 		}
	GOTO        L_countdown1
L_countdown2:
;boom_7seg.c,49 :: 		}
	RETURN      0
; end of _countdown

_tf_test:

;traffic_control.c,12 :: 		void tf_test() {
;traffic_control.c,13 :: 		PORTA = 0;
	CLRF        PORTA+0 
;traffic_control.c,14 :: 		TRISA = 0;
	CLRF        TRISA+0 
;traffic_control.c,15 :: 		PORTA =0xFF;
	MOVLW       255
	MOVWF       PORTA+0 
;traffic_control.c,16 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_tf_test6:
	DECFSZ      R13, 1, 0
	BRA         L_tf_test6
	DECFSZ      R12, 1, 0
	BRA         L_tf_test6
	DECFSZ      R11, 1, 0
	BRA         L_tf_test6
	NOP
	NOP
;traffic_control.c,17 :: 		PORTA = 0;
	CLRF        PORTA+0 
;traffic_control.c,18 :: 		}
	RETURN      0
; end of _tf_test

_tf_stop:

;traffic_control.c,20 :: 		void tf_stop()
;traffic_control.c,23 :: 		delay_ms(250);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_tf_stop7:
	DECFSZ      R13, 1, 0
	BRA         L_tf_stop7
	DECFSZ      R12, 1, 0
	BRA         L_tf_stop7
	DECFSZ      R11, 1, 0
	BRA         L_tf_stop7
	NOP
	NOP
;traffic_control.c,24 :: 		PORTA |= amber;
	BSF         PORTA+0, 1 
;traffic_control.c,25 :: 		boom_down = 1;
	BSF         RC4_bit+0, 4 
;traffic_control.c,26 :: 		boom_up = 0;
	BCF         RC5_bit+0, 5 
;traffic_control.c,27 :: 		delay_ms(3000);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_tf_stop8:
	DECFSZ      R13, 1, 0
	BRA         L_tf_stop8
	DECFSZ      R12, 1, 0
	BRA         L_tf_stop8
	DECFSZ      R11, 1, 0
	BRA         L_tf_stop8
	NOP
	NOP
;traffic_control.c,28 :: 		PORTA |= red;
	BSF         PORTA+0, 0 
;traffic_control.c,29 :: 		}
	RETURN      0
; end of _tf_stop

_main:

;Boom_controller.c,15 :: 		void main() {
;Boom_controller.c,18 :: 		TRISB = 127;
	MOVLW       127
	MOVWF       TRISB+0 
;Boom_controller.c,19 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Boom_controller.c,20 :: 		TRISC = 0;
	CLRF        TRISC+0 
;Boom_controller.c,21 :: 		TRISD = 0;
	CLRF        TRISD+0 
;Boom_controller.c,22 :: 		PORTD = 0;
	CLRF        PORTD+0 
;Boom_controller.c,23 :: 		TRISD = 0;
	CLRF        TRISD+0 
;Boom_controller.c,25 :: 		ADCON1 = 7;                        //configure PORTA pins as Digital IO
	MOVLW       7
	MOVWF       ADCON1+0 
;Boom_controller.c,27 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;Boom_controller.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,30 :: 		TRISB7_Bit = 0;                    //used by the timer LED
	BCF         TRISB7_bit+0, 7 
;Boom_controller.c,31 :: 		proc_timer = 0;
	CLRF        _proc_timer+0 
	CLRF        _proc_timer+1 
;Boom_controller.c,35 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;Boom_controller.c,36 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;Boom_controller.c,37 :: 		T0CON = 0;
	CLRF        T0CON+0 
;Boom_controller.c,38 :: 		T08BIT_bit = 1;
	BSF         T08BIT_bit+0, 6 
;Boom_controller.c,40 :: 		TMR0ON_bit = 1;  //start the timer
	BSF         TMR0ON_bit+0, 7 
;Boom_controller.c,41 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, 2 
;Boom_controller.c,42 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, 5 
;Boom_controller.c,44 :: 		INTEDG2_bit = 0;   //car on bridge, interrupt on falling edge
	BCF         INTEDG2_bit+0, 4 
;Boom_controller.c,45 :: 		INT2IE_bit = 1;    //enable the interrupt
	BSF         INT2IE_bit+0, 4 
;Boom_controller.c,46 :: 		car_bridge_flag = 0;
	BCF         _car_bridge_flag+0, BitPos(_car_bridge_flag+0) 
;Boom_controller.c,48 :: 		GIE_Bit = 1;     //search for TMR0 interrupt
	BSF         GIE_bit+0, 7 
;Boom_controller.c,51 :: 		tr_warn_flag = 1;
	BSF         _tr_warn_flag+0, BitPos(_tr_warn_flag+0) 
;Boom_controller.c,52 :: 		tr_appr_flag = tr_bridge_flag = tr_off_flag = car_appr_flag = 1;
	BSF         _car_appr_flag+0, BitPos(_car_appr_flag+0) 
	BTFSC       _car_appr_flag+0, BitPos(_car_appr_flag+0) 
	GOTO        L__main50
	BCF         _tr_off_flag+0, BitPos(_tr_off_flag+0) 
	GOTO        L__main51
L__main50:
	BSF         _tr_off_flag+0, BitPos(_tr_off_flag+0) 
L__main51:
	BTFSC       _tr_off_flag+0, BitPos(_tr_off_flag+0) 
	GOTO        L__main52
	BCF         _tr_bridge_flag+0, BitPos(_tr_bridge_flag+0) 
	GOTO        L__main53
L__main52:
	BSF         _tr_bridge_flag+0, BitPos(_tr_bridge_flag+0) 
L__main53:
	BTFSC       _tr_bridge_flag+0, BitPos(_tr_bridge_flag+0) 
	GOTO        L__main54
	BCF         _tr_appr_flag+0, BitPos(_tr_appr_flag+0) 
	GOTO        L__main55
L__main54:
	BSF         _tr_appr_flag+0, BitPos(_tr_appr_flag+0) 
L__main55:
;Boom_controller.c,53 :: 		car_bridge_flag = car_off_flag = tr_stop_flag = tf_stop_flag = 1;
	BSF         _tf_stop_flag+0, BitPos(_tf_stop_flag+0) 
	BTFSC       _tf_stop_flag+0, BitPos(_tf_stop_flag+0) 
	GOTO        L__main56
	BCF         _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
	GOTO        L__main57
L__main56:
	BSF         _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
L__main57:
	BTFSC       _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
	GOTO        L__main58
	BCF         _car_off_flag+0, BitPos(_car_off_flag+0) 
	GOTO        L__main59
L__main58:
	BSF         _car_off_flag+0, BitPos(_car_off_flag+0) 
L__main59:
	BTFSC       _car_off_flag+0, BitPos(_car_off_flag+0) 
	GOTO        L__main60
	BCF         _car_bridge_flag+0, BitPos(_car_bridge_flag+0) 
	GOTO        L__main61
L__main60:
	BSF         _car_bridge_flag+0, BitPos(_car_bridge_flag+0) 
L__main61:
;Boom_controller.c,56 :: 		TRISC = 0;       //for the first four Pins, used to control the seven segment values.
	CLRF        TRISC+0 
;Boom_controller.c,57 :: 		TRISD = 0;       //for the two latch-enable pins
	CLRF        TRISD+0 
;Boom_controller.c,58 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Boom_controller.c,61 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,62 :: 		Lcd_Out(1,1, "MHAZO, M.");                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,63 :: 		Lcd_out(2,1,"HIT400");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,64 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 0
	BRA         L_main9
	DECFSZ      R12, 1, 0
	BRA         L_main9
	DECFSZ      R11, 1, 0
	BRA         L_main9
	NOP
	NOP
;Boom_controller.c,65 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,66 :: 		Lcd_Out(1,1, "BRIDGE TRAFFIC");                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,67 :: 		Lcd_out(2,1,"CONTROLLER");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,68 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 0
	BRA         L_main10
	DECFSZ      R12, 1, 0
	BRA         L_main10
	DECFSZ      R11, 1, 0
	BRA         L_main10
	NOP
	NOP
;Boom_controller.c,69 :: 		write_LCD();
	CALL        _write_LCD+0, 0
;Boom_controller.c,72 :: 		PORTA = 0;
	CLRF        PORTA+0 
;Boom_controller.c,73 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Boom_controller.c,74 :: 		TRISA = 0;
	CLRF        TRISA+0 
;Boom_controller.c,75 :: 		PORTA =0xFF;
	MOVLW       255
	MOVWF       PORTA+0 
;Boom_controller.c,76 :: 		PORTC = 8;
	MOVLW       8
	MOVWF       PORTC+0 
;Boom_controller.c,77 :: 		seg_tens = 1;
	BSF         RD0_bit+0, 0 
;Boom_controller.c,78 :: 		seg_units = 1;
	BSF         RD1_bit+0, 1 
;Boom_controller.c,79 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 0
	BRA         L_main11
	DECFSZ      R12, 1, 0
	BRA         L_main11
	DECFSZ      R11, 1, 0
	BRA         L_main11
	NOP
	NOP
;Boom_controller.c,80 :: 		PORTA = 0;
	CLRF        PORTA+0 
;Boom_controller.c,81 :: 		LCDWriteFlag = 0;
	BCF         _LCDWriteFlag+0, BitPos(_LCDWriteFlag+0) 
;Boom_controller.c,84 :: 		while(1) {
L_main12:
;Boom_controller.c,85 :: 		while (tr_warn && tr_warn_flag)  //while there is no train approaching
L_main14:
	BTFSS       RB6_bit+0, 6 
	GOTO        L_main15
	BTFSS       _tr_warn_flag+0, BitPos(_tr_warn_flag+0) 
	GOTO        L_main15
L__main49:
;Boom_controller.c,88 :: 		boom_down = 0;
	BCF         RC4_bit+0, 4 
;Boom_controller.c,89 :: 		boom_up = 1;                 //open boom
	BSF         RC5_bit+0, 5 
;Boom_controller.c,90 :: 		PORTA = green;
	MOVLW       4
	MOVWF       PORTA+0 
;Boom_controller.c,91 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main18:
	DECFSZ      R13, 1, 0
	BRA         L_main18
	DECFSZ      R12, 1, 0
	BRA         L_main18
	NOP
	NOP
;Boom_controller.c,92 :: 		} //end while !tr appr
	GOTO        L_main14
L_main15:
;Boom_controller.c,94 :: 		if (!tr_warn && tr_warn_flag)      //train has been sensed
	BTFSC       RB6_bit+0, 6 
	GOTO        L_main21
	BTFSS       _tr_warn_flag+0, BitPos(_tr_warn_flag+0) 
	GOTO        L_main21
L__main48:
;Boom_controller.c,96 :: 		tr_warn_flag = 0;
	BCF         _tr_warn_flag+0, BitPos(_tr_warn_flag+0) 
;Boom_controller.c,97 :: 		LCD_Out(1,1,"Train Approaches");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,98 :: 		countDwn = 15;
	MOVLW       15
	MOVWF       _countDwn+0 
;Boom_controller.c,102 :: 		LCD_OUT(2,1, "15s Countdown");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,103 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 0
	BRA         L_main22
	DECFSZ      R12, 1, 0
	BRA         L_main22
	DECFSZ      R11, 1, 0
	BRA         L_main22
	NOP
	NOP
;Boom_controller.c,104 :: 		countdown(countDwn);
	MOVF        _countDwn+0, 0 
	MOVWF       FARG_countdown_countD+0 
	MOVLW       0
	BTFSC       _countDwn+0, 7 
	MOVLW       255
	MOVWF       FARG_countdown_countD+1 
	CALL        _countdown+0, 0
;Boom_controller.c,105 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,107 :: 		while (RB1_Bit) {
L_main23:
	BTFSS       RB1_bit+0, 1 
	GOTO        L_main24
;Boom_controller.c,108 :: 		if(!car_bridge_flag)
	BTFSC       _car_bridge_flag+0, BitPos(_car_bridge_flag+0) 
	GOTO        L_main25
;Boom_controller.c,111 :: 		INTEDG2_Bit = ~INTEDG2_Bit; //toggle interrupt edge
	BTG         INTEDG2_bit+0, 4 
;Boom_controller.c,112 :: 		if(!LCDWriteFlag) {
	BTFSC       _LCDWriteFlag+0, BitPos(_LCDWriteFlag+0) 
	GOTO        L_main26
;Boom_controller.c,113 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,114 :: 		lcd_out(1,1, "There's a car");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,115 :: 		lcd_out(2,1, "on the bridge!");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,116 :: 		}
L_main26:
;Boom_controller.c,117 :: 		if (tr_stop_flag) {
	BTFSS       _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
	GOTO        L_main27
;Boom_controller.c,118 :: 		tr_stop = 1;
	BSF         RA3_bit+0, 3 
;Boom_controller.c,119 :: 		tr_stop_flag = 0;
	BCF         _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
;Boom_controller.c,120 :: 		}
L_main27:
;Boom_controller.c,121 :: 		}//if car bridge flag
L_main25:
;Boom_controller.c,123 :: 		if (tf_stop_flag) {
	BTFSS       _tf_stop_flag+0, BitPos(_tf_stop_flag+0) 
	GOTO        L_main28
;Boom_controller.c,124 :: 		tf_stop();
	CALL        _tf_stop+0, 0
;Boom_controller.c,125 :: 		tf_stop_flag = 0;
	BCF         _tf_stop_flag+0, BitPos(_tf_stop_flag+0) 
;Boom_controller.c,126 :: 		}
L_main28:
;Boom_controller.c,129 :: 		if(!tr_stop_flag){
	BTFSC       _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
	GOTO        L_main29
;Boom_controller.c,130 :: 		if (!LCDWriteFlag) {
	BTFSC       _LCDWriteFlag+0, BitPos(_LCDWriteFlag+0) 
	GOTO        L_main30
;Boom_controller.c,131 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,132 :: 		lcd_out(1,1,"Train Stopped.");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,133 :: 		}
L_main30:
;Boom_controller.c,134 :: 		}
L_main29:
;Boom_controller.c,135 :: 		LCDWriteFlag = 1;       //write once, so that LCD doesn't blink
	BSF         _LCDWriteFlag+0, BitPos(_LCDWriteFlag+0) 
;Boom_controller.c,136 :: 		}
	GOTO        L_main23
L_main24:
;Boom_controller.c,137 :: 		} //while no car has gotten off the bridge after train was detected
L_main21:
;Boom_controller.c,139 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,142 :: 		while(!tr_bridge) {
L_main31:
	BTFSC       RB5_bit+0, 5 
	GOTO        L_main32
;Boom_controller.c,143 :: 		tr_bridge_flag = 0;
	BCF         _tr_bridge_flag+0, BitPos(_tr_bridge_flag+0) 
;Boom_controller.c,144 :: 		if (tr_stop_flag)lcd_out(1,1,"TRAIN ON BRIDGE");
	BTFSS       _tr_stop_flag+0, BitPos(_tr_stop_flag+0) 
	GOTO        L_main33
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_main33:
;Boom_controller.c,145 :: 		}
	GOTO        L_main31
L_main32:
;Boom_controller.c,146 :: 		while(!tr_off && tr_off_flag && !tr_bridge_flag)
L_main34:
	BTFSC       RB0_bit+0, 0 
	GOTO        L_main35
	BTFSS       _tr_off_flag+0, BitPos(_tr_off_flag+0) 
	GOTO        L_main35
	BTFSC       _tr_bridge_flag+0, BitPos(_tr_bridge_flag+0) 
	GOTO        L_main35
L__main47:
;Boom_controller.c,148 :: 		tr_off_flag = 0;    //train is now getting off bridge.
	BCF         _tr_off_flag+0, BitPos(_tr_off_flag+0) 
;Boom_controller.c,150 :: 		}
	GOTO        L_main34
L_main35:
;Boom_controller.c,151 :: 		while(tr_off && !tr_off_flag)
L_main38:
	BTFSS       RB0_bit+0, 0 
	GOTO        L_main39
	BTFSC       _tr_off_flag+0, BitPos(_tr_off_flag+0) 
	GOTO        L_main39
L__main46:
;Boom_controller.c,153 :: 		tr_off_flag = 1;
	BSF         _tr_off_flag+0, BitPos(_tr_off_flag+0) 
;Boom_controller.c,154 :: 		tr_warn_flag = 1;
	BSF         _tr_warn_flag+0, BitPos(_tr_warn_flag+0) 
;Boom_controller.c,155 :: 		tr_bridge_flag = 1;
	BSF         _tr_bridge_flag+0, BitPos(_tr_bridge_flag+0) 
;Boom_controller.c,156 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boom_controller.c,157 :: 		lcd_out(1,1,"Train Passed");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_Boom_controller+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_Boom_controller+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boom_controller.c,158 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main42:
	DECFSZ      R13, 1, 0
	BRA         L_main42
	DECFSZ      R12, 1, 0
	BRA         L_main42
	DECFSZ      R11, 1, 0
	BRA         L_main42
	NOP
	NOP
;Boom_controller.c,159 :: 		PORTA |= green;
	BSF         PORTA+0, 2 
;Boom_controller.c,160 :: 		boom_up = 1;
	BSF         RC5_bit+0, 5 
;Boom_controller.c,161 :: 		boom_down = 0;
	BCF         RC4_bit+0, 4 
;Boom_controller.c,162 :: 		write_LCD();
	CALL        _write_LCD+0, 0
;Boom_controller.c,163 :: 		}
	GOTO        L_main38
L_main39:
;Boom_controller.c,165 :: 		}//end endless
	GOTO        L_main12
;Boom_controller.c,167 :: 		}
	GOTO        $+0
; end of _main

_interrupt:

;Boom_controller.c,171 :: 		void interrupt()
;Boom_controller.c,173 :: 		if (TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt43
;Boom_controller.c,174 :: 		{TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, 2 
;Boom_controller.c,175 :: 		proc_timer++;
	INFSNZ      _proc_timer+0, 1 
	INCF        _proc_timer+1, 1 
;Boom_controller.c,176 :: 		if (proc_timer == 1953)
	MOVF        _proc_timer+1, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt63
	MOVLW       161
	XORWF       _proc_timer+0, 0 
L__interrupt63:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt44
;Boom_controller.c,178 :: 		RB7_bit=~RB7_bit;
	BTG         RB7_bit+0, 7 
;Boom_controller.c,179 :: 		proc_timer = 0;
	CLRF        _proc_timer+0 
	CLRF        _proc_timer+1 
;Boom_controller.c,180 :: 		}
L_interrupt44:
;Boom_controller.c,181 :: 		}//if
L_interrupt43:
;Boom_controller.c,183 :: 		if (INT2IF_Bit) {
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt45
;Boom_controller.c,184 :: 		INT2IF_bit = 0;
	BCF         INT2IF_bit+0, 1 
;Boom_controller.c,185 :: 		car_bridge_flag = ~car_bridge_flag;
	BTG         _car_bridge_flag+0, BitPos(_car_bridge_flag+0) 
;Boom_controller.c,186 :: 		}//if
L_interrupt45:
;Boom_controller.c,187 :: 		}
L__interrupt62:
	RETFIE      1
; end of _interrupt
