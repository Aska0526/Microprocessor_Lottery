# Microprocessors
Repository for Physics Year 3 microprocessors lab project fro Chao Fan and Kaiyu Hu.


The project aims to build a lottery machine that is interactive through a keypad. Press '1', make a pull and spend 10 bucks. Press '2', display your current balance on screen. Press '3', exit the game and restart the game with your initial balance.


Specific Modules in the project:


1. random: uses timer0 to generate a random number by looping through the timer at 64MHz and read the value in the TMR0L register when pressing button 1.


2. pool: reads the random value produced from the random module, match it with different level of prices and feed to the LCD module. 


3. buzzer: reads the random value produced from the random module, match it with different sound effects and feed to buzzer. Sound signal generated using Timer2 and PWM module.


4. LCD: reads the content and send to LCD to display the result.


5. drawing_page: feed 'You win:' (the upper half of thye result page) to the LCD module when pressing button 1.


6. balance_check_page: feed 'Your balance is:' (the upper half of thye balance page) to the LCD module when pressing button 1.


7. end: end the game when balance drops to 0, or when user exit manually by pressing button 3. Restart the game in 5 seconds. 


8. keypad: determine which key has been pressed and make consequential actions.


9. show_nothing: display 'Nothing' when user has not won anything after pulling.


10. startpage: display 'welcome' when game starts.
