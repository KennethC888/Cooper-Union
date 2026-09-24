import random

WHEEL = (500, 550, 600, 650, 700, 750, 800,"BANKRUPT", 850, 900, 950, 1000, 1500, 2000, 4000, 5000, "LOSE A TURN")
VOWEL = ("A", "E", "I", "O", "U")
#possible wheel values

phrase = input("Welcome to Wheel of Fortune.\nEnter your puzzle:")
phrase = phrase.upper()
while len(phrase) < 5:
    phrase = input("The phrase must be at least 5 characters long.\nEnter your puzzle:")
    phrase = phrase.upper()
so_far = ""
used = []                     # letters already guessed
player_1 = 0                    # player scores
player_2 = 0
player_3 = 0

turn = 1
end = 0


for i in range(len(phrase)): #init so_far
    if phrase[i] != " ":
        so_far += "-"
    else:
        so_far += " "

def round():
    #had to make so_far global but idk why that doesnt apply to phrase too
    global so_far
    global turn
    global player_1
    global player_2
    global player_3

    letter_ct = 0    #num correct letters

    #print wheel and "spin" for a random value
    print("\n\nIt's time to spin the wheel")
    for i in range(len(WHEEL)):
        print(WHEEL[i], end=" | ")
    print("\n")
    amount = random.choice(WHEEL)
    print("The wheel landed on", amount, "\n")
    if amount == "BANKRUPT":
        print("You lose all of your money!")
        if turn % 3 == 1:
            player_1 = 0
        elif turn % 3 == 2:
            player_2 = 0
        else:
            player_3 = 0
        turn += 1
        return turn
    elif amount == "LOSE A TURN":
        print("You lose a turn! The next player will go now.")
        turn += 1
        return turn

    guess = input("Please guess a consonant:")
    guess = guess.upper()
    
    #check if used
    while guess in used:
        print("You've already guessed the letter", guess)
        guess = input("Enter your guess: ")
        guess = guess.upper()
    
    #check if only one letter
    while len(guess) > 1:
        print("\nThats not just a letter!")
        guess = input("Enter your guess: ")
        guess = guess.upper()
    
    #check if vowel
    while guess in VOWEL:
        print("\nYou can't choose a vowel here!\nChoose to pay for a vowel next time.\nPlease select a consonant")
        guess = input("Enter your guess: ")
        guess = guess.upper()
    
    used.append(guess)
    
    if guess in phrase:
        print(guess, "is in the phrase.")

        # create a new so_far to include guess
        new = ""
        for i in range(len(phrase)):
            if guess == phrase[i]:
                new += guess
                letter_ct += 1
            else:
                new += so_far[i]              
        so_far = new

        # i tried to have this as a generic param of player to pass into fn but it didnt work without being global?
        if turn % 3 == 1:
            player_1 = player_1 + (amount * letter_ct)
            print("There were", letter_ct,"of", guess,", so Player 1 gains", (amount * letter_ct), "dollars!")
        elif turn % 3 == 2:
            player_2 = player_2 + (amount * letter_ct)
            print("There were", letter_ct,"of", guess,", so Player 2 gains", (amount * letter_ct), "dollars!")
        else:
            player_3 = player_3 + (amount * letter_ct)
            print("There were", letter_ct,"of", guess,", so Player 3 gains", (amount * letter_ct), "dollars!")
    else:
        print("\nSorry,", guess, "isn't in the phrase. The next player will go now.")
    turn += 1
    
def printScores():
    print("\nScoreboard:")
    print("Player 1: $", player_1)
    print("Player 2: $", player_2)
    print("Player 3: $", player_3)

