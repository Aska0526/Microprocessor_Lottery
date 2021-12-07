    #include <xc.inc>
    
psect	udata_acs   ; named variables in access ram
pull:	    ds 1   ; draw a lottery
check:      ds 1   ; check balance
ifIR:       ds 1   ; reset
temp_1:	    ds 1
temp_2:	    ds 1
temp_3:	    ds 1
temp_4:	    ds 1
counter:    ds 1    ; reserve one byte for a counter variable
delay_count:ds 1    ; reserve one byte for counter in the delay routine
digit1:	    ds 1
digit2:	    ds 1
digit3:	    ds 1
   

extrn   Keypad_read_column
extrn   timer_setup, timer_read
extrn   LCD_Setup, LCD_Write_Message, LCD_Send_Byte_I, LCD_delay_x4us, LCD_delay_ms, LCD_Send_Byte_D
extrn   start1, start2
extrn   find_prize
    
psect	code, abs
setup:
	org	0x0 
	
	movlw	0xFF       ; for delay
	movwf	temp_1, A
	movwf	temp_2, A
	movwf	temp_3, A
	movlw	0x05
	movwf   temp_4, A 
	
	movlw   00110001B  ; set initial value of balance to be 100 in ASCII
	movwf   digit1, A
	;movlw   00111001B ; 9 in ASCII
	movlw   00110000B
	movwf   digit2, A
	movwf   digit3, A
	
	movlw   0x0
	movwf   TRISC, A
	movwf   TRISD, A
	
	movlw   00001110B ;give value to pull
	movwf   pull
	movlw   00001101B ;give value to check
	movwf   check
	movlw   00001011B ;give value to ifIR
	movwf   ifIR
	
	bcf	CFGS	; point to Flash program memory  
	bsf	EEPGD 	; access Flash program memory
	call	LCD_Setup	; setup LCD
	call	timer_setup
	
	goto    main
	
main:
	call    Keypad_read_column
	call    drawing
	call    balance_check
	call    IR
	bra     main
	;other condition which I haven't thought of
	;bra	
	
drawing:
	movf	PORTE, W
	cpfseq	pull, A ;compare if it is the 1st column, if it is then skip next line
	return
	
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	call    start1
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movlw	00110000B
	cpfseq  digit2, A
	call    normal_minus
	call    carry_minus
	
	movlw   11000000B	; set address to the second line
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	call    timer_read
	movwf   PORTC
	nop
	nop
	nop
	nop
	call    find_prize
	
	call    delay_1s
	return

balance_check:
	movf	PORTE, W
	cpfseq	check, A
	return
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	call	start2
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movlw   11000000B	; set address to the second line
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf	digit1, W, A    ; first digit
	call	LCD_Send_Byte_D
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	movf	digit2, W, A	; second digit
	call	LCD_Send_Byte_D 
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	movf	digit3, W, A	; third digit
	call	LCD_Send_Byte_D
	
	call    delay_1s
	return
	
IR:
	movf	PORTE, W
	cpfseq	ifIR, A
	return
	call    LCD_Setup
	return



normal_minus:
    decf  digit2, 1, 0
    return

carry_minus:
    movlw  00110000B
    cpfseq   digit2, A
    return
 ;do the carry bit
    decf   digit1, 1, 0
    movlw  00111001B
    movwf  digit2, A
    return


delay_1s:
	;banksel	temp_1
	decfsz	temp_1
	goto	$-1
	decfsz	temp_2
	goto	$-3
	decfsz	temp_3
	goto	$-5
	decfsz	temp_4
	goto	$-7
	return
	
	end	main
	

	
