merge.exe: merge.o
	g++ merge.o -o merge.exe

debug:
	g++ -g -o merge.exe 

clean:
	rm -f *.exe *.o *.stackdump *~

backup:
	test -d backups || mkdir backups
	cp *.cpp backups
	cp *.h backups
	cp Makefile backups

format:
	clang-format -i *.cpp *.h
