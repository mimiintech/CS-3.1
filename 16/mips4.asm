###########################################################################
#  Name: Michelle Silva
#  NSHE ID: 5006988436
#  Section: 1001 & 1002 
#  Assignment: MIPS #4
#  Description: Become familiar with the MIPS Instruction Set, and the MIPS procedure calling
# convention, and indexing for multiple dimension arrays.


#  In recreational mathematics, a Magic Square1 is an
#  arrangement of numbers (usually integers) in a square
#  grid, where the numbers in each row, and in each column,
#  and the numbers in the forward and backward main diagonals,
#  all add up to the same number.  A magic square has the same
#  number of rows as it has columns, typically referred to as
#  the order.  A magic square that contains the integers
#  from 1 to n^2 is called a normal magic square.

#  This program creates odd-order normal magic squares.


###########################################################
#  data segment

.data

# -----
#  Define constants.

TRUE = 1
FALSE = 0

ORDER_MIN = 3
ORDER_MAX = 25

# -----
#  Define variables for main.

hdr:		.ascii	"\nMIPS Assignment #4 \n"
		.asciiz	"Program to create an odd-order magic square. \n\n"

doneMsg:	.ascii	"\nThanks for playing.\n"
		.asciiz	"Program Terminated.\n"

msOrder:	.word	0

# -----
#  Local variables for createMagicSquare() function.

errMsg:		.ascii	"\nError, invalid order.  "
		.asciiz	"Unable to create magic square.\n"

# -----
#  Local variables for displaySquare() function.

MSheader:	.ascii	"\n***************************************"
		.ascii	"***************************************** \n"
MStitle:	.asciiz	"Magic Square: "

orderMsg:	.asciiz	"Order : "
sumMsg:		.asciiz "Sum: "

blnks1:		.asciiz	" "
blnks2:		.asciiz	"  "
blnks3:		.asciiz	"   "
blnks4:		.asciiz	"    "

newLine:	.asciiz	"\n"

# -----
#  Local variables for readOrder() function.

msPmt:		.asciiz	"Enter Order for Odd-Order Magic Square: "

errBadValue:	.ascii	"Error, order must be >=3 and odd. "
		.asciiz "Please re-enter. \n\n"

spc:		.asciiz	"   "

# -----
#  Local variables for doAnother() function.

qPmt:		.asciiz	"\nCreate another magic square (y/n)? "
ansErr:		.asciiz	"Error, must answer with (y/n)."

ans:		.space	12


########################################################################
#  text/code segment

.text

.globl main
.ent main
main:

# -----
#  Display main program header.

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  Read order, create magic square, display magic square.

	li	$s0, 1
mainLoop:
	la	$a0, msOrder
	jal	readOrder

	move	$s2, $v0			# save address of array

	move	$a0, $s2
	lw	$a1, msOrder
	jal	createMagicSquare

	move	$a0, $s2
	lw	$a1, msOrder
	move	$a2, $s0
	jal	displayMagicSquare

	add	$s0, $s0, 1

# -----
#  See if user wants to do another?

	jal	doAnother
	beq	$v0, TRUE, mainLoop

# -----
#  Done, terminate program.

	la	$a0, doneMsg
	li	$v0, 4
	syscall					# print header

	li	$v0, 10
	syscall
.end main

# ----------------------------------------------------------------------
#  Function to read magic square order from user.

#  Prompt for, read, and verify the order for a magic square.
#  Ensure that order is between ORDER_MIN and ORDER_MAX and is odd.
#  If order is not valid, re-prompt until a valid number is provided.
#  Once order is valid, allocate necessary memory for a two-dimensional
#  array (order x order) size for word (4-byte) values.

#  Note, uses read intger and allocate memory syscalls.

# -----
#    Arguments:
#	$a0, magic square order, address
#    Returns:
#	$v0 - address of allocated memory
#	VALUE RETURNING FUNCTION 

#  Local variables for readOrder() function.

# msPmt:		.asciiz	"Enter Order for Odd-Order Magic Square: "
# errBadValue:	.ascii	"Error, order must be >=3 and odd. "
# .asciiz "Please re-enter. \n\n"

# spc:		.asciiz	"   "

