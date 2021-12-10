#include<xc.inc>

global  Init_TMR2   

psect	buzzer_code,class=CODE    
    
    
Init_TMR2:   
    ;movlw   01110110B; 16MHz  control frequency
    ;movwf   OSCCON
    clrf    CM1CON
    clrf    CM2CON
    
    clrf    PORTA
    clrf    LATA
    clrf    TRISA
    clrf    PORTD
    clrf    LATD
    clrf    TRISD
    
    movlw   00111100B
    movwf   CCP4CON
    movlw   10110101
    movwf   CCPR4L
    
    bcf	    PIR1, 1
    bcf	    T2CON, 1
    bsf	    T2CON, 2
    
    movff   TMR2,  PORTD, A
    
    return
    
    


