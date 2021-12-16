#include <xc.inc>

    global  start2
 
extrn   LCD_Write_Message    
    
psect	udata_bank4 ; reserve data anywhere in RAM (here at 0x400)
myArray2:    ds 0x40 ; reserve 128 bytes for message data
    
psect	data    
	; ******* myTable, data in programme memory, and its length *****    
myTable2:
	db	'Y','o','u','r',' ','B','a','l','a','n','c','e',' ','i','s',':',0x0b
					; message, plus carriage return
	myTable_2   EQU	17	; length of data
	align	2        

psect	udata_acs   ; named variables in access ram
counter2:    ds 1    ; reserve one byte for a counter variable

    
    
psect	drawing_code,class=CODE
    
start2: 
	lfsr	0, myArray2	; Load FSR0 with address in RAM	
	movlw	low highword(myTable2)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable2)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable2)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_2	; bytes to read
	movwf 	counter2, A		; our counter register

loop2:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter2, A		; count down to zero
	bra	loop2		; keep going until finished
		
	movlw	myTable_2	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray2
	call	LCD_Write_Message
	
	return


