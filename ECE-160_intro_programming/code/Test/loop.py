# Three Year-Old Simulator

print("\t Welcome to the 'Three-Year-Old Simulator'\n")
print("This program simulates a conversation with a three-year-old child.")
print("Try to stop the madness.\n")

response = ""
while response != "Because.":
    response = input("Why?\n")

print("Oh. Okay.")

input("\n\n Press the enter key to exit.")




print("Counting!")

for i in range(10):
    print(i, end=" ") # end makes print not end in a \n

print("\n\nCounting by fives:")
for i in range(0, 50, 5):
    print(i, end=" ")

print("\n\nCounting backwards:")
for i in range(10, 0, -1):
    print(i, end=" ")


word = "Python is awesome!"

print(word[0:6]) # excludes last

print(word[-5]) # The 5th letter from the right is printed

for i in word:
    print(i, end=" ")


print(len(word)) #Prints length of word

print(type(word)) #Prints the variable type of the word


