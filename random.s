#include <xc.inc>
    
global	timer_setup,timer_read
    
psect	udata_acs   
delay_count:	ds 1	
    
psect	ran_code,class=CODE


timer_setup:
	movlw	01001000B; set the timer in 8-bit mode, no pre-scaling
	movwf	T0CON, A
	movlw	0x00; set initial value for timer0low
	movwf	TMR0L, A
	bcf	INTCON, 2; clear off timer0if bit
	bsf	T0CON, 7; start timer
	return
	
timer_read:
	;xyz:
	    ;btfss   INTCON, 2; see when the timer reaches the roll-over point
	    ;bra	    xyz
	;bcf	T0CON, 7; close the timer
	movf    TMR0L, W, A; display result
	return
