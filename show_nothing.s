    #include <xc.inc>
     
     global  show_nothing
 
extrn   LCD_Write_Message    
    
psect	udata_bank4 ; reserve data anywhere in RAM (here at 0x400)
myArray3:    ds 0x40 ; reserve 128 bytes for message data
    
psect	data    
	; ******* myTable, data in programme memory, and its length *****    
myTable3:
	db	'N','o','t','h','i','n','g',' ','T','o','T',0x0c
					; message, plus carriage return
	myTable_3   EQU	12	; length of data
	align	2        

psect	udata_acs   ; named variables in access ram
counter3:    ds 1    ; reserve one byte for a counter variable

	
psect	show_nothing_code,class=CODE

show_nothing:
	lfsr	0, myArray3	; Load FSR0 with address in RAM	
	movlw	low highword(myTable3)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable3)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable3)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_3	; bytes to read
	movwf 	counter3, A		; our counter register
	
loop3:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter3, A		; count down to zero
	bra	loop3		; keep going until finished
		
	movlw	myTable_3	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray3
	call	LCD_Write_Message
	

	return
    


