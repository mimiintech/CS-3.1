# CS 218 Assignment #11
# Simple make file for asst #11

OBJS	= grep.o a11procs.o
ASM	= yasm -g dwarf2 -f elf64
CC	= g++ -g -std=c++11 

all: grep

grep.o: grep.cpp
	$(CC) -c grep.cpp

a11procs.o: a11procs.asm 
	$(ASM) a11procs.asm -l a11procs.lst

grep: $(OBJS)
	$(CC) -no-pie -o grep $(OBJS)

# -----
# clean by removing object files.

clean:
	rm  $(OBJS)
	rm  a11procs.lst

