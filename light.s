#include <xc.inc>
    
    global light

    extrn   LCD_delay_ms

psect	udata_acs   
count:	ds 1	    
    
psect	light_code,class=CODE
    
light:
    movlw   0x0a
    movwf   count, A
    loop:
	movlw	0xff
	movwf	PORTC, A
	call	delay_50ms
	movwf	PORTD, A
	call	delay_50ms
	movwf	PORTE, A
	call	delay_50ms
	movwf	PORTF, A
	call	delay_50ms
	movwf	PORTG, A
	call	delay_50ms
	movwf	PORTH, A
	call	delay_50ms
	movwf	PORTJ, A
	call	delay_50ms
	
	movlw	0x0
	movwf	PORTC, A
	call	delay_50ms
	movwf	PORTD, A
	call	delay_50ms
	movwf	PORTE, A
	call	delay_50ms
	movwf	PORTF, A
	call	delay_50ms
	movwf	PORTG, A
	call	delay_50ms
	movwf	PORTH, A
	call	delay_50ms
	movwf	PORTJ, A
	call	delay_50ms
	
	decfsz	count, A
	bra	loop
	return
	
    return	
	
delay_50ms:
    movlw   0x32
    call    LCD_delay_ms