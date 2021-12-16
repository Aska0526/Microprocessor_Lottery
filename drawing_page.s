#include <xc.inc>

    global  start1
 
extrn   LCD_Write_Message    
    
psect	udata_bank4 ; reserve data anywhere in RAM (here at 0x400)
myArray1:    ds 0x40 ; reserve 128 bytes for message data
    
psect	data    
	; ******* myTable, data in programme memory, and its length *****    
myTable1:
	db	'Y','o','u',' ','w','i','n',':',0x0a
					; message, plus carriage return
	myTable_l   EQU	9	; length of data
	align	2        

psect	udata_acs   ; named variables in access ram
counter1:    ds 1    ; reserve one byte for a counter variable

    
    
psect	drawing_code,class=CODE
    
start1: 
	lfsr	0, myArray1	; Load FSR0 with address in RAM	
	movlw	low highword(myTable1)	; address of data in PM
	movwf	TBLPTRU, A		; load upper bits to TBLPTRU
	movlw	high(myTable1)	; address of data in PM
	movwf	TBLPTRH, A		; load high byte to TBLPTRH
	movlw	low(myTable1)	; address of data in PM
	movwf	TBLPTRL, A		; load low byte to TBLPTRL
	movlw	myTable_l	; bytes to read
	movwf 	counter1, A		; our counter register

loop1:  tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	decfsz	counter1, A		; count down to zero
	bra	loop1		; keep going until finished
		
	movlw	myTable_l	; output message to LCD
	addlw	0xff		; don't send the final carriage return to LCD
	lfsr	2, myArray1
	call	LCD_Write_Message
	
	return


