# CS 218 Assignment #12
# Simple make file for asst #12

OBJS	= duckNums.o a12procs.o
ASM	= yasm -g dwarf2 -f elf64
CC	= gcc -g -std=c++11
LD	= gcc -g -pthread

all: duckNums

duckNums.o: duckNums.cpp
	$(CC) -c duckNums.cpp

a12procs.o: a12procs.asm
	$(ASM) a12procs.asm -l a12procs.lst

duckNums: duckNums.o a12procs.o
	$(LD) -no-pie -o duckNums $(OBJS) -lstdc++

# -----
# clean by removing object file.

clean:
	@rm	-f $(OBJS)
	@rm	-f a12procs.lst

