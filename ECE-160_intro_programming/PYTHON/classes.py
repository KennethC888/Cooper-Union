def printStuff():
    print("HI I JUST USED A FUNCTION!")

printStuff()


def pow(x,y):
    result = 1
    for i in range (y):
        result *= x

    return result

print(pow(2,3))

# Note that i will start at 0 and will go to less than y, so it goes from 0 to 2. 


def areaOfCircle(radius):
    PI =3.14159265
    return PI * pow(radius,2)
print(areaOfCircle(7))


class Critter():
    def __init__(self, name, species, hunger = 0, boredom = 0): # self must be the firt argument in a definition)
        self.name = name
        self.species = species
        self.hunger = hunger 
        self.boredom = boredom


    def __pass_time(self):
        self.hunger +=10
        self.boredom += 10
        

    def checkLife(self):
        if(self.hunger + self.boredom > 150):
            print("DEAD")
            return 0
        else:
            return 1


    def feed(self, food):
        if (food == "Pizza"):
            self.hunger -=100
        elif(food == "Cheese"):
            self.hunger -=50
        elif(food == "Plutonium"):
            self.hunger += 1000
        self.__pass_time() 


    def play(self, activity):
        if(activity == "Walk"):
            self.boredom -=30
        elif(activity == "Fetch"):
            self.boredom -=50
        elif(activity == "cuddle"):
            self.boredom -= 20
        else:
            self.boredom += 10
        self.__pass_time()

bob = Critter("Bob", "rat", boredom = 100) # default hunger and boredom to 0
print(bob.name)
print(bob.hunger)
print(bob.boredom)
bob.play("Walk")
bob.feed("Pizza")
print(bob.checkLife())


class IceCream():
    def __init__(self, flavor, size, container, cost, toppings):
        self.flavor = flavor
        self.size = size
        self.container = container
        self.cost = cost
        self.toppings = []

    def addTopping(self, topping):
        self.toppings.append(topping)
        if len(self.toppings) >3:
            self.cost += 1

print("Welcome to 15 Handles!")

flavor = input("Choose your flavor")
size = input("Choose your size")
container = input("Choose your container")
cost = 10
icecream = IceCream(flavor, size, container, cost)


choice = None;
while(choice != "0"): 
    choice = input("Choose a topping. Enter 0 to end")
    if choice != "0":
        icecream.addTopping(topping)

print("Final Cost: ", icecream.cost)

#ON QUIZ 6