# ORDER_MIN = 3
# ORDER_MAX = 25
#   readOrder(msOrder)

.globl readOrder
.ent readOrder
readOrder:
    subu $sp, $sp, 24    
    sw $s0, ($sp)         # aSides
    sw $s1, 4($sp)         # cSides
    sw $s2, 8($sp)         # heights
    sw $s3, 12($sp)        # length
    sw $fp, 16($sp)        # $fp
    sw $ra, 20($sp)        
    addu $fp, $sp, 24

    move $s0, $a0  # $a0 is the address to store the order

userInput:
    # Read user input (read integer)
    li $v0, 4       # call code for print string
    la $a0, msPmt
    syscall

    li $v0, 5       # call code for read integer
    syscall

    move $t5, $v0 

    # Verify user input
    blt $t5, ORDER_MIN, notValid  
    bgt $t5, ORDER_MAX, notValid 

    # Check if user input is odd or even 
    li $t3, 2
    rem $t7, $t5, $t3 
    
    bnez $t7, valid 
# # if its not zero (even), then its valid (odd)
    beqz $t7, notValid
# # if it is zero (even), then its not valid 

valid: 
    # User input is valid, allocate memory

    # Store it 
    sw $t5, ($s0)

    # Allocate memory 
    mul $a0, $t5, $t5 
    mul $a0, $a0, 4

    li $v0, 9  
    # Referenced page 84 
    # Allocate memory syscall
    syscall

    move $v0, $v0 

    j done 

notValid:
    # Print error message
    li $v0, 4
    la $a0, errBadValue
    syscall

    j userInput

done: 
    # Restore registers & return to calling routine 
    lw $s0, ($sp)         # aSides
    lw $s1, 4($sp)         # cSides
    lw $s2, 8($sp)         # heights
    lw $s3, 12($sp)        # length
    lw $fp, 16($sp)        # $fp
    lw $ra, 20($sp) 
    addu $sp, $sp, 24
    jr $ra 
.end readOrder

# ----------------------------------------------------------------------
#  Function to create an odd-order normal magic square.

# -----
#  Formula for multiple dimension array indexing:
#	addr(row,col) = base_address + (rowIndex * order + colIndex) * elementSize

# -----
#  Arguments
#	$a0 - empty magic sqaure, address
#	$a1 - magic square order, value
#   VOID FUNCTION
#   createMagicSqaure(magicSquare, msOrder)

.globl createMagicSquare
.ent createMagicSquare

