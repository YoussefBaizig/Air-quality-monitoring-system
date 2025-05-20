
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;AirQualityMonitoringSystem.c,35 :: 		void interrupt() {
;AirQualityMonitoringSystem.c,36 :: 		if (INTCON.RBIF) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt0
;AirQualityMonitoringSystem.c,48 :: 		if (PORTB.RB7){
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt1
;AirQualityMonitoringSystem.c,49 :: 		var3=1;
	MOVLW      1
	MOVWF      _var3+0
	MOVLW      0
	MOVWF      _var3+1
;AirQualityMonitoringSystem.c,50 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;AirQualityMonitoringSystem.c,52 :: 		var3=0;
	CLRF       _var3+0
	CLRF       _var3+1
;AirQualityMonitoringSystem.c,53 :: 		}
L_interrupt2:
;AirQualityMonitoringSystem.c,54 :: 		INTCON.RBIF = 0;
	BCF        INTCON+0, 0
;AirQualityMonitoringSystem.c,55 :: 		}
L_interrupt0:
;AirQualityMonitoringSystem.c,56 :: 		if(INTCON.T0IF)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt3
;AirQualityMonitoringSystem.c,58 :: 		var=1;
	MOVLW      1
	MOVWF      _var+0
	MOVLW      0
	MOVWF      _var+1
;AirQualityMonitoringSystem.c,59 :: 		TMR0=252;
	MOVLW      252
	MOVWF      TMR0+0
;AirQualityMonitoringSystem.c,60 :: 		INTCON.T0IF=0;
	BCF        INTCON+0, 2
;AirQualityMonitoringSystem.c,61 :: 		}
L_interrupt3:
;AirQualityMonitoringSystem.c,62 :: 		if(INTCON.INTF)
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt4
;AirQualityMonitoringSystem.c,64 :: 		INTCON.RBIE = 1;
	BSF        INTCON+0, 3
;AirQualityMonitoringSystem.c,65 :: 		var1=1;
	MOVLW      1
	MOVWF      _var1+0
	MOVLW      0
	MOVWF      _var1+1
;AirQualityMonitoringSystem.c,67 :: 		INTCON.INTF=0;
	BCF        INTCON+0, 1
;AirQualityMonitoringSystem.c,68 :: 		}
L_interrupt4:
;AirQualityMonitoringSystem.c,69 :: 		}
L_end_interrupt:
L__interrupt29:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_buzzerAndLED:

