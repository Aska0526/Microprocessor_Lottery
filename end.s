 #include <xc.inc>
     
     global  autoend, manualend, bye
 
extrn   LCD_Write_Message, delay_1s, setup, delay_long
    
psect	udata_bank6 ; reserve data anywhere in RAM (here at 0x400)
myArray5:    ds 0x40 ; reserve 128 bytes for message data
myArray6:    ds 0x40 ; reserve 128 bytes for message data
myArray7:    ds 0x40 ; reserve 128 bytes for message data
    
psect	data    
	; ******* myTable, data in programme memory, and its length *****    
myTable5:
	db	'Y','o','u',' ','l','o','s','t',' ','>','_','<',0x0a
					; message, plus carriage return
	myTable_5   EQU	13	; length of data
	align	2
myTable6:
	db	'Y','o','u',' ','e','a','r','n',':',' ',0x0b
					; message, plus carriage return
	myTable_6   EQU	11	; length of data
	align	2 
myTable7:
	db	'B','y','e','!',' ',':',')',0x0c
					; message, plus carriage return
	myTable_7   EQU	8	; length of data
	align	2

psect	udata_acs   ; named variables in access ram
counter5:    ds 1    ; reserve one byte for a counter variable
counter6:    ds 1    ; reserve one byte for a counter variable
counter7:    ds 1    ; reserve one byte for a counter variable

	
psect	end_code,class=CODE

autoend:
	lfsr	0, myArray5	; Load FSR0 with address in RAM	
	movlw	low highword(myTable5)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable5)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable5)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_5	; bytes to read
	movwf 	counter5, A		; our counter register
	
loop5:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter5, A		; count down to zero
	bra	loop5		; keep going until finished
		
	movlw	myTable_5	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray5
	call	LCD_Write_Message
	
	;goto	$		; goto current line in code
	call	delay_long
	goto    setup
	;return
	
manualend:
	lfsr	0, myArray6	; Load FSR0 with address in RAM	
	movlw	low highword(myTable6)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable6)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable6)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_6	; bytes to read
	movwf 	counter6, A		; our counter register
	
loop6:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter6, A		; count down to zero
	bra	loop6		; keep going until finished
		
	movlw	myTable_6	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray6
	call	LCD_Write_Message
	
	return

bye:
	lfsr	0, myArray7	; Load FSR0 with address in RAM	
	movlw	low highword(myTable7)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable7)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable7)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_7	; bytes to read
	movwf 	counter7, A		; our counter register
	
loop7:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter7, A		; count down to zero
	bra	loop7		; keep going until finished
		
	movlw	myTable_7	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray7
	call	LCD_Write_Message
	
	return

