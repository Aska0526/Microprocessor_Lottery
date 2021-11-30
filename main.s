    #include <xc.inc>

extrn   Keypad_read_column
extrn   timer
    
psect	code, abs
	
main:
	org	0x0
	call    Keypad_read_column

	end	main
