###########################################################################
#  Name: Michelle Silva
#  NSHE ID: 5006988436
#  Section: 1001 & 1002
#  Assignment: MIPS #1
#  Description: Data Representation (binary, decimal, hex)

################################################################################
#  data segment

.data

aSides:	.word	 201,  207,  212,  215,  223,  227,  231,  236,  241,  245
	.word	 251,  252,  262,  264,  271,  273,  287,  289,  293,  299
	.word	 301,  305,  312,  315,  326,  328,  332,  337,  341,  343
	.word	 401,  408,  411,  413,  421,  424,  431,  434,  445,  448
	.word	 453,  454,  460,  462,  474,  475,  486,  487,  491,  492
	.word	 501,  504,  515,  517,  524,  525,  535,  537,  543,  548
	.word	 551,  553,  563,  567,  577,  579,  582,  588,  593,  595
	.word	 601,  609,  612,  617,  623,  630,  638,  642,  647,  650

bSides:	.word	  15,   25,   33,   44,   58,   69,   72,   86,   99,  101
	.word	  32,   51,   76,   87,   90,  100,  111,  123,  132,  145
	.word	 107,  121,  137,  141,  157,  167,  177,  181,  191,  199
	.word	 202,  209,  215,  219,  223,  225,  231,  242,  244,  249
	.word	 332,  351,  376,  387,  390,  400,  411,  423,  432,  445
	.word	 457,  487,  499,  501,  523,  524,  525,  526,  575,  594
	.word	 251,  253,  266,  269,  271,  272,  280,  288,  291,  299
	.word	 369,  374,  377,  379,  382,  384,  386,  388,  392,  393

cSides:	.word	 102,  113,  122,  139,  144,  151,  161,  178,  186,  197
	.word	 206,  212,  222,  231,  246,  250,  254,  278,  288,  292
	.word	 203,  215,  221,  239,  248,  259,  262,  274,  280,  291
	.word	 400,  404,  406,  407,  424,  425,  426,  429,  448,  492
	.word	 634,  652,  674,  686,  697,  704,  716,  720,  736,  753
	.word	 782,  795,  807,  812,  827,  847,  867,  879,  888,  894
	.word	 501,  513,  524,  536,  540,  556,  575,  587,  590,  596
	.word	 782,  795,  807,  812,  827,  847,  867,  879,  888,  894

semiPerims:
	.space	320

length:	.word	80

sMin:	.word	0
sEstMed: .word	0
sMax:	.word	0
sSum:	.word	0
sAve:	.word	0 


# -----

hdr:	.ascii	"MIPS Assignment #1 \n"
	.ascii	"Program to calculate the semi-perimeter of each right "
	.ascii	"triangle in a\n series of right triangles.  Also finds "
	.asciiz	"min, mid, max, sum, and average\n for the semi-perimeters.\n"

newLine:
	.asciiz	"\n"
blnks:	.asciiz	"  "

a1_st:	.asciiz	"\nSemi-Perimeters min = "
a2_st:	.asciiz	"\nSemi-Perimeters estMed = "
a3_st:	.asciiz	"\nSemi-Perimeters max = "
a4_st:	.asciiz	"\nSemi-Perimeters sum = "
a5_st:	.asciiz	"\nSemi-Perimeters ave = "


###########################################################
#  text/code segment

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
# Load variables into registers 
la $t0, aSides 
 # load address 
la $t1, bSides
 # load address 
la $t2, cSides
# load address 
la $s0, semiPerims 
# load semiPerims address
lw $t3, length 
# length 
li $t4, 0 
# counter
li $s4, 2

loop: 
lw $t5, ($t0) 
# get aSides array 
lw $t6, ($t1)
# get bSides array
lw $t7, ($t2)
# get cSides array

# semiPerim = aSides + bSides + cSides / 2 
add $t8, $t5, $t6  
add $t8, $t8, $t7  
div $t8, $t8, $s4 
sw $t8, ($s0)
# saves it into semiPerims by dereference 

