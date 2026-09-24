age = 18
bac = 0


if age< 21 and bac > 0:
    print("You're illegal!") #MUST INDENT, no curly braces
    print("You're illegal x2")

elif age >21 and bac>0 and bac <0.04:
    print("You're drunk")

elif age >21 and bac >=0.04 and bac <=0.08:
    print("You're intoxicated!")

else:
    print("YOU DEAD MAN")

print("THE END")
