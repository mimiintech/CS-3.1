###########################################################################
#  Name: Michelle Silva
#  NSHE ID: 5006988436
#  Section: 1001 & 1002 
#  Assignment: MIPS #5
#  Description: Become familiar with RISC Architecture concepts, the MIPS Architecture, and QtSpim
# (the MIPS simulator)


#  Write an assembly language function to
#  determine of a target array can be split into
#  two subsets that each total the same sum.

#  Specifically, given an array of integers, is it possible to
#  divide the ints into two groups, so that the sums of the
#  two groups are the same.  Every int must be in one group
#  or the other.

#####################################################################
#  data segment

.data

# -----
#  Constants

TRUE = 1
FALSE = 0

# -----
#  Array declarations
#	Note, uses an array of addresses

arr0:		.word	 2,  5, 10,  4
arr1:		.word	 2,  5, 11,  4
arr2:		.word	 9,  1,  8,  2,  7
		.word	 3,  6,  4,  5, 11 
arr3:		.word	11, 13, 15, 17, 19
		.word	21, 23, 25, 27, 29
arr4:		.word	10, 12, 14, 16, 18
		.word	20, 22, 28, 99
arr5:		.word	30, 61, 93, 16, 47
		.word	55, 72, 11, 99,  7
		.word	28, 82
arr6:		.word	30, 61, 93, 16, 47
		.word	55, 72, 11, 99,  7
		.word	28, 81
arr7:		.word	172, 512, 832, 691
		.word	204, 448, 777, 342
arr8:		.word	172, 512, 832, 615
		.word	204, 448, 777, 342
arr9:		.word	10, 12, 14, 16, 18
		.word	11, 13, 15, 17, 19
		.word	20, 22, 24, 26, 28
		.word	21, 23, 25, 27, 29

arrCount:	.word	10
addrs:		.space	40
lengths:	.word	 4,  4, 10, 10,  9
		.word	12, 12,  8,  8, 20

# -----
#  Variables for main

hdr:		.ascii	"\nMIPS Assignment #5\n"
		.asciiz	"Sum Split Array Determination Program\n"

yesMsg:		.asciiz	"\nYes, the array can be split into two sets.\n"
noMsg:		.asciiz	"\nNo, the target sum can not be split into two set.\n"

endMsg:		.ascii	"\n\n**********************************************"
		.asciiz	"\nGame over, thanks for playing.\n"

# -----
#  Local variables for prtList() function.

title:		.ascii	"\n**********************************************\n"
		.asciiz	"Set of Numbers: \n\n"
tab:		.asciiz	"\t"
newLine:	.asciiz	"\n"


#####################################################################
#  text/code segment

.text

.globl main
.ent main
main:

# -----
#  Display program header.

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  Populate array of addresses.
#	The array of addresses allows a loop for calling
#	the function on a series of different arrays.
#	Propably overly fancy...

	la	$t0, addrs

	la	$t1, arr0
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr1
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr2
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr3
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr4
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr5
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr6
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr7
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr8
	sw	$t1, ($t0)
	add	$t0, $t0, 4
	la	$t1, arr9
	sw	$t1, ($t0)

# -----
#  Main processing loop
#	Note, calls the functions with the arrays
#	from a table of addresses (populated above).

	lw	$s0, arrCount
	la	$s1, addrs
	la	$s2, lengths
doNext:

# -----
#  Display set of numbers.

	lw	$a0, ($s1)			# addrs[i]
	lw	$a1, ($s2)			# lengths[i]
	jal	prtList

# -----
#  call splitArray() function to determine if given
#  array can be split into two sets, each set totaling
#  the same sum.
#	Note, returns true or false.
#	HLL Call: boolAns = splitArray(array, currentIndex, sum1,
#					sum2, arraySize)

	lw	$a0, ($s1)			# array (starting address)
	li	$a1, 0				# initially, current index = 0
	li	$a2, 0				# initially, sum1 = 0
	li	$a3, 0				# initially, sum2 = 0
	subu	$sp, $sp, 4
	lw	$t0, ($s2)
	sw	$t0, ($sp)
	jal	splitArray
	add	$sp, $sp, 4

	beq	$v0, TRUE, sayYes

	la	$a0, noMsg
	j	prtMsg
sayYes:
	la	$a0, yesMsg
prtMsg:
	li	$v0, 4
	syscall

# -----
#  Check next array...

	add	$s1, $s1, 4
	add	$s2, $s2, 4
	sub	$s0, $s0, 1
	bgtz	$s0, doNext

# -----
#  Done, terminate program.

	li	$v0, 4
	la	$a0, endMsg
	syscall

	li	$v0, 10
	syscall					# all done...
.end main

#####################################################################
#  MIPS assembly language function, prtList, to display
#	a list of numbers and return the sum.
#	The numbers should be printed 5 per line.
#  Note, due to the system calls, the saved registers must
#	be used.  As such, push/pop saved registers altered.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	N/A

.globl prtList
.ent prtList
prtList:
	subu $sp, $sp, 20
	sw $s0, ($sp) 
	sw $s1, 4($sp) 
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	addu $fp, $sp, 20 
# # # # # # # # # # # # # #

	move $s0, $a0     # Starting address of the list
    move $s1, $a1     # List length

    li $v0, 4         # Print title
    la $a0, title
    syscall

    li $t0, 0         # Counter
    li $t1, 5         # Numbers per line

