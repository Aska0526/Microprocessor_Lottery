    #include <xc.inc>
    
    global   find_prize

extrn    show_nothing, LCD_Send_Byte_D, LCD_delay_ms
    
psect	udata_acs   ; named variables in access ram
ran:     ds 1
	
psect	Pool_code, class=CODE
	
find_prize:
    movwf   ran, A
    movlw   0xa0    ; compare with 160; if less than 160, no prize
    cpfsgt  ran, A
    call    show_nothing
    movlw   0xc8
    cpfsgt  ran, A
    call    prize1
    movlw   0xf0
    cpfsgt  ran,A
    call    prize2
    movlw   0xf5
    cpfsgt  ran,A
    call    prize3
    movlw   0xfa
    cpfsgt  ran,A
    call    prize4
    movlw   0xfd
    cpfsgt  ran, A
    call    prize5
    movlw   0xfe
    cpfsgt  ran, A
    call    prize6
    movlw   0xff
    cpfsgt  ran, A
    call    prize7
    
    goto    $
    ;return  
    
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
    return