def move():
    #determine what move the player will make
    ans = input("Do you wish to finish solving the puzzle now, spin the wheel to guess a consonant, or buy a vowel?\nF for solving now, W for wheel, V for vowel")
    ans = ans.upper()
    while ans != "F" and ans != "W" and ans != "V":
        print("That is not a valid response.")
        ans = input("Please select F to solve now, or W to continue to the wheel.")
        ans = ans.upper()
    if ans == "F":
        return 0
    elif ans == "W":
        return 1
    elif ans == "V":
        return 2

def solve():
    global turn
    global so_far
    global end
    print("\nYou will now attempt to solve the puzzle.")
    guess = input("What is the whole phrase?")
    guess = guess.upper()
    if guess == phrase:
        #fills in rest of phrase and leaves game loop
        so_far = guess
        print("\nThat is correct!")

        #end game upon solving. player who solved will win. maybe not how the game is intended to go? 
        end = 1
    else:
        print("\nThat is incorrect. The next player will go now.")
        turn += 1

def vowel():
    global so_far
    global turn       
    global player_1
    global player_2
    global player_3
    print("\nYou will now buy a vowel for $250.")
    guess = input("What is your vowel?")
    guess = guess.upper()

    #check if vowel
    while guess not in VOWEL:
        print("\nThat is not a vowel.")
        guess = input("What is your vowel?")
        guess = guess.upper()

    #check if used
    while guess in used:
        print("\nYou've already guessed the vowel", guess)
        guess = input("Enter your vowel: ")
        guess = guess.upper()

    used.append(guess)
            
    if guess in phrase:
        print(guess, "is in the phrase.")

        # create a new so_far to include guess
        new = ""
        for i in range(len(phrase)):
            if guess == phrase[i]:
                new += guess
            else:
                new += so_far[i]              
        so_far = new

        #deduct player money
        if turn % 3 == 1:
            player_1 = player_1 - 250
        elif turn % 3 == 2:
            player_2 = player_2 - 250
        else:
            player_3 = player_3 - 250
    else:
        print("\nSorry,", guess, "isn't in the phrase. The next player will go now.")
    turn += 1
           
    

while so_far != phrase:
    print("\nThe used letters are:\n", used)
    print("\nSo far, the phrase is:\n", so_far)

    #little break to make it more readable
    input("Press enter to continue\n")

    if turn % 3 == 1:
        print("Player 1, it's your turn")
        #this is a tad repetitive and would do better to be a fn
        choice = move()
        if choice == 1:
            round()
        elif choice == 0:
            solve()
        elif choice == 2:
            if player_1 < 250:
                print("\n You dont have the money for that! Proceed to the wheel.")
                round()
            else:
                vowel()
        printScores()
        
    elif turn % 3 == 2:
        print("Player 2, its your turn")
        choice = move()
        if choice == 1:
            round()
        elif choice == 0:
            solve()
        elif choice == 2:
            if player_2 < 250:
                print("\n You dont have the money for that! Proceed to the wheel.")
                round()
            else:
                vowel()
        printScores()
    else:
        print("Player 3, its your turn")
        choice = move()
        if choice == 1:
            round()
        elif choice == 0:
            solve()
        elif choice == 2:
            if player_3 < 250:
                print("\n You dont have the money for that! Proceed to the wheel.")
                round()
            else:
                vowel()
        printScores()

print("The phrase was:", phrase)


if end == 0:
    if player_1 > player_2 and player_1 > player_3:
        print("Congratulations Player 1 for winning with", player_1, "dollars!")
    elif player_2 > player_1 and player_2 > player_3:
        print("Congratulations Player 2 for winning with", player_2, "dollars!")
    elif player_3 > player_1 and player_3 > player_2:
        print("Congratulations Player 3 for winning with", player_3, "dollars!")
    else:
        print("There has been a draw!")
else:
    if turn % 3 == 1:
        print("Congratulations Player 1 for winning with", player_1, "dollars!")
    elif turn % 3 == 2:
        print("Congratulations Player 2 for winning with", player_2, "dollars!")
    else:
        print("Congratulations Player 3 for winning with", player_3, "dollars!")


