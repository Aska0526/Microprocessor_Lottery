    #include <xc.inc>
    
    global   find_prize, extract1, extract2, extract3

extrn    show_nothing, LCD_Send_Byte_D, LCD_delay_ms
    
psect	udata_acs   ; named variables in access ram
ran:     ds 1
pd1:     ds 1       ; first digit (from left to right) of the prize 
pd2:     ds 1
pd3:     ds 1
	
psect	Pool_code, class=CODE
	
find_prize:
    movwf   ran, A
    
    movlw   0x00 ;default value is 0
    movwf   pd1, A
    movwf   pd2, A
    movwf   pd3, A
    
    movlw   0xa0    ; compare with 160; if no greater than 160, no prize
    cpfsgt  ran, A
    call    show_nothing
    movlw   0xc8 ; compare with 200; if no greater than 200, win 10 bucks
    cpfsgt  ran, A
    call    prize1
    movlw   0xf0; compare with 240; if no greater than 240, win 20 bucks
    cpfsgt  ran,A
    call    prize2
    movlw   0xf5   ; compare with 245; if no greater than 245, win 30 bucks
    cpfsgt  ran,A
    call    prize3
    movlw   0xfa ; compare with 250; if no greater than 250, win 40 bucks
    cpfsgt  ran,A
    call    prize4
    movlw   0xfd ; compare with 253; if no greater than 253, win 50 bucks
    
    cpfsgt  ran, A
    call    prize5
    movlw   0xfe; compare with 254; if no greater than 254, win 60 bucks
    cpfsgt  ran, A
    call    prize6
    movlw   0xff; compare with 255; if no greater than 255, win 100 bucks
    cpfsgt  ran, A
    call    prize7
    
    return  
    
prize1:; win 10
    movlw   0xa0
    cpfsgt  ran, A
    return
    movlw   00110001B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    
    movlw   0x01      ; second digit to 1
    movwf   pd2, A
    
    return
    
prize2:; win 20
    movlw   0xc8
    cpfsgt  ran, A
    return
    movlw   00110010B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   0x02     ; second digit to 2
    movwf   pd2, A
    return
    

prize3:; win 30
    movlw   0xf0
    cpfsgt  ran, A
    return
    movlw   00110011B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   0x03      ; second digit to 3
    movwf   pd2, A
    return

prize4:; win 40
    movlw   0xf5
    cpfsgt  ran, A
    return
    movlw   00110100B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   0x04      ; second digit to 4
    movwf   pd2, A
    return
    
prize5:; win 50
    movlw   0xfa
    cpfsgt  ran, A
    return
    movlw   00110101B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   0x05      ; second digit to 5
    movwf   pd2, A
    return
    
prize6:; win 60
    movlw   0xfd
    cpfsgt  ran, A
    return
    movlw   00110110B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   0x06      ; second digit to 6
    movwf   pd2, A
    return
    
prize7:; win 100
    movlw   0xfe
    cpfsgt  ran, A
    return
    movlw   00110001B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   00110000B
    call    LCD_Send_Byte_D
    movlw   2		; wait 2ms
    call    LCD_delay_ms
    movlw   0x01      ; third digit to 1
    movwf   pd1, A
    return
    
extract1:        ; put the first digit of the price to the w register
    movf    pd1, W, A
    return
extract2:   ; put the second digit of the price to the w register
    movf    pd2, W, A
    return
extract3:   ; put the third digit of the price to the w register
    movf    pd3, W, A
    return