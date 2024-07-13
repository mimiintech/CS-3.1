# Michelle Silva 


# data segment 
.data



# text/code segment 
.text 
.globl main 
.ent main
main: 

# Find calcBases 
#   8 arguments 
# calcBases(slantLens, heights, len, baseLens, bMin, bMed, bMax, bAve)
#   THE MAIN

    lw $a0, slantLens # passed as value # arg 1
    la $a1, heights                     # arg 2 
    lw $a2, len # passed as value     # arg 3 
    lw $a3, baseLens # passed as value     # arg 4 
# # # # # # # # # # #
#   The stack
    subu $sp, $sp, 16 
    la $t0, bMin
    sw $t0, ($sp)           # arg 5 stack 
    la $t0, bMed
    sw $t0, 4($sp)          # arg 6 stack 
    la $t0, bMax 
    sw $t0, 8($sp)          # arg 7 stack 
    la $t0, bAve 
    sw $t0, 12($sp)         # arg 8 stack 
    jal calcBases
    addu $sp, $sp, 16 

#  Done, terminate program.

	li	$v0, 10
	syscall					# au revoir...
.end main



# VOID FUNCTION 
.globl calcBases
.ent calcBases
calcBases:
    subu $sp, $sp, 36 
    sw $s0, ($sp) # slantLens
    sw $s1, 4($sp) # heights
    sw $s2, 8($sp) # len 
    sw $s3, 12($sp) # baseLens 
# # # # # # # # # 
#   The stack 
    sw $s4, 16($sp) # bMin ($fp)
    sw $s5, 20($sp) # bMed 4($fp)
    sw $s6, 24($sp) # bMax 8($fp)
    sw $fp, 28($sp) # bAve 12($fp)
    sw $ra, 32($sp) 
    addu $fp, $sp, 36 

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3

    # The stack
    lw $s4, ($fp) # bMin ($fp)
    lw $s5, 4($fp) # bMed 4($fp)
    lw $s6, 8($fp) # bMax 8($fp)
    lw $s7, 12($fp) # bAve 12($fp)

# # # # # # #  # # # # # #  # # ## 
# Formula: 
# baseLens[i] = 2 * Sqrt slantLens[i]^2 - heights[i]^2 
# calcBases(slantLens, heights, len, baseLens, bMin, bMed, bMax, bAve)
    li $t0, 2 
    li $t9, 0 # index 

loop:
    lw $t1, ($s0) 
    # get slantLens array
    lw $t2, ($s1)
    # get heights array 

    # baseLens[i] = 2 * Sqrt slantLens[i]^2 - heights[i]^2 
    mul $t3, $t1, $t1 # slantLens[i]^2 
    mul $t4, $t2, $t2  # heights[i]^2
    sub $a0, $t3, $t4  # slantLens[i]^2 - heights[i]^2 

    # call a function iSqrt(n) that will return the 
    # integer square root of a passed integer value 
    jal iSqrt # call iSqrt 
    mul $t5, $v0, $t0  # times by 2 
    sw $t5, ($s3) # saves to baseLens 

# # # #  ##
    addu $s0, $s0, 4 
    addu $s1, $s1, 4
    addu $s3, $s3, 4 
    addu $t9, $t9, 1 

    bne $t9, $s2, loop
# # # # # # # # # # 
# Loop to find min, med, max, ave 
    li $t0, 0 # index 
    lw $t1, ($s3) # min = baseLen[0]
    lw $t2, ($s3) # max = baseLen[0]
    li $t3, 0       # sum = 0

loopAgain:
    lw $t4, ($s3) # get baseLen[n]
    bge $t4, $t1, notNewMin 
    move $t1, $t4 # min in $t1 
notNewMin:
    ble $t4, $t2, notNewMax 
    move $t2, $t4 # max in $t2 
notNewMax:
    add $t3, $t3, $t4 # sum in $t3 
    addu $s3, $s3, 4 # update baseLen addr 
    addu $t0, $t0, 1 # index++
    blt $t0, $s2, loopAgain

    sw $t1, ($s4) # bMin
    sw $t2, ($s6) # bMax 
    sw $t3, ($s7) # sum

    div $t0, $t3, $s2 # ave = sum / length 
    sw $t0, ($s7) # save ave 

# # # # # # # # # # # # # 
#   Find the median
#   length / 2 
    div $t5, $s2, 2 
#   with the remainder, whether its odd or even 
    rem $t6, $s2, 2 
# # # # # # #
    beqz $t6, evenCase 
    mul $t7, $t5, 4 
    add $t7, $t7, $s3 
# # # # # # #
    lw $t8, ($t7)
    # if $t6 is equal to 0, even case 
    sw $t8, ($s5) 
    # save median odd length 
    j restoreStack

evenCase: 
    sub $t5, $t5, 1 
    # first middle element 
    mul $t7, $t5, 4
    add $t7, $t7, $s3
    lw $t8, ($t7)

    add $t5, $t5, 1 
    # second middle element 
    mul $t9, $t5, 4
    add $t9, $t9, $s3
    lw $t0, ($t9)
    
    # add two middle elements
    add $t8, $t8, $t0 
    # div by 2 
    div $t8, $t8, 2 
    sw $t8, ($s5)

restoreStack: 
    lw $s0, ($sp) # slantLens
    lw $s1, 4($sp) # heights
    lw $s2, 8($sp) # len 
    lw $s3, 12($sp) # baseLens 
    lw $s4, 16($sp) # bMin ($fp)
    lw $s5, 20($sp) # bMed 4($fp)
    lw $s6, 24($sp) # bMax 8($fp)
    lw $fp, 28($sp) # bAve 12($fp)
    lw $ra, 32($sp) 
    addu $fp, $sp, 36 
    jr $ra 
.end calcBases





# Create a function that takes in the following arguments:
# 1) Array of sizes
# 2) Passed by reference (word) - Max
# 3) Passed by reference (byte) - Min
# 4) Passed by value (byte) - Range
# 5) Passed by reference (word) - length
# Return the sum
# Usage:
# Sum = sumOfArray(array, max, min, range, length);


.globl sumOfArray
.ent sumOfArray
sumOfArray:
    subu $sp, $sp, 24
    sw $s0, ($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $ra, 20($sp)
    addu $fp, $sp, 24

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3

    lw $s4, ($fp)

    lw $t1, ($s0)
    lw $t2, ($s0)
    li $t0, 0

loop:
    lw $t4, ($s0)
    bge $t4, $t1, notNewMin
    move $t1, $t4
notNewMin:
    ble $t4, $t2, notNewMax
    move $t2, t4

    sw $t1, ($s2)
    sw $t2, ($s1)

# Range
    sub $t5, $t2, $t1 
    sw $t5, ($s3)
    


