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
    clrf    LATC, A
    movlw   0x0F
    movwf   TRISC, A
    movlw   10		; wait 40us
;    call    LCD_delay_x4us
    return
    
Keypad_read_row:
    banksel	PADCFG1
    bsf	    REPU
    clrf    LATC, A
    movlw   0xF0
    movwf   TRISC, A
    movlw   10		; wait 40us
;    call    LCD_delay_x4us
    return   


;LCD_delay_x4us:		    ; delay given in chunks of 4 microsecond in W
;	movwf	LCD_cnt_l, A	; now need to multiply by 16
;	swapf   LCD_cnt_l, F, A	; swap nibbles
;	movlw	0x0f	    
;	andwf	LCD_cnt_l, W, A ; move low nibble to W
;	movwf	LCD_cnt_h, A	; then to LCD_cnt_h
;	movlw	0xf0	    
;	andwf	LCD_cnt_l, F, A ; keep high nibble in LCD_cnt_l
;	call	LCD_delay
;	return
;LCD_delay:			; delay routine	4 instruction loop == 250ns	    
;	movlw 	0x00		; W=0	


