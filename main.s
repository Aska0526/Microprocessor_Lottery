    #include <xc.inc>

psect	udata_bank4 ; reserve data anywhere in RAM (here at 0x400)
myArray:    ds 0x80 ; reserve 128 bytes for message data
    
psect	data    
	; ******* myTable, data in programme memory, and its length *****    
myTable:
	db	'Y','o','u',' ','w','i','n',':',0x0a
					; message, plus carriage return
	myTable_l   EQU	9	; length of data
	align	2    
    
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

extrn   Keypad_read_column
extrn   timer_setup, timer_read
extrn   LCD_Setup, LCD_Write_Message, LCD_Send_Byte_I, LCD_delay_x4us, LCD_delay_ms
    
psect	code, abs
setup:
	org	0x0
	
	bcf	CFGS	; point to Flash program memory  
	bsf	EEPGD 	; access Flash program memory
	call	LCD_Setup	; setup LCD
	call	timer_setup
	
	movlw	0xFF
	movwf	temp_1, A
	movwf	temp_2, A
	movwf	temp_3, A
	movlw	0x05
	movwf   temp_4, A 
	
	movlw   0x0
	movwf   TRISC, A
	movwf   TRISD, A
	
	movlw   00001110B ;give value to pull
	movwf   pull
	movlw   00001101B ;give value to check
	movwf   check
	movlw   00001011B ;give value to ifIR
	movwf   ifIR
	
	goto    main

start: 	lfsr	0, myArray	; Load FSR0 with address in RAM	
	movlw	low highword(myTable)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_l	; bytes to read
	movwf 	counter, A		; our counter register

loop: 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter, A		; count down to zero
	bra	loop		; keep going until finished
		
	movlw	myTable_l	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray
	call	LCD_Write_Message
	
	;goto	$		; goto current line in code
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
	call    timer_read
	movwf   PORTC
	movlw	00000001B	; display clear
	call	LCD_Send_Byte_I
	movlw	2		; wait 2ms
	call	LCD_delay_ms
	call    start
	call    delay_1s
	return

balance_check:
	movf	PORTE, W
	cpfseq	check, A
	return
	movlw   0xff
	movwf   PORTD
	return
	
IR:
	movf	PORTE, W
	cpfseq	ifIR, A
	return
	movlw   0x01
	movwf   PORTD
	return
	
	end	main
	

	