printloop:
    beq $t0, $s1, done

    li $v0, 4         # Print tab
    la $a0, tab
    syscall

    mul $t2, $t0, 4
    add $t2, $s0, $t2
    lw $a0, ($t2)
    li $v0, 1         # Print integer
    syscall

    addu $t0, $t0, 1  # Increment counter
    rem $t3, $t0, $t1
    bnez $t3, printloop

	li $v0, 4         # Print new line
    la $a0, newLine
    syscall

    j printloop

# # # # # # # # # # # # # 
done: 
	lw $s0, ($sp)        
    lw $s1, 4($sp)
	lw $s2, 8($sp)       
    lw $s3, 12($sp)    
    lw $s4, 16($sp)        
    addu $sp, $sp, 20  
    jr $ra 
.end prtList

#####################################################################
#  function to recursivly determine if a given target sum
#	can be computed from the numbers in a given array.
#	Returns boolean, TRUE is yes and FALSE if no

#  Note: In C++, the expression (sum1 == sum2) evaluates as
#		TRUE if sum1 == sum2 and FALSE if sum1 != sum2

#	boolean splitArray(int start, int[] nums, int sum1, int sum2) {
#
#	    if (start >= length) return sum1 == sum2;
#
#	    return splitArray(start + 1, nums, sum1 + nums[start], sum2)
#	            || splitArray(start + 1, nums, sum1, sum2 + nums[start]);
#	}

# -----
#  Arguments:
#	$a0 - array address
#	$a1 - current index
#	$a2 - sum1 so far
#	$a3 - sum2 so far
#	($fp) - array size
#  Returns:
#	true or false (in $v0)

.globl splitArray
.ent splitArray
splitArray:
    subu $sp, $sp, 36
    sw $s0, ($sp)
	#	$a0 - array address
    sw $s1, 4($sp)
	#	$a1 - current index
    sw $s2, 8($sp)
	#	$a2 - sum1 so far
    sw $s3, 12($sp)
	#	$a3 - sum2 so far
    sw $s4, 16($sp)
	#	($fp) - array size
    sw $s5, 20($sp)
	# preseved register
    sw $s6, 24($sp)
	# preseved register
    sw $fp, 28($sp)
    sw $ra, 32($sp)
    addu $fp, $sp, 36

    move    $s0, $a0   
	#	$a0 - array address   
    move    $s1, $a1  
	#	$a1 - current index  
    move    $s2, $a2   
	#	$a2 - sum1 so far    
    move    $s3, $a3 
	#	$a3 - sum2 so far     
    lw      $s4, ($fp) 
	#	($fp) - array size
	li $t7, 1  

    # Condition: If the current index has reached the end of the array 
    bge	$s1, $s4, baseCase
# # # # # # # # # # # # # ## # # # # # # # # # # # # # # # ## # # # # # # # # # 
    lw $t5, ($s0)              	 	
    add $s2, $s2, $t5             
	move $t6, $s2
	sub $s2, $s2, $t5				
	add $s0, $s0, 4	
	add $s5, $s1, $t7 				

	move    $a0, $s0   
	# update array address   
    move	$a1, $s5 
	# update current index      
    move	$a2, $t6 
	# update sum1
	move	$a3, $s3  
	# update sum2   
	sub $s0, $s0, 4 
# # # # # # # # # # # # # 
	subu $sp, $sp, 8
	sw $s4, ($sp)
	sw $fp, 4($sp)
	addu $fp, $sp, 8
	jal splitArray
	lw $s4, ($sp)
	lw $fp, 4($sp)
	addu $sp, $sp, 8
# # # # # # # # # # # # #                
	beq	$v0, TRUE, returnTrue	
	bne	$v0, FALSE, returnFalse
# # # # # # # # # # # # # ## # # # # # # # # # # # # # # # ## # # # # # # # # # 
	lw $t5, ($s0)
    add $s3, $s3, $t5        
	add $s0, $s0, 4
	add $s6, $s1, $t7 

	move $a1, $s6
	# update current value 
	move $a0, $s0
	# update array address
	move $a2, $s2
	# update sum1 
    move $a3, $s3  
	# update sum2 
# # # # # # # # # # # # # 
	subu $sp, $sp, 8
	sw $s4, ($sp)
	sw $fp, 4($sp)
	addu $fp, $sp, 8
	jal splitArray
	lw $s4, ($sp)
	lw $fp, 4($sp)
	addu $sp, $sp, 8
# # # # # # # # # # # # # 
	beq	$v0, TRUE, returnTrue	
	bne	$v0, FALSE, returnFalse
	j returnResult
# # # # # # # # # # # # # ## # # # # # # # # # # # # # # # ## # # # # # # # # # 
baseCase:
    beq $s2, $s3, returnTrue
    j returnFalse
returnTrue:
    li	$v0, TRUE       
    j	returnResult
returnFalse:
    li	$v0, FALSE    
returnResult:
	lw $ra, 32($sp)
	lw $fp, 28($sp)
	lw $s6, 24($sp)
	lw $s5, 20($sp)
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, ($sp)
	addu $sp, $sp, 36 
    jr $ra         
.end splitArray
#####################################################################