add $t0, $t0, 4   
add $t1, $t1, 4    
add $t2, $t2, 4 

add $s0, $s0, 4    
add $t4, $t4, 1  

bne $t4, $t3, loop 

# Display results for Semi-Perims, 8 numbers per line 
# Referenced page 87 for direction 
	la	$a0, newLine   
	# print new line 
	li	$v0, 4       
	syscall  

	la	$s0, semiPerims 
	# semiPerims address
	li	$t4, 0          
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
    addu $t4, $t4, 1 
	# increment counter  
	rem $t0, $t4, 7 
	bnez $t0, skipNewLine	

	li	$v0, 4
	la	$a0, newLine
	syscall	

skipNewLine:
    bne  $t4, $t3, printLoop 
# if counter < length -> loop  

# Semi-Perimeters min = 159
la $s0, semiPerims 
# load semiPerims address 
lw $s1, ($s0)
# deference semiPerims
sw $s1, sMin
# save sMin 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Semi-Perimeters max = 1018
la $s0, semiPerims
# load semiPerims address
lw $t0, length
# length 
lw $t1, ($s0)  # max 
# deference semiPerims
li $t2, 0
# counter 

maxLoop:
	beq $t2, $t0, doneLoop # if counter equals length, done
	lw $t3, ($s0) # current value 
	bgt $t3, $t1, updateMax # if current > max
	add $s0, $s0, 4
	add $t2, $t2, 1
	j maxLoop
updateMax:
	move $t1, $t3 # max = element 
	add $s0, $s0, 4
	add $t2, $t2, 1 
	j maxLoop
doneLoop:
	sw $t1, sMax

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# CODE GIVEN BY ED'S LECTURE 4/3/24

# Semi-Perimeters sum = 47766
# Semi-Perimeters ave = 597
la $t0, semiPerims
lw $t1, length
li $t2, 0 

sumLoop:
	lw $t3, ($t0)
	add $t2, $t2, $t3 
	
	add $t0, $t0, 4
	sub $t1, $t1, 1
	bgtz $t1, sumLoop

	sw $t2, sSum
	lw $t1, length
	div $t4, $t2, $t1
	sw $t4, sAve

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

 # Semi-Perimeters estMed = 607
la $s0, semiPerims    
# semiPerims array address
lw $t0, ($s0)         
# First value 
lw $t1, length 
# # # # # # # # #
li $s4, 2  
li $s5, 4   
# # # # # # # # #     
sub $t2, $t1, 1       
# length - 1
mul $t3, $t2, $s5        
# Multiply by 4 (32-bits)
add $t3, $t3, $s0    
lw $t4, ($t3)         
# Last value

div $t5, $t1, $s4       
# length / 2 
sub $t6, $t5, 1      
mul $t7, $t6, $s5       
# Multiply by 4 
add $t7, $t7, $s0     
lw $t8, ($t7)         
# value before middle value 

add $t7, $t7, 4       
# Increment by 4 
lw $t9, ($t7)        
# First middle value 

add $s1, $t0, $t4     
# first value + last value
add $s1, $s1, $t8     
# $s1 + value before first middle
add $s1, $s1, $t9     
# $s1 + first middle value
div $s1, $s1, $s5       
# Divide $s1 by 4 
sw $s1, sEstMed        
########################################################## 
#  Display results.

	la	$a0, newLine		# print a newline
	li	$v0, 4
	syscall
	la	$a0, newLine		# print a newline
	li	$v0, 4
	syscall

#		MIN DISPLAY 
#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, sMin
	li	$v0, 1
	syscall				# print min

#		MAX DISPLAY 
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, sMax
	li	$v0, 1
	syscall				# print max

#		SUM DISPLAY 
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, sSum
	li	$v0, 1
	syscall				# print sum

#		AVE DISPLAY 
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, sAve
	li	$v0, 1
	syscall				# print average

# 		ESTMED DISPLAY 
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "med = "

	lw	$a0, sEstMed
	li	$v0, 1
	syscall				# print mid

#  Done, terminate program.

endit:
	la	$a0, newLine		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main
