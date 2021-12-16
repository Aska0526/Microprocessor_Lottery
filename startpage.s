    #include <xc.inc>
     
     global  welcome
 
extrn   LCD_Write_Message    
    
psect	udata_bank4 ; reserve data anywhere in RAM (here at 0x400)
myArray4:    ds 0x40 ; reserve 128 bytes for message data
    
psect	data    
	; ******* myTable, data in programme memory, and its length *****    
myTable4:
	db	'W','e','l','c','o','m','e','!',' ','^','_','^',0x0d
					; message, plus carriage return
	myTable_4   EQU	13	; length of data
	align	2        

psect	udata_acs   ; named variables in access ram
counter4:    ds 1    ; reserve one byte for a counter variable

	
psect	welcome_code,class=CODE

welcome:
	lfsr	0, myArray4	; Load FSR0 with address in RAM	
	movlw	low highword(myTable4)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable4)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable4)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_4	; bytes to read
	movwf 	counter4, A		; our counter register
	
loop4:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter4, A		; count down to zero
	bra	loop4		; keep going until finished
		
	movlw	myTable_4	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray4
	call	LCD_Write_Message
	
	return
    





