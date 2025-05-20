#line 1 "C:/Users/youss/OneDrive/Bureau/MyPROJECTS/Air-quality-monitoring-system/AirQualityMonitoringSystem.c"





sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC2_bit;
sbit LCD_D4 at RC3_bit;
sbit LCD_D5 at RC4_bit;
sbit LCD_D6 at RC5_bit;
sbit LCD_D7 at RC6_bit;
sbit LCD_RS_DIRECTION at TRISC0_BIT;
sbit LCD_EN_DIRECTION at TRISC2_BIT;
sbit LCD_D4_DIRECTION at TRISC3_BIT;
sbit LCD_D5_DIRECTION at TRISC4_BIT;
sbit LCD_D6_DIRECTION at TRISC5_BIT;
sbit LCD_D7_DIRECTION at TRISC6_BIT;
sbit HCH_1000 at RA3_bit;

float temperature;
float hum;
int nb_depassement=0;
char ch_depassement[8];
char temperature_str[8];
char hum_str[8];
char degree[] = " C";
char pourcent[] = " %";

int buttonPressCount = 0;
 int var=0;
 int var1=0;
 int var2=0;
 int var3=0;

void interrupt() {
 if (INTCON.RBIF) {
#line 48 "C:/Users/youss/OneDrive/Bureau/MyPROJECTS/Air-quality-monitoring-system/AirQualityMonitoringSystem.c"
 if (PORTB.RB7){
 var3=1;
 }
 else {
 var3=0;
 }
 INTCON.RBIF = 0;
 }
 if(INTCON.T0IF)
 {
 var=1;
 TMR0=252;
 INTCON.T0IF=0;
 }
 if(INTCON.INTF)
 {
 INTCON.RBIE = 1;
 var1=1;

 INTCON.INTF=0;
 }
}

void buzzerAndLED(int count) {
 int i;
 for (i = 0; i < count; i++) {
 PORTA.RA1 = 1;
 Delay_ms(10);
 PORTA.RA1 = 0;
 Delay_ms(10);
 }
}

void resetSystem() {
 temperature = 0;
 PORTB.RB1 = 1;
 PORTA.RA0 = 0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 6, "LIBERE");
 Delay_ms(300);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 6, "EN VEILLE");
 if(PORTB.RB4){
 var1=0;
 }


}

void main() {
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 6, "EN VEILLE");
 PORTA.RA1 = 1;
 PORTB.RA0 = 0;

 PORTB.RB1 = 1;
 TRISA = 0b110000;
 TRISB0_bit = 1;
 TRISB1_bit = 0;
 TRISB4_bit = 1;


 ADC_Init();
 EEPROM_Write( 0x01 , 23);
 EEPROM_Write( 0x02 , nb_depassement);
 EEPROM_Write( 0x00 , 30);

 INTCON.GIE = 1;
 INTCON.INTE = 1;

 OPTION_REG.T0CS=1;
 OPTION_REG.T0SE=0;
 OPTION_REG.PSA=1;
 OPTION_REG.PS0=1;
 OPTION_REG.PS1=0;
 OPTION_REG.PS2=0;
 OPTION_REG.INTEDG=1;
 TMR0=252;
 while (1) {
 if(var3){
 nb_depassement=EEPROM_Read( 0x02 );
 IntToStr(nb_depassement, ch_depassement);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,6,"problemes");
 Lcd_Out(3, 2, ch_depassement);
 delay_ms(300);
 var3=0;
 }


 if(var1 == 1) {

 if(PORTB.RB4==1)
 {
 temperature = ADC_Read(4) * 0.488;
 hum = ADC_Read(5) * 0.488;
 FloatToStr(temperature, temperature_str);
 FloatToStr(hum, hum_str);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 5, "GAZ DETECTED");
 delay_ms(100);
 PORTA.RA1 = 0;
 PORTA.RA0 = 1;
 Lcd_Cmd(_LCD_CLEAR);
 strcat(temperature_str, degree);

 Lcd_Out(2, 2, "Temp = ");
 Lcd_Out(2, 9, temperature_str);
#line 160 "C:/Users/youss/OneDrive/Bureau/MyPROJECTS/Air-quality-monitoring-system/AirQualityMonitoringSystem.c"
 delay_ms(200);

 }
 else
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 5, "GAZ NOT DETECTED");
 delay_ms(100);

 }
 var1=0;

 if(temperature > EEPROM_Read( 0x01 ) || hum> EEPROM_Read( 0x00 )) {
 temperature = ADC_Read(4) * 0.488;
 hum = ADC_Read(5) * 0.488;
 nb_depassement++;
 EEPROM_Write( 0x02 , nb_depassement);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 5, "DANGER !");
 Lcd_Out(3, 5, "Depassement");
 Lcd_Out(4, 5, "de seuil !");

 PORTB.RB1 = 0;
 buzzerANDLED(6);
 INTCON.T0IE=1;
 var1=0;
 }
 else {
 PORTB.RB1 = 1;
 var2=1;
 }
 }
 if(var==1)
 {
 resetSystem();
 var=0;
 }
 }
}
