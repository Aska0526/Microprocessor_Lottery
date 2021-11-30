    #include <xc.inc>
    ;#define TMR1_IF PIR1, TMR1IF
    ;#define TMR1_ON T1CON, TMR1ON
    
psect	udata_acs   ; named variables in access ram
pull:		ds 1   ; draw a lottery
temp_1:	ds 1
temp_2:	ds 1
temp_3:	ds 1

extrn   Keypad_read_column
extrn   timer_setup, timer_read
    
psect	code, abs
setup:
	org	0x0
	
	call	timer_setup
	
	movlw   0x0
	movwf   TRISB, A
	
	movlw   00001110B ;give value to pull
	movwf   pull
	
	goto    main
	
main:
	call    Keypad_read_column
	movf	PORTE, W
	cpfseq	pull ;compare if it is the 1st column, if it is then skip next line
	bra     main
	call    timer_read
	movwf   PORTB
	call    delay_1s
	bra     main
	;other condition which I haven't thought of
	;bra	
	
delay_1s:
	banksel	temp_1
	movlw	0xFF
	movwf	temp_1
	movwf	temp_2
	movlw	0x05
	
	movwf	temp_3
	decfsz	temp_1, f
	goto	$-1
	decfsz	temp_2, f
	goto	$-3
	decfsz	temp_3, f
	goto	$-5
	return
	
	end	main
	

	
