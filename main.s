    #include <xc.inc>
    
    global  setup, delay_1s, delay_long, delay_250ms, delay_50ms, delay_25ms ,delay_10ms, delay_5ms, delay_2ms;for 64MHz oscillator 
    
psect	udata_acs   ; named variables in access ram
pull:	    ds 1   ; draw a lottery
check:      ds 1   ; check balance
ifIR:       ds 1   ; reset
temp_1:	    ds 1   ; use for long delay
temp_2:	    ds 1   ; use for long delay
temp_3:	    ds 1   ; use for long delay
temp_4:	    ds 1   ; use for long delay
counter:    ds 1    ; reserve one byte for a counter variable
delay_count:ds 1    ; reserve one byte for counter in the delay routine
digit1:	    ds 1    ;first digit of balance 
digit2:	    ds 1    ;second digit of balance 
digit3:	    ds 1    ;third digit of balance 
ifcarry:    ds 1    ;to see if carry_mius is done  (0/1)
ten:        ds 1    ; number 9 in ASCII and the plus one


extrn   Keypad_read_column
extrn   timer_setup, timer_read
extrn   LCD_Setup, LCD_Write_Message, LCD_Send_Byte_I, LCD_delay_x4us, LCD_delay_ms, LCD_Send_Byte_D
extrn   start1, start2
extrn   find_prize
extrn	extract1, extract2, extract3
extrn   welcome, autoend, manualend, bye
extrn   mov_index,select_tone
    
psect	code, abs
setup:
	org	0x0 
	movlw   0x0
	movwf   ifcarry, A ; This will be used for carry minus latter
	movlw	0xFF       ; for delay
	movwf	temp_1, A
	movwf	temp_2, A
	movwf	temp_3, A
	movlw	0x05
	movwf   temp_4, A 
	
	; set initial value of balance to be 100 in ASCII
	movlw   00110001B  ; the first digit is one
	movwf   digit1, A   
	movlw   00110000B  ; the second and third digits are 0
	movwf   digit2, A
	movwf   digit3, A
	
	movlw   0x0
	movwf   TRISC, A   ; PORTC will be used to show the random number
	
	
	movlw   00001110B ;give value to pull
	movwf   pull
	movlw   00001101B ;give value to check
	movwf   check
	movlw   00001011B ;give value to ifIR
	movwf   ifIR
	
	bcf	CFGS	; point to Flash program memory  
	bsf	EEPGD 	; access Flash program memory
	call	LCD_Setup	; setup LCD
	call    welcome		; show the welcome page on LCD
	call	timer_setup	; set up TIMER0
	
	
	goto    main
	
main:
	call    Keypad_read_column  ; read the output from the keypad
	call    drawing
	call    balance_check
	call    IR
	bra     main	
	
drawing:
	movf	PORTE, W
	cpfseq	pull, A ; to see if the 1st column of keypad is pressed, if it is then skip next line
	return
	
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	call    start1		; show 'you win' on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movlw   0x0
	movwf   ifcarry, A
	movlw	00110000B
	cpfsgt  digit2, A       ; if the second digit of minus is 0, go to carry_minus; if not, go to normal_minus
	call    carry_minus
	call    normal_minus
	
	movlw   11000000B	; set address to the second line
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	call    timer_read     ; get the random number from TIMER and write it to W register
	movwf   PORTC, A	; we can check the radom number on PORTC
	call	mov_index      ; move the random number to the buzzer module for storage
	call    find_prize     ; use the random number to find the prize
	
	call    select_tone	; choose buzzer melody depending on prize won 
	
	call    addition       ; add the prize to the balance
	
	movlw	00110000B
	cpfsgt	digit2, A; see if the second digit is zero
	call	compare	 ; see if the player lose all money
	
	call    delay_250ms
	return 

