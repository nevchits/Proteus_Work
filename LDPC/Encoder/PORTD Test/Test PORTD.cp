#line 1 "C:/Documents and Settings/Neville/My Documents/PROTEUS/20 LDPC/Encoder/PORTD Test/Test PORTD.c"

void main() {
 PORTD = 0;
 TRISD = 0;
while (1) {
PORTD = 7;
delay_ms(500);
PORTD = 0;
delay_ms(500);
}

}