;AirQualityMonitoringSystem.c,71 :: 		void buzzerAndLED(int count) {
;AirQualityMonitoringSystem.c,73 :: 		for (i = 0; i < count; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_buzzerAndLED5:
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_buzzerAndLED_count+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__buzzerAndLED31
	MOVF       FARG_buzzerAndLED_count+0, 0
	SUBWF      R1+0, 0
L__buzzerAndLED31:
	BTFSC      STATUS+0, 0
	GOTO       L_buzzerAndLED6
;AirQualityMonitoringSystem.c,74 :: 		PORTA.RA1 = 1;
	BSF        PORTA+0, 1
;AirQualityMonitoringSystem.c,75 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_buzzerAndLED8:
	DECFSZ     R13+0, 1
	GOTO       L_buzzerAndLED8
	DECFSZ     R12+0, 1
	GOTO       L_buzzerAndLED8
	NOP
;AirQualityMonitoringSystem.c,76 :: 		PORTA.RA1 = 0;
	BCF        PORTA+0, 1
;AirQualityMonitoringSystem.c,77 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_buzzerAndLED9:
	DECFSZ     R13+0, 1
	GOTO       L_buzzerAndLED9
	DECFSZ     R12+0, 1
	GOTO       L_buzzerAndLED9
	NOP
;AirQualityMonitoringSystem.c,73 :: 		for (i = 0; i < count; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;AirQualityMonitoringSystem.c,78 :: 		}
	GOTO       L_buzzerAndLED5
L_buzzerAndLED6:
;AirQualityMonitoringSystem.c,79 :: 		}
L_end_buzzerAndLED:
	RETURN
; end of _buzzerAndLED

_resetSystem:

;AirQualityMonitoringSystem.c,81 :: 		void resetSystem() {
;AirQualityMonitoringSystem.c,82 :: 		temperature = 0;
	CLRF       _temperature+0
	CLRF       _temperature+1
	CLRF       _temperature+2
	CLRF       _temperature+3
;AirQualityMonitoringSystem.c,83 :: 		PORTB.RB1 = 1;
	BSF        PORTB+0, 1
;AirQualityMonitoringSystem.c,84 :: 		PORTA.RA0 = 0;
	BCF        PORTA+0, 0
;AirQualityMonitoringSystem.c,85 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,86 :: 		Lcd_Out(2, 6, "LIBERE");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,87 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_resetSystem10:
	DECFSZ     R13+0, 1
	GOTO       L_resetSystem10
	DECFSZ     R12+0, 1
	GOTO       L_resetSystem10
	DECFSZ     R11+0, 1
	GOTO       L_resetSystem10
	NOP
	NOP
;AirQualityMonitoringSystem.c,88 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,89 :: 		Lcd_Out(2, 6, "EN VEILLE");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,90 :: 		if(PORTB.RB4){
	BTFSS      PORTB+0, 4
	GOTO       L_resetSystem11
;AirQualityMonitoringSystem.c,91 :: 		var1=0;
	CLRF       _var1+0
	CLRF       _var1+1
;AirQualityMonitoringSystem.c,92 :: 		}
L_resetSystem11:
;AirQualityMonitoringSystem.c,95 :: 		}
L_end_resetSystem:
	RETURN
; end of _resetSystem

_main:

;AirQualityMonitoringSystem.c,97 :: 		void main() {
;AirQualityMonitoringSystem.c,98 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;AirQualityMonitoringSystem.c,99 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,100 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,101 :: 		Lcd_Out(2, 6, "EN VEILLE");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,102 :: 		PORTA.RA1 = 1;
	BSF        PORTA+0, 1
;AirQualityMonitoringSystem.c,103 :: 		PORTB.RA0 = 0;
	BCF        PORTB+0, 0
;AirQualityMonitoringSystem.c,105 :: 		PORTB.RB1 = 1;
	BSF        PORTB+0, 1
;AirQualityMonitoringSystem.c,106 :: 		TRISA = 0b110000;
	MOVLW      48
	MOVWF      TRISA+0
;AirQualityMonitoringSystem.c,107 :: 		TRISB0_bit = 1;
	BSF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;AirQualityMonitoringSystem.c,108 :: 		TRISB1_bit = 0;
	BCF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;AirQualityMonitoringSystem.c,109 :: 		TRISB4_bit = 1;
	BSF        TRISB4_bit+0, BitPos(TRISB4_bit+0)
;AirQualityMonitoringSystem.c,112 :: 		ADC_Init();
	CALL       _ADC_Init+0
;AirQualityMonitoringSystem.c,113 :: 		EEPROM_Write(TEMPERATURE_THRESHOLD, 23);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      23
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;AirQualityMonitoringSystem.c,114 :: 		EEPROM_Write(NB_DEPASSEMENT, nb_depassement);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _nb_depassement+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;AirQualityMonitoringSystem.c,115 :: 		EEPROM_Write(HUMIDITY_THRESHOLD, 30);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVLW      30
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;AirQualityMonitoringSystem.c,117 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;AirQualityMonitoringSystem.c,118 :: 		INTCON.INTE = 1;
	BSF        INTCON+0, 4
;AirQualityMonitoringSystem.c,120 :: 		OPTION_REG.T0CS=1;
	BSF        OPTION_REG+0, 5
;AirQualityMonitoringSystem.c,121 :: 		OPTION_REG.T0SE=0;
	BCF        OPTION_REG+0, 4
;AirQualityMonitoringSystem.c,122 :: 		OPTION_REG.PSA=1;
	BSF        OPTION_REG+0, 3
;AirQualityMonitoringSystem.c,123 :: 		OPTION_REG.PS0=1;
	BSF        OPTION_REG+0, 0
;AirQualityMonitoringSystem.c,124 :: 		OPTION_REG.PS1=0;
	BCF        OPTION_REG+0, 1
;AirQualityMonitoringSystem.c,125 :: 		OPTION_REG.PS2=0;
	BCF        OPTION_REG+0, 2
;AirQualityMonitoringSystem.c,126 :: 		OPTION_REG.INTEDG=1;
	BSF        OPTION_REG+0, 6
;AirQualityMonitoringSystem.c,127 :: 		TMR0=252;
	MOVLW      252
	MOVWF      TMR0+0
;AirQualityMonitoringSystem.c,128 :: 		while (1) {
L_main12:
;AirQualityMonitoringSystem.c,129 :: 		if(var3){
	MOVF       _var3+0, 0
	IORWF      _var3+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;AirQualityMonitoringSystem.c,130 :: 		nb_depassement=EEPROM_Read(NB_DEPASSEMENT);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _nb_depassement+0
	CLRF       _nb_depassement+1
;AirQualityMonitoringSystem.c,131 :: 		IntToStr(nb_depassement, ch_depassement);
	MOVF       _nb_depassement+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _nb_depassement+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _ch_depassement+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;AirQualityMonitoringSystem.c,132 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,133 :: 		Lcd_Out(2,6,"problemes");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,134 :: 		Lcd_Out(3, 2, ch_depassement);
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _ch_depassement+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,135 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;AirQualityMonitoringSystem.c,136 :: 		var3=0;
	CLRF       _var3+0
	CLRF       _var3+1
;AirQualityMonitoringSystem.c,137 :: 		}
L_main14:
;AirQualityMonitoringSystem.c,140 :: 		if(var1 == 1) {
	MOVLW      0
	XORWF      _var1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      1
	XORWF      _var1+0, 0
L__main34:
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;AirQualityMonitoringSystem.c,142 :: 		if(PORTB.RB4==1)
	BTFSS      PORTB+0, 4
	GOTO       L_main17
;AirQualityMonitoringSystem.c,144 :: 		temperature = ADC_Read(4) * 0.488;
	MOVLW      4
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      219
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temperature+0
	MOVF       R0+1, 0
	MOVWF      _temperature+1
	MOVF       R0+2, 0
	MOVWF      _temperature+2
	MOVF       R0+3, 0
	MOVWF      _temperature+3
;AirQualityMonitoringSystem.c,145 :: 		hum = ADC_Read(5) * 0.488;
	MOVLW      5
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      219
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _hum+0
	MOVF       R0+1, 0
	MOVWF      _hum+1
	MOVF       R0+2, 0
	MOVWF      _hum+2
	MOVF       R0+3, 0
	MOVWF      _hum+3
;AirQualityMonitoringSystem.c,146 :: 		FloatToStr(temperature, temperature_str);
	MOVF       _temperature+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _temperature+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _temperature+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _temperature+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _temperature_str+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;AirQualityMonitoringSystem.c,147 :: 		FloatToStr(hum, hum_str);
	MOVF       _hum+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _hum+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _hum+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _hum+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _hum_str+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;AirQualityMonitoringSystem.c,148 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,149 :: 		Lcd_Out(2, 5, "GAZ DETECTED");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,150 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
;AirQualityMonitoringSystem.c,151 :: 		PORTA.RA1 = 0;
	BCF        PORTA+0, 1
;AirQualityMonitoringSystem.c,152 :: 		PORTA.RA0 = 1;
	BSF        PORTA+0, 0
;AirQualityMonitoringSystem.c,153 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,154 :: 		strcat(temperature_str, degree);
	MOVLW      _temperature_str+0
	MOVWF      FARG_strcat_to+0
	MOVLW      _degree+0
	MOVWF      FARG_strcat_from+0
	CALL       _strcat+0
;AirQualityMonitoringSystem.c,156 :: 		Lcd_Out(2, 2, "Temp = ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,157 :: 		Lcd_Out(2, 9, temperature_str);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temperature_str+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,160 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
;AirQualityMonitoringSystem.c,162 :: 		}
	GOTO       L_main20
L_main17:
;AirQualityMonitoringSystem.c,165 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,166 :: 		Lcd_Out(2, 5, "GAZ NOT DETECTED");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,167 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
	NOP
;AirQualityMonitoringSystem.c,169 :: 		}
L_main20:
;AirQualityMonitoringSystem.c,170 :: 		var1=0;
	CLRF       _var1+0
	CLRF       _var1+1
;AirQualityMonitoringSystem.c,172 :: 		if(temperature > EEPROM_Read(TEMPERATURE_THRESHOLD) || hum> EEPROM_Read(HUMIDITY_THRESHOLD)) {
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	CALL       _byte2double+0
	MOVF       _temperature+0, 0
	MOVWF      R4+0
	MOVF       _temperature+1, 0
	MOVWF      R4+1
	MOVF       _temperature+2, 0
	MOVWF      R4+2
	MOVF       _temperature+3, 0
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	CALL       _byte2double+0
	MOVF       _hum+0, 0
	MOVWF      R4+0
	MOVF       _hum+1, 0
	MOVWF      R4+1
	MOVF       _hum+2, 0
	MOVWF      R4+2
	MOVF       _hum+3, 0
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	GOTO       L_main24
L__main27:
;AirQualityMonitoringSystem.c,173 :: 		temperature = ADC_Read(4) * 0.488;
	MOVLW      4
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      219
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temperature+0
	MOVF       R0+1, 0
	MOVWF      _temperature+1
	MOVF       R0+2, 0
	MOVWF      _temperature+2
	MOVF       R0+3, 0
	MOVWF      _temperature+3
;AirQualityMonitoringSystem.c,174 :: 		hum = ADC_Read(5) * 0.488;
	MOVLW      5
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      219
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _hum+0
	MOVF       R0+1, 0
	MOVWF      _hum+1
	MOVF       R0+2, 0
	MOVWF      _hum+2
	MOVF       R0+3, 0
	MOVWF      _hum+3
;AirQualityMonitoringSystem.c,175 :: 		nb_depassement++;
	INCF       _nb_depassement+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nb_depassement+1, 1
;AirQualityMonitoringSystem.c,176 :: 		EEPROM_Write(NB_DEPASSEMENT, nb_depassement);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _nb_depassement+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;AirQualityMonitoringSystem.c,178 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;AirQualityMonitoringSystem.c,179 :: 		Lcd_Out(1, 5, "DANGER !");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,180 :: 		Lcd_Out(3, 5, "Depassement");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,181 :: 		Lcd_Out(4, 5, "de seuil !");
	MOVLW      4
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_AirQualityMonitoringSystem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;AirQualityMonitoringSystem.c,183 :: 		PORTB.RB1 = 0;
	BCF        PORTB+0, 1
;AirQualityMonitoringSystem.c,184 :: 		buzzerANDLED(6);
	MOVLW      6
	MOVWF      FARG_buzzerAndLED_count+0
	MOVLW      0
	MOVWF      FARG_buzzerAndLED_count+1
	CALL       _buzzerAndLED+0
;AirQualityMonitoringSystem.c,185 :: 		INTCON.T0IE=1;
	BSF        INTCON+0, 5
;AirQualityMonitoringSystem.c,186 :: 		var1=0;
	CLRF       _var1+0
	CLRF       _var1+1
;AirQualityMonitoringSystem.c,187 :: 		}
	GOTO       L_main25
L_main24:
;AirQualityMonitoringSystem.c,189 :: 		PORTB.RB1 = 1;
	BSF        PORTB+0, 1
;AirQualityMonitoringSystem.c,190 :: 		var2=1;
	MOVLW      1
	MOVWF      _var2+0
	MOVLW      0
	MOVWF      _var2+1
;AirQualityMonitoringSystem.c,191 :: 		}
L_main25:
;AirQualityMonitoringSystem.c,192 :: 		}
L_main16:
;AirQualityMonitoringSystem.c,193 :: 		if(var==1)
	MOVLW      0
	XORWF      _var+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      1
	XORWF      _var+0, 0
L__main35:
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;AirQualityMonitoringSystem.c,195 :: 		resetSystem();
	CALL       _resetSystem+0
;AirQualityMonitoringSystem.c,196 :: 		var=0;
	CLRF       _var+0
	CLRF       _var+1
;AirQualityMonitoringSystem.c,197 :: 		}
L_main26:
;AirQualityMonitoringSystem.c,198 :: 		}
	GOTO       L_main12
;AirQualityMonitoringSystem.c,199 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
