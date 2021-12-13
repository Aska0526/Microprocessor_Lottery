#include<xc.inc>

global  Init_TMR2   

psect	buzzer_code,class=CODE    
    
    
Init_TMR2:    
    movlw   0x90  ;144 to timer2 period
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
  
  
    
    return
    
    