createMagicSquare:
    # Save registers on stack
    subu $sp, $sp, 32
    sw $s0, ($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $s6, 24($sp)
    sw $s7, 28($sp)
    addu $fp, $sp, 32

    # Initialize variables
    li $t9, 4
    li $t2, 2
    li $s6, 0   # Current row
    li $s7, 1   # Current number
    move $s1, $a1   # Magic square order
    mul $t6, $s1, $s1   # Total number of elements
    move $s0, $a0   # Magic square address
    div $s5, $s1, $t2   # Current column

createLoop:
    # Calculate address of current position
    mul $t8, $s6, $s1
    add $t8, $t8, $s5
    mul $t8, $t8, $t9
    add $t8, $s0, $t8

    # Store current number in the square
    sw $s7, ($t8)
    add $s7, $s7, 1

    # Move to next position
    sub $t5, $s6, 1
    add $t0, $s5, 1

    # Check if move is out of bounds
    bge $t5, $zero, outOfBounds
    j topCorner

outOfBounds:
    # Check if move is outside the square
    bge $t0, $s1, lastRow
    j checkFilled

lastRow:
    # Check if move is to the previous row
    bge $t5, $zero, pastRow
    j nextColumn

checkFilled:
    # Check if the position is already filled
    mul $t8, $t5, $s1
    add $t8, $t8, $t0
    mul $t8, $t8, $t9
    add $t8, $s0, $t8
    lw $t4, ($t8)
    beq $t4, $zero, updatePosition
    j goBelow

updatePosition:
    # Update current position
    move $s6, $t5
    move $s5, $t0
    bge $s7, $t6, finished
    j createLoop

topCorner:
    # Check if move is to the upper right corner
    bne $t0, $s1, nextColumn
    j goDown

goBelow:
    # Move to the position below
    add $t5, $s6, 1
    bge $t5, $s1, finished
    j withBounds

withBounds:
    # Check if the position below is filled
    mul $t8, $t5, $s1
    add $t8, $t8, $s5
    mul $t8, $t8, $t9
    add $t8, $s0, $t8
    lw $t4, ($t8)
    beq $t4, $zero, goDown
    j finished

nextColumn:
    # Move to the next column
    sub $s6, $s1, 1
    add $s5, $s5, 1
    bge $s5, $s1, wrapToZero
    j createLoop

wrapToZero:
    # Wrap to the leftmost column
    li $s5, 0
    j createLoop

pastRow:
    # Move to the previous row
    sub $s6, $s6, 1
    bge $s6, $zero, wrapToZero
    j lessZero

lessZero:
    # Wrap to the last row
    sub $s6, $s1, 1
    j createLoop

goDown:
    # Move down one row
    add $s6, $s6, 1
    j createLoop

finished:
    # Restore registers from stack
    lw $s0, ($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $s5, 20($sp)
    lw $s6, 24($sp)
    lw $s7, 28($sp)
    addu $fp, $sp, 32
    jr $ra

.end createMagicSquare

# ----------------------------------------------------------------------
#  Function to calulate the sum for an odd-order normal magic square.

#  Formula:
#	sum = order (order^2 +1) / 2

# -----
#  Arguments
#	$a0 - magic square order, value

# -----
#  Returns
#	$v0 - order, value

.globl sum
.ent sum
sum:
    subu $sp, $sp, 24    
    sw $s0, ($sp)         # aSides
    sw $s1, 4($sp)         # cSides
    sw $s2, 8($sp)         # heights
    sw $s3, 12($sp)        # length
    sw $fp, 16($sp)        # $fp
    sw $ra, 20($sp)        
    addu $fp, $sp, 24

    move $s0, $a0 #	$a0 - magic square order, value
    move $v0, $s0 # set magic sqaure order to $v0 

#   Formula:
#	sum = order (order^2 +1) / 2
    li $t0, 1
    li $t1, 2
# # # # # # # # 
    mul $v0, $v0, $s0  # order^2 
    add $v0, $v0, $t0   # add 1 
    div $v0, $v0, $t1   # div by 2 
    mul $v0, $v0, $s0   # times by order 
# # # # # # # # 
     # Restore registers & return to calling routine 
    lw $s0, ($sp)         # aSides
    lw $s1, 4($sp)         # cSides
    lw $s2, 8($sp)         # heights
    lw $s3, 12($sp)        # length
    lw $fp, 16($sp)        # $fp
    lw $ra, 20($sp) 
    addu $sp, $sp, 24
    jr $ra 
.end sum


# ----------------------------------------------------------------------
#  Function to print a formatted magic square.
#  Note, a magic square is an (order x order) two-dimensional array.

#  Arguments:
#	$a0 - magic square to display, address
#	$a1 - order (size) of the square, value
#	$a2 - magic square number, value
#   VOID FUNCTION 
#   displayMagicSquare(magicSquare, msOrder, magicSquareCount)

.globl displayMagicSquare
.ent displayMagicSquare
displayMagicSquare:
    subu $sp, $sp, 24    
    sw $s0, ($sp)         
    sw $s1, 4($sp)       
    sw $s2, 8($sp)        
    sw $s3, 12($sp)      
    sw $fp, 16($sp)       
    sw $ra, 20($sp)        
    addu $fp, $sp, 24

    move $s0, $a0    #	$a0 - magic square to display, address
    move $s1, $a1    #	$a1 - order (size) of the square, value
    move $s2, $a2    #	$a2 - magic square number, value

# # # # # # # # # # # #
    # Print MSheader
    la   $a0, MSheader
    li   $v0, 4 # Print string code 
    syscall

    move $a0, $s2
    # place magic number into $a0 to display 
    li   $v0, 1
    syscall

    la   $a0, newLine
    li   $v0, 4
    syscall

    # Print orderMsg
    la   $a0, orderMsg
    li   $v0, 4 # Print string code 
    syscall

    move $a0, $s1
    # place order size into $a0 to display 
    li   $v0, 1
    syscall

    la   $a0, newLine
    li   $v0, 4
    syscall
    
    # Print sumMsg
    la $a0, sumMsg
    li $v0, 4
    syscall

    # # Call the sum function 
      move $a0, $s1 
    # Pass the order as an argument to sum
      jal sum
    
    # Print the sum
     move $a0, $v0 
    # $v0 contains the sum
    li $v0, 1
    syscall

    la   $a0, newLine
    li   $v0, 4
    syscall

    la   $a0, newLine
    li   $v0, 4
    syscall

# # # # # # # # # # # #
#	$a0 ($s0) - magic square to display, address
#	$a1 ($s1) - order (size) of the square, value
#	$a2 ($s2) - magic square number, value

    li   $s3, 0         
    # row-major
    li   $s4, 0         
    # column-major

rowMajor:
    beq  $s3, $s1, finish 
    # # if row-major equals order size, finish 
    li   $s4, 0       

columnMajor:
    beq  $s4, $s1, continueRow  
    # # if column-major equals order size, continue to next row 
    
    mul  $t5, $s3, $s1 
    # Multiply row index by order
    add  $t5, $t5, $s4 
    # Add column index
    mul  $t5, $t5, 4   
    # Multiply by 4 
    add  $t5, $t5, $s0 
    # Add base address

    lw  $a0, ($t5)
    li  $v0, 1 # Print integer code 
    syscall

    la  $a0, blnks3
    li  $v0, 4
    syscall

    add $s4, $s4, 1  

    j   columnMajor

continueRow:
    la   $a0, newLine
    li   $v0, 4 # Print string code 
    syscall
    
    add $s3, $s3, 1   

    j    rowMajor

finish:
    # Restore registers & return to calling routine 
    lw $s0, ($sp)         
    lw $s1, 4($sp)      
    lw $s2, 8($sp)         
    lw $s3, 12($sp)        
    lw $fp, 16($sp)       
    lw $ra, 20($sp) 
    addu $sp, $sp, 24
    jr $ra 
.end displayMagicSquare

# ----------------------------------------------------------------------
#  Function to ask user if they want to do another magic square.

#  Basic flow:
#	prompt user
#	read user answer (as character)
#		if y/Y -> return TRUE
#		if n/N -> return FALSE
#	otherwise, display error and re-prompt

#  Note, uses read string syscall.

# -----
#  Arguments:
#	none
#  Returns:
#	$v0 - TRUE/FALSE

.globl doAnother
.ent doAnother
doAnother:
    subu $sp, $sp, 24    
    sw $s0, ($sp)         # aSides
    sw $s1, 4($sp)         # cSides
    sw $s2, 8($sp)         # heights
    sw $s3, 12($sp)        # length
    sw $fp, 16($sp)        # $fp
    sw $ra, 20($sp)        
    addu $fp, $sp, 24

userPrompt: 
# # # # # # # # # # #
    # Print qPmt 
    la $a0, qPmt 
    li $v0, 4   # Print string code
    syscall

    # Print ansErr
    la $a0, ans
    li $v0, 8   # Read string code 
    li $a1, 51  # Max chars for string         
    syscall     # ($a1) length of buffer
# # # # # # # # # # 

    # $s0 hold the user input 
    lb $s5, ans 
    # set $s0 to ans 

    li $v0, 1 # TRUE
# # # # # # # # # # #
    beq $s5, 'Y', end 
    beq $s5, 'y', end 

    li $v0, 0 # FALSE
# # # # # # # # # # #
    beq $s5, 'N', end
    beq $s5, 'n', end 

    # Display ansErr 
    la $a0, ansErr
    li $v0, 4 
    syscall

    # Reprompt 
    j userPrompt

    end:
    # Restore registers & return to calling routine 
    lw $s0, ($sp)         # aSides
    lw $s1, 4($sp)         # cSides
    lw $s2, 8($sp)         # heights
    lw $s3, 12($sp)        # length
    lw $fp, 16($sp)        # $fp
    lw $ra, 20($sp) 
    addu $sp, $sp, 24
    jr $ra 
.end doAnother

# ----------------------------------------------------------------------

