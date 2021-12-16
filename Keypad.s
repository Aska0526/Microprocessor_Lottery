#include <xc.inc>


global	Keypad_read_column, Keypad_read_row

    
psect	udata_acs   ; named variables in access ram
LCD_cnt_l:	ds 1   ; reserve 1 byte for variable LCD_cnt_l
LCD_cnt_h:	ds 1   ; reserve 1 byte for variable LCD_cnt_h
LCD_cnt_ms:	ds 1   ; reserve 1 byte for ms counter
LCD_tmp:	ds 1   ; reserve 1 byte for temporary use
LCD_counter:	ds 1   ; reserve 1 byte for counting through nessage

	LCD_E	EQU 5	; LCD enable bit
    	LCD_RS	EQU 4	; LCD register select bit

    
    
psect	keypad_code,class=CODE    
    
Keypad_read_column: 
    banksel	PADCFG1
    bsf	    REPU      
    clrf    LATE, A
    movlw   0x0F   ;initialsie the lowest 4 bits of PortE, representing the different columns on keypad
    movwf   TRISE, A
    return
    
Keypad_read_row:
    banksel	PADCFG1
    bsf	    REPU
    clrf    LATE, A
    movlw   0xF0	;initialsie the highest 4 bits of PortE, representing the different rows on keypad
    movwf   TRISE, A
    return   


