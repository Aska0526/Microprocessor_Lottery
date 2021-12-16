# Microprocessors
Repository for Physics Year 3 microprocessors lab project fro Chao Fan and Kaiyu Hu.


The project aims to build a lottery machine that is interactive through a keypad. Press '1', make a pull and spend 10 bucks. Press '2', display your current balance on screen. Press '3', exit the game and restart the game with your initial balance.


Specific Modules in the project:


1. random: uses timer0 to generate a random number by looping through the timer at 64MHz and read the value in the TMR0L register when pressing button 1.


2. pool: reads the random value produced from the random module, match it with different level of prices and feed back to the main program. 


3. buzzer: reads the random value produced from the random module, match it with different sound effects and feed to buzzer. Sound signal generated using Timer2 and PWM module.