balance_check:
	movf	PORTE, W
	cpfseq	check, A; to see if the 2nd column of keypad is pressed, if it is then skip next line
	return
	
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	call	start2		; show 'your balance is' on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movlw   11000000B	; set address to the second line
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf	digit1, W, A    
	call	LCD_Send_Byte_D	; display the first digit of balnce on LCD    
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf	digit2, W, A	
	call	LCD_Send_Byte_D ; display the second digit of balnce on LCD    
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf	digit3, W, A	
	call	LCD_Send_Byte_D ; display the third digit of balnce on LCD  
	
	call    delay_1s
	return
	
IR:     
	movf	PORTE, W
	cpfseq	ifIR, A; to see if the 2nd column of keypad is pressed, if it is then skip next line
	return
	
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	call    manualend; show the game over page and the monry the player gains/loses on LCD 
	
	movlw   00110000B
	cpfsgt  digit1, A; if the first digit of balance is greater than 0, go to earnmoney; if not go to losemoney
	call    losemoney
	call    earnmoney
	
	movlw   11000000B	; set address to the second line
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	call    bye;  display 'bye ^-^' on LCD
	
	call    delay_long
	
	goto    setup; reset the game



normal_minus:    ;subtraction routine without carry
    movlw   0x01
    cpfslt  ifcarry, A
    return
    decf    digit2, 1, 0
    return

carry_minus:    ;subtraction routinewith carry bit
    decf    digit1, 1, 0
    movlw   00111001B; 9 in ASCII
    movwf   digit2, A
    movlw   0x01
    movwf   ifcarry, A; the ifcarry is 1
    return

addition:
    call    extract1
    addwf   digit1, 1, 0
    call    extract2
    addwf   digit2, 1, 0
    movlw   00111001B
    cpfsgt  digit2, A
    return
    call    carry_plus
    return

carry_plus:
    movlw   0x01
    addwf   digit1, 1, 0
    movlw   0x0a
    subwf   digit2, 1, 0
    return
	
compare:
	cpfseq	digit1, A; see if the first digit is zero
	return	
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	call	autoend

losemoney:
	movlw   00111010B;   9 in ASCII and then plus 1
	movwf   ten, A
	movf    digit2, W, A
	movff   ten, digit2, A
	subwf   digit2, 1, 0
	movlw   00110000B
	addwf   digit2, 1, 0
	
	movlw	00101101B  ; '-' in ASCII  
	call	LCD_Send_Byte_D ; display minus sign on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf    digit2, W, A
	call	LCD_Send_Byte_D ; display second digit on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf    digit3, W, A
	call	LCD_Send_Byte_D	; display third digit on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	return
	
earnmoney:
	movlw	00110000B
	cpfsgt	digit1, A; if the fisrt digit of balance is greater than 0, skip next line
	return
	
	decf    digit1, 1, 0; decrement first digit
	
	movf    digit1, W, A
	call	LCD_Send_Byte_D  ; display first digit on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf    digit2, W, A
	call	LCD_Send_Byte_D  ; display second digit on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	movf    digit3, W, A
	call	LCD_Send_Byte_D ; display third digit on LCD
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	
	return
	
	
	
delay_2ms:
    movlw   0x02
    call    LCD_delay_ms
    return   
      
delay_5ms:
    movlw   0x05
    call    LCD_delay_ms
    return

delay_10ms:
    movlw   0x0a
    call    LCD_delay_ms
    return

delay_25ms:
    movlw   0x19
    call    LCD_delay_ms
    return


delay_50ms:
    movlw   0x32
    call    LCD_delay_ms
    return


delay_250ms:
    movlw   0xfa
    call    LCD_delay_ms
    return    
    
    
delay_1s:    ;1s of delay
    movlw   0xfa
    call    LCD_delay_ms
    movlw   0xfa
    call    LCD_delay_ms
    movlw   0xfa
    call    LCD_delay_ms
    movlw   0xfa
    call    LCD_delay_ms
    return
	

delay_long:   ;5s of delay
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
	


