###########################################################################
#  Name: Michelle Silva
#  NSHE ID: 5006988436
#  Section: 1001 & 1002 
#  Assignment: MIPS #2
#  Description: Become familiar with RISC Architecture concepts, the MIPS Architecture, and QtSpim
# (the MIPS simulator)

###########################################################
#  data segment

.data

aSides:	.word	  233,   214,   273,   231,   255
	.word	  264,   273,   274,   223,   256
	.word	  244,   252,   231,   242,   256
	.word	  255,   224,   236,   275,   246
	.word	  253,   223,   253,   267,   235
	.word	  254,   229,   264,   267,   234
	.word	  256,   253,   264,   253,   265
	.word	  226,   252,   257,   267,   234
	.word	  217,   254,   217,   225,   253
	.word	  223,   273,   235,   261,   259
	.word	  225,   224,   263,   247,   223
	.word	  234,   234,   256,   264,   242
	.word	  236,   252,   232,   231,   246
	.word	  250,   254,   278,   288,   292
	.word	  282,   295,   247,   252,   257
	.word	  257,   267,   279,   288,   294
	.word	  234,   252,   274,   286,   297
	.word	  244,   276,   242,   236,   253
	.word	  232,   251,   236,   287,   290
	.word	  220,   241,   223,   232

bSides:	.word	  157,   187,   199,   111,   123
	.word	  124,   125,   126,   175,   194
	.word	  149,   126,   162,   131,   127
	.word	  177,   199,   197,   175,   114
	.word	  164,   141,   142,   173,   166
	.word	  104,   146,   123,   156,   163
	.word	  121,   118,   177,   143,   178
	.word	  112,   111,   110,   135,   110
	.word	  127,   144,   210,   172,   124
	.word	  125,   116,   162,   128,   192
	.word	  117,   114,   115,   172,   124
	.word	  125,   116,   162,   138,   192
	.word	  121,   183,   133,   130,   137
	.word	  142,   135,   158,   123,   135
	.word	  127,   126,   126,   127,   227
	.word	  177,   199,   177,   175,   114
	.word	  194,   124,   112,   143,   176
	.word	  134,   126,   132,   156,   163
	.word	  124,   119,   122,   183,   110
	.word	  191,   192,   129,   129

rtAreas:
	.space	398

length:	.word	99

rtMin:	.word	0 
rtMax:	.word	0 
rtSum:	.word	0 
rtAve:	.word	0 
rtEMed:	.word	0 

# -----

hdr:	.ascii	"MIPS Assignment #2 \n"
	.ascii	"  Right Triangle Areas Program:\n"
	.ascii	"  Also finds minimum, maximum, sum, average,\n"
	.asciiz	"  and estimated median for the areas.\n\n"

a1_st:	.asciiz	"\nAreas Minimum = "
a2_st:	.asciiz	"\nAreas Maximum = "
a3_st:	.asciiz	"\nAreas Sum     = "
a4_st:	.asciiz	"\nAreas Average = "
a5_st:	.asciiz	"\nAreas Est Med = "

newLn:	.asciiz	"\n"
blnks:	.asciiz	"  "


###########################################################
#  text/code segment

# --------------------
#  Compute right triangle areas.
#  Then find middle, max, sum, and average for the areas.

.text
.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# -----


#	YOUR CODE GOES HERE
# Right Triangle Areas Program:
# Formula: areas[i] = aSides[i] * bSides[i] / 2 

# Load addresses
la $t0, aSides
la $t1, bSides
la $s0, rtAreas

# Get length, counter, & div
lw $t2, length
li $t3, 0
li $s4, 2 # div by 2 

rightTriangleLoop:
    # Deference arrays
    lw $t4, ($t0)
    lw $t5, ($t1)

    # Calculation
    mul $t6, $t4, $t5
    div $t6, $t6, $s4    
    sw $t6, ($s0)

    # Increments
    add $t0, $t0, 4
    add $t1, $t1, 4
    add $s0, $s0, 4
    add $t3, $t3, 1

	bne $t3, $t2, rightTriangleLoop

# Display results for rtAreas, 8 numbers per line
# Referenced page 87 for direction 
	la	$a0, newLn    
	# print new line 
	li	$v0, 4       
	syscall 
	            	
	la	$s0, rtAreas 
	# rtAreas address
	li	$t3, 0          
	# counter

printLoop:
	li	$v0, 1   
	# call code for print int 
    lw	$a0, ($s0)   
	# get array[i]   
    syscall 

	li	$v0, 4 
	# print blnks  
    la	$a0, blnks 
    syscall  

    addu $s0, $s0, 4  
	# update addr (next word)
    addu $t3, $t3, 1 
	# increment counter  
	rem $t0, $t3, 8 
	bnez $t0, skipNewLine	

	li	$v0, 4
	la	$a0, newLn
	syscall	

skipNewLine:
    bne  $t3, $t2, printLoop 
# if counter < length -> loop  

# UNSORTED LIST MIN & MAX 
# Referenced the example asst0.asm 

# Areas Minimum = 12656
# Areas Maximum = 29169
	la $t0, rtAreas # addr of array 
	lw $t1, length	# length 

	lw $s1, ($t0) 	# set min
	lw $s2, ($t0)	# set max 

MinMaxLoop:
	lw $t2, ($t0)
	bge $t2, $s1, notMin
	move $s1, $t2
	sw $s1, rtMin

notMin:
	ble $t2, $s2, notMax
	move $s2, $t2 
	sw $s2, rtMax

notMax:
	sub $t1, $t1, 1
	addu $t0, $t0, 4
	bnez $t1, MinMaxLoop 

# CODE GIVEN BY ED'S LECTURE 4/3/24
# Areas Sum     = 1817525
# Areas Average = 18358
la $t0, rtAreas
lw $t1, length
li $t2, 0

sumLoop:
	lw $t4, ($t0)
	add $t2, $t2, $t4

	add $t0, $t0, 4
	sub $t1, $t1, 1
	bgtz $t1, sumLoop

	sw $t2, rtSum
	lw $t1, length
	div $t5, $t2, $t1
	sw $t5, rtAve

# ODD CASE: first, last, middle value, div by 3 
# Areas Est Med = 19372

	la $s0, rtAreas
# # # # # # # # # # #
	li $s1, 2
	li $s2, 4
	li $s3, 3
# # # # # # # # # # #
	lw $t0, ($s0)
	# First Value

	lw $t1, length
	sub $t2, $t1, 1
	mul $t3, $t2, $s2
	add $t3, $t3, $s0
	lw $t4, ($t3)
	# Last Value

	div $t5, $t1, $s1
	mul $t6, $t5, $s2
	add $t7, $t6, $s0
	lw $t8, ($t7)
	# Middle value

	# Sum the first, last, and middle value
	add $s5, $t0, $t4
	# first value + last value
	add $s5, $s5, $t8
	# $s5 + middle value

	div $s5, $s5, $s3
	# Divide $s5 by 3

	sw $s5, rtEMed
##########################################################
#  Display results.

	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, rtMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print max message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, rtMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, rtSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, rtAve
	li	$v0, 1
	syscall				# print average

# -----
#  Print estimated median message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "estMed = "

	lw	$a0, rtEMed
	li	$v0, 1
	syscall				# print estMed

# -----
#  Done, terminate program.

endit:
	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main

