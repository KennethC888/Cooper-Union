# this will compile all files everytime make is run
# Definitions for constants
CC=gcc
CFLAGS=-I.
# This will create your final output using .o compiled files

make: main.o lore.o Pet_Struct.o 
	$(CC) $(CFLAGS) -o main.out main.o lore.o Pet_Struct.o
# This will compile atof.c
lore.o: lore.c
	$(CC) $(CFLAGS) -c lore.c
#This will compile Pet_struct.c
Pet_Struct.o: Pet_Struct.c 
	$(CC) $(CFLAGS) -c Pet_Struct.c
# This will compile main.c with its dependency
main.o: main.c lore.h
	$(CC) $(CFLAGS) -c main.c
#This will clean or remove compiled files so you can start fresh
clean:
	rm -f *.o *.exe
