# Definitions for constants
CC=gcc
CFLAGS=-I.

# This will create your final output using .o compiled files
make: main.o board.o play_game.o player.o player_vs_comp.o
	$(CC) $(CFLAGS) -o main.out main.o board.o play_game.o player.o player_vs_comp.o

# This will compile board.c
board.o: board.c board.h globals.h
	$(CC) $(CFLAGS) -c board.c

# This will compile play_game.c
play_game.o: play_game.c play_game.h board.h player.h globals.h
	$(CC) $(CFLAGS) -c play_game.c

# This will compile player.c
player.o: player.c player.h play_game.h board.h globals.h
	$(CC) $(CFLAGS) -c player.c

# This will compile player_vs_comp.c
player_vs_comp.o: player_vs_comp.c player_vs_comp.h board.h play_game.h globals.h
	$(CC) $(CFLAGS) -c player_vs_comp.c

# This will compile main.c with its dependency
main.o: main.c board.h globals.h play_game.h player.h player_vs_comp.h
	$(CC) $(CFLAGS) -c main.c

# This will clean or remove compiled files so you can start fresh
clean:
	rm -f *.o *.out
