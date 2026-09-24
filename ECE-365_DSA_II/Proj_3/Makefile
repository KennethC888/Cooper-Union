main_dij.exe: main_dij.o heap.o hash.o graph.o
	g++ -o main_dij.exe main_dij.o heap.o hash.o graph.o

main_dij.o: main_dij.cpp heap.h hash.h graph.h
	g++ -c main_dij.cpp

heap.o: heap.cpp heap.h
	g++ -c heap.cpp

hash.o: hash.cpp hash.h
	g++ -c hash.cpp

graph.o: graph.cpp graph.h heap.h hash.h
	g++ -c graph.cpp

debug:
	g++ -g -o dijkstraDebug.exe main_dij.cpp heap.cpp hash.cpp graph.cpp

clean:
	rm -f *.exe *.o *.stackdump *~

backup:
	test -d backups || mkdir backups
	cp *.cpp backups
	cp *.h backups
	cp Makefile backups

format:
	clang-format -i *.cpp *.h
