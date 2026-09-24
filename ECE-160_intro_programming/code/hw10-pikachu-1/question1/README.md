## Question 1

Write the game "Wheel of Fortune" in Python. For those of you who are not familiar with the game show, you can read more about it on wikipedia.

Below are the requirements:
- Allow a user to enter their own puzzle
- Have a used letter board
- Have a wheel that provides a random dollar amount from $500 to $5000.
- Allow 3 players to play and take turns
- Keep track of the 3 players' scores
- Player 1 will start the game. He/she will spin the wheel.
- Player 1 will call a letter and if there is a letter, fill in the blanks, add the letter in the used letter board, and give player 1 the money they landed on times the number of letters in the game. If the letter is not in puzzle, the next player will play.
- For simplicity, all letters can earn money (unlike in the real show, where a vowel costs $250).

Bonus:
- (+10) Write an AI (computer player) that plays relatively intelligently.
- (+10) Include a bankrupt space and a lose a turn space on the wheel.
- (+10) Allow a user to solve the puzzle at any time.
- (+10) Allow a user to buy a vowel for $250 and restrict a user from calling a vowel if he/she decided to spin the wheel.

This question is out of 100 points and will be graded on code quality and code output.

Execution Steps:
``` 
python3 q1.py
```
Output:
```
Welcome to Wheel of Fortune.
Enter your puzzle:Track Star

The used letters are:
 []

So far, the phrase is:
 ----- ----
Press enter to continue

Player 1, it's your turn
Do you wish to finish solving the puzzle now, spin the wheel to guess a consonant, or buy a vowel?
F for solving now, W for wheel, V for vowelw


It's time to spin the wheel
500 | 550 | 600 | 650 | 700 | 750 | 800 | BANKRUPT | 850 | 900 | 950 | 1000 | 1500 | 2000 | 4000 | 5000 | LOSE A TURN |

The wheel landed on 4000

Please guess a consonant:t
T is in the phrase.
There were 2 of T , so Player 1 gains 8000 dollars!

Scoreboard:
Player 1: $ 8000
Player 2: $ 0
Player 3: $ 0

The used letters are:
 ['T']

So far, the phrase is:
 T---- -T--
Press enter to continue

Player 2, its your turn
Do you wish to finish solving the puzzle now, spin the wheel to guess a consonant, or buy a vowel?
F for solving now, W for wheel, V for vowelw


It's time to spin the wheel
500 | 550 | 600 | 650 | 700 | 750 | 800 | BANKRUPT | 850 | 900 | 950 | 1000 | 1500 | 2000 | 4000 | 5000 | LOSE A TURN |

The wheel landed on 800

Please guess a consonant:s
S is in the phrase.
There were 1 of S , so Player 2 gains 800 dollars!

Scoreboard:
Player 1: $ 8000
Player 2: $ 800
Player 3: $ 0

The used letters are:
 ['T', 'S']

So far, the phrase is:
 T---- ST--
Press enter to continue

Player 3, its your turn
Do you wish to finish solving the puzzle now, spin the wheel to guess a consonant, or buy a vowel?
F for solving now, W for wheel, V for vowelw


It's time to spin the wheel
500 | 550 | 600 | 650 | 700 | 750 | 800 | BANKRUPT | 850 | 900 | 950 | 1000 | 1500 | 2000 | 4000 | 5000 | LOSE A TURN |

The wheel landed on 500

Please guess a consonant:k
K is in the phrase.
There were 1 of K , so Player 3 gains 500 dollars!

Scoreboard:
Player 1: $ 8000
Player 2: $ 800
Player 3: $ 500

The used letters are:
 ['T', 'S', 'K']

So far, the phrase is:
 T---K ST--
Press enter to continue

Player 1, it's your turn
Do you wish to finish solving the puzzle now, spin the wheel to guess a consonant, or buy a vowel?
F for solving now, W for wheel, V for vowelf

You will now attempt to solve the puzzle.
What is the whole phrase?track star

That is correct!

Scoreboard:
Player 1: $ 8000
Player 2: $ 800
Player 3: $ 500
The phrase was: TRACK STAR
Congratulations Player 1 for winning with 8000 dollars!
```
