#include<xc.inc>

global  mov_index,select_tone
    
extrn   delay_1s, delay_250ms, delay_50ms, delay_25ms, delay_10ms, delay_5ms, delay_2ms

    
    
psect	udata_acs   ; named variables in access ram   
index:    ds 1 ; local index variable that represents the random number of the price    
tone:     ds 1 ;store PR2 value for the correct tone  
    
psect	buzzer_code,class=CODE    


    
mov_index:
    movwf   index, A
    return
      
    
select_tone:
    movlw   0xa0    ; compare with 160; if less than 160, c4 correspond to no price
    cpfsgt  index, A
    call    send_c4
    movlw   0xc8    ; 10 bucks correspond to D4
    cpfsgt  index, A
    call    send_d4
    movlw   0xf0   ;20 bucks correspond to e4
    cpfsgt  index, A
    call    send_e4
    movlw   0xf5   ;30 bucks correspond to f4
    cpfsgt  index, A
    call    send_f4
    movlw   0xfa   ;40 bucks correspond to g4
    cpfsgt  index, A
    call    send_g4
    movlw   0xfd   ;50 bucks correspond to a4
    cpfsgt  index, A
    call    send_a4
    movlw   0xfe   ;60 bucks correspond to b4
    cpfsgt  index, A
    call    send_b4
    call    grand_prize
    return
    
    
send_c4:   ;win nothing
    
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0xee
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_10ms
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return
    
send_d4:  ;win10
    movlw   0xa0
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0xee
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_10ms
    movlw   0x7e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return
    
send_e4:
    movlw   0xc8
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0xb2
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_2ms
    movlw   0x9e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_2ms
    movlw   0x8d
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return
    
send_f4:
    movlw   0xf0
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0xb2
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_2ms
    movlw   0x9e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_2ms
    movlw   0x8d
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_2ms
    movlw   0x7e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return

send_g4:
    movlw   0xf5
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0x9e
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0x8d
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0x9e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0x8d
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0x9e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return
    
send_a4:
    movlw   0xfa
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0xee
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0xd4
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0xbc
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0xee
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0x9e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return
    
send_b4:
    movlw   0xfd
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0x9e
    movwf   PR2, A
    
    movlw   00010101 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_5ms
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_2ms
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    movlw   0x7e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_25ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return
    
grand_prize:
    movlw   0xfe
    cpfsgt  index, A
    return
    
    movlw   0xfd
    cpfsgt  index, A
    return
    movlw   01011111B  ;set internal oscillator
    movwf   OSCCON, A
    
    movlw   0xee
    movwf   PR2, A
    
    movlw   00111111 ;write duty cycle
    movwf   CCPR4L
    
    movlw   00111100B  ;single output controlled by steering
    movwf   CCP4CON
    
    movlw   0x00
    movwf   TRISG, A
    
    movlw   00000111B
    movwf   T2CON     ;set timer2 so that it has a prescale value of 16

    movlw   00000000B
    movwf   CCPTMRS1, A
    
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_10ms
    movlw   0xb2
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_5ms
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_5ms
    call   delay_10ms
    
    movlw   0xee
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_10ms
    
    movlw   0x9e
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_10ms
    bcf     T2CON, 2
    call    delay_5ms
    
    movlw   0xbc
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_5ms
    bcf     T2CON, 2
    call    delay_5ms
    
    movlw   0xb2
    movwf   PR2, A
    bsf     T2CON, 2
    call    delay_25ms
    bcf     T2CON, 2
    call    delay_25ms
    
    clrf    OSCCON
    return