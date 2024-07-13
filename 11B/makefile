# CS 218 Assignment #11
# Simple make file for asst #11B

OBJS_SM	= grep.o a11procsSM.o
OBJS_LG	= grep.o a11procsLG.o
ASM	= yasm -g dwarf2 -f elf64
CC	= g++ -g -std=c++11

all:	sed grepLG grepSM

sed:
	@sed -e "s/BUFFSIZE\tequ\t800000/BUFFSIZE\tequ\t2/" \
					a11procs.asm > a11procsSM.asm

grep.o: grep.cpp
	$(CC) -c grep.cpp

a11procsSM.o: a11procsSM.asm
	$(ASM) a11procsSM.asm -l a11procsSM.lst -o a11procsSM.o

a11procsLG.o: a11procs.asm
	$(ASM) a11procs.asm -l a11procs.lst -o a11procsLG.o

grepSM: $(OBJS_SM)
	$(CC) -no-pie -o grepSM $(OBJS_SM)

grepLG: $(OBJS_LG)
	$(CC) -no-pie -o grepLG $(OBJS_LG)

# -----
# clean by removing object files and list files.

clean:
	@rm  -f $(OBJS_LG)
	@rm  -f $(OBJS_SM)
	@rm  -f a11procs.lst
	@rm  -f a11procsSM.lst
