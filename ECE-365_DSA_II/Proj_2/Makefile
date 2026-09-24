# Compiler and flags Makefile mostly written by CHATGPT
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17

# Executable name
TARGET = heap.exe
DEBUG_TARGET = heapDebug.exe

# Source and object files
SRCS = useHeap.cpp hash.cpp heap.cpp
OBJS = $(SRCS:.cpp=.o)
HEADERS = hash.h heap.h

# Default rule
all: $(TARGET)

# Link the final executable
$(TARGET): $(OBJS)
	$(CXX) -o $(TARGET) $(OBJS)

# Compile .cpp to .o
%.o: %.cpp $(HEADERS)
	$(CXX) $(CXXFLAGS) -c $<

# Debug build
debug:
	$(CXX) $(CXXFLAGS) -g -o $(DEBUG_TARGET) $(SRCS)

# Clean up generated files
clean:
	rm -f *.exe *.o *.stackdump *~

# Backup source and headers
backup:
	test -d backups || mkdir backups
	cp *.cpp backups
	cp *.h backups
	cp Makefile backups

# Format all source files using clang-format
format:
	clang-format -i *.cpp *.h
