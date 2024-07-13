###########################################################################
#  Name: Michelle Silva
#  NSHE ID: 5006988436
#  Section: 1001 & 1002 
#  Assignment: MIPS #3
#  Description: Become familiar with RISC Architecture concepts, the MIPS Architecture, and QtSpim
# (the MIPS simulator)


#####################################################################
#  data segment

.data

# -----
#  Data declarations for main.

aSides1:	.word	119, 117, 115, 113, 111, 119, 117, 115, 113, 111
		.word	112, 114, 116, 118, 110
cSides1:	.word	 34,  32,  31,  35,  34,  33,  32,  37,  38,  39
		.word	 32,  30,  36,  38,  30
heights1:	.word	 51,  52,  51,  55,  54,  53,  52,  57,  58,  59
		.word	 52,  50,  56,  58,  52
tAreas1:	.space	60

len1:		.word	15
estMed1:	.word	0
min1:		.word	0
med1:		.word	0
max1:		.word	0
fSum1:		.float	0.0
fAve1:		.float	0.0

aSides2:	.word	145,  15, 143, 154, 168, 159, 142, 156, 149, 141
		.word	147, 141, 157, 141, 157, 147, 147, 151, 151, 149
		.word	142, 149, 145, 149, 143, 145, 141, 142, 144, 149
		.word	146, 142, 142, 141, 146, 150, 154, 148, 158, 152
		.word	157, 147, 159, 144, 143, 144, 145, 146, 145, 144
		.word	151, 153, 146, 159, 151, 142, 150, 158, 141, 149
		.word	159, 144, 147, 149, 152, 154, 146, 148, 152, 153
		.word	142, 151, 156, 157, 146
cSides2:	.word	 42,   1,  76,  57,  45,  50,  41,  53,  42,  45
		.word	 44,  52,  44,  76,  57,  44,  46,  40,  46,  53
		.word	 52,  53,  42,  69,  44,  51,  61,  78,  46,  47
		.word	 53,  45,  51,  69,  48,  59,  62,  74,  50,  51
		.word	 40,  44,  46,  57,  54,  55,  46,  49,  48,  52
		.word	 41,  43,  44,  56,  50,  56,  75,  57,  50,  56
		.word	 42,  55,  57,  42,  47,  47,  67,  79,  48,  44
		.word	 50,  41,  43,  42,  45
heights2:	.word	 42,   5,  76,  47,  50,  50,  41,  53,  42,  45
		.word	 44,  52,  74,  46,  57,  44,  46,  40,  46,  53
		.word	 42,  43,  42,  49,  44,  51,  61,  78,  46,  57
		.word	 43,  45,  41,  49,  48,  49,  62,  74,  40,  41
		.word	 46,  44,  46,  47,  44,  45,  46,  59,  48,  62
		.word	 41,  43,  44,  46,  40,  56,  75,  47,  50,  46
		.word	 52,  45,  47,  42,  47,  47,  67,  49,  58,  44
		.word	 60,  41,  43,  42,  45
tAreas2:	.space	300
len2:		.word	75
estMed2:	.word	0
min2:		.word	0
med2:		.word	0
max2:		.word	0
fSum2:		.float	0.0
fAve2:		.float	0.0

aSides3:	.word	143, 142, 141, 141, 141, 144, 142, 146, 158, 143
		.word	142, 149, 145, 149, 141, 155, 149, 142, 144, 149
		.word	140, 144, 146, 157, 144, 135, 146, 129, 148, 142
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	169, 174, 127, 179, 152, 141, 144, 156, 142, 133
		.word	141, 153, 154, 146, 140, 156, 175, 167, 150, 146
		.word	154, 155, 145, 162, 152, 141, 142, 156, 156, 143
		.word	168, 159, 151, 142, 153, 141, 176, 151, 149, 156
		.word	146, 179, 149, 137, 146, 154, 154, 156, 164, 142
cSides3:	.word	 71,  48,  55,  43,  52,  40,  58,  71,  54,  52
		.word	 35,  62,  76,  52,  53,  59,  56,  42,  58,  41
		.word	 72,  45,  46,  47,  45,  34,  46,  30,  56,  53
		.word	 53,  42,  31,  31,  51,  34,  42,  46,  58,  53
		.word	 52,  59,  45,  39,  51,  45,  39,  42,  44,  49
		.word	 50,  44,  46,  77,  54,  25,  26,  29,  48,  62
		.word	 41,  43,  46,  49,  51,  52,  54,  58,  41,  65
		.word	 69,  74,  39,  52,  77,  44,  46,  51,  52,  53
		.word	 41,  53,  34,  36,  40,  56,  75,  47,  40,  46
heights3:	.word	 71,  73,  34,  56,  50,  56,  75,  57,  60,  26
		.word	 54,  65,  65,  62,  72,  81,  62,  76,  76,  73
		.word	 32,  79,  61,  42,  73,  41,  76,  41,  69,  56
		.word	 56,  39,  39,  57,  76,  34,  74,  56,  64,  62
		.word	 71,  78,  45,  63,  42,  70,  58,  71,  54,  42
		.word	 65,  62,  56,  32,  73,  29,  36,  32,  58,  41
		.word	 42,  55,  56,  57,  75,  54,  86,  39,  66,  53
		.word	 73,  52,  41,  31,  71,  74,  62,  76,  58,  43
		.word	 52,  70,  65,  69,  61,  65,  59,  62,  64,  59
tAreas3:	.space	360
len3:		.word	90
estMed3:	.word	0
min3:		.word	0
med3:		.word	0
max3:		.word	0
fSum3:		.float	0.0
fAve3:		.float	0.0

aSides4:	.word	145, 144, 143, 157, 153, 154, 154, 156, 164, 142
		.word	166, 152, 152, 151, 146, 150, 154, 178, 188, 192
		.word	182, 195, 157, 152, 157, 147, 167, 179, 188, 194
		.word	154, 152, 174, 186, 197, 154, 156, 150, 156, 153
		.word	152, 151, 156, 187, 190, 150, 151, 153, 152, 145
		.word	157, 187, 199, 151, 153, 154, 155, 156, 175, 194
		.word	149, 156, 162, 151, 157, 177, 199, 197, 175, 154
		.word	164, 141, 142, 153, 166, 154, 146, 153, 156, 163
		.word	151, 158, 177, 143, 178, 152, 151, 150, 155, 150
		.word	157, 144, 150, 172, 154, 155, 156, 162, 158, 192
		.word	153, 152, 146, 176, 151, 156, 164, 165, 195, 156
		.word	157, 153, 153, 140, 155, 151, 154, 158, 153, 152
		.word	169, 156, 162, 127, 157, 157, 159, 177, 175, 154
		.word	181, 155, 155, 152, 157, 155, 150, 159, 152, 154
		.word	161, 152, 151, 152, 171, 159, 154, 152, 155, 151
cSides4:	.word	 53,  52,  46,  76,  50,  56,  64,  65,  55,  56
		.word	 71,  47,  50,  27,  74,  65,  51,  67,  81,  59
		.word	 53,  52,  46,  56,  50,  56,  64,  56,  55,  52
		.word	 51,  83,  53,  50,  55,  89,  55,  58,  53,  55
		.word	 64,  41,  42,  53,  66,  54,  46,  53,  56,  63
		.word	 27,  64,  50,  72,  54,  55,  56,  62,  58,  92
		.word	 51,  83,  53,  50,  57,  51,  55,  58,  53,  55
		.word	 57,  26,  62,  57,  57,  77,  99,  77,  75,  54
		.word	 94,  54,  52,  43,  76,  54,  56,  52,  56,  63
		.word	 54,  59,  52,  83,  50,  61,  92,  59,  59,  52
		.word	 55,  56,  62,  57,  57,  57,  59,  77,  75,  44
		.word	 79,  53,  56,  40,  55,  52,  54,  58,  53,  52
		.word	 61,  72,  51,  53,  56,  69,  54,  52,  55,  51
		.word	 94,  54,  54,  43,  76,  54,  56,  52,  56,  63
		.word	 49,  44,  54,  54,  67,  43,  59,  61,  65,  56
heights4:	.word	 53,  53,  53,  50,  55,  59,  43,  48,  53,  55
		.word	 51,  55,  57,  23,  66,  68,  71,  77,  94,  96
		.word	 52,  59,  55,  59,  51,  55,  59,  42,  44,  49
		.word	 41,  43,  46,  59,  51,  52,  54,  58,  61,  65
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  92,  93
		.word	 52,  59,  55,  59,  51,  55,  59,  52,  34,  39
		.word	 52,  54,  58,  61,  65,  51,  52,  52,  71,  59
		.word	 69,  24,  77,  79,  82,  84,  86,  88,  92,  93
		.word	 50,  54,  56,  57,  54,  55,  56,  59,  48,  92
		.word	 45,  75,  55,  52,  57,  55,  50,  59,  52,  34
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  92,  43
		.word	 50,  51,  54,  59,  50,  55,  61,  74,  88,  93
		.word	 51,  53,  54,  56,  50,  56,  75,  87,  90,  96
		.word	 94,  54,  54,  43,  76,  54,  56,  52,  56,  63
		.word	 55,  52,  56,  55,  40,  57,  63,  79,  82,  54
len4:		.word	150
tAreas4:	.space	600
estMed4:	.word	0
min4:		.word	0
med4:		.word	0
max4:		.word	0
fSum4:		.float	0.0
fAve4:		.float	0.0

aSides5:
		.word	152, 159, 155, 159, 151, 155, 159, 152, 144, 149
		.word	162, 165, 157, 152, 157, 147, 167, 159, 168, 174
		.word	159, 154, 156, 157, 154, 155, 156, 159, 148, 172
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	159, 153, 154, 156, 140, 156, 175, 187, 155, 156
		.word	152, 151, 176, 187, 170, 150, 151, 153, 152, 145
		.word	147, 153, 153, 140, 165, 151, 154, 158, 153, 152
		.word	151, 153, 154, 156, 140, 156, 175, 187, 160, 196
		.word	134, 152, 174, 186, 167, 154, 156, 150, 156, 153
		.word	182, 165, 157, 152, 157, 147, 167, 179, 168, 194
		.word	159, 151, 159, 151, 149, 151, 169, 171, 169, 191
		.word	153, 153, 153, 150, 155, 159, 143, 148, 153, 155
		.word	151, 155, 157, 163, 166, 168, 171, 177, 164, 176
		.word	152, 159, 155, 159, 151, 155, 159, 142, 144, 149
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	152, 159, 155, 159, 151, 155, 159, 152, 154, 159
		.word	152, 154, 158, 161, 165
cSides5:
		.word	 69,  74,  77,  79,  72,  84,  86,  88,  62,  73
		.word	 50,  54,  56,  57,  54,  55,  56,  59,  48,  72
		.word	 45,  75,  55,  52,  57,  55,  50,  59,  52,  54
		.word	 50,  51,  54,  59,  40,  55,  61,  74,  88,  73
		.word	 51,  53,  54,  56,  40,  56,  75,  87,  70,  76
		.word	 94,  54,  54,  43,  76,  54,  56,  52,  56,  63
		.word	 54,  52,  57,  86,  77,  54,  56,  50,  36,  53
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  72,  73
		.word	 55,  52,  56,  55,  40,  57,  63,  79,  82,  74
		.word	 56,  52,  52,  51,  46,  50,  54,  78,  88,  72
		.word	 57,  57,  57,  57,  47,  57,  67,  77,  87,  77
		.word	 57,  87,  99,  51,  53,  54,  55,  56,  75,  74
		.word	 54,  52,  74   86,  97,  54,  56,  50,  36,  53
		.word	 82,  65,  57,  52,  57,  47,  67,  79,  88,  74
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  62,  73
		.word	 59,  51,  59,  31,  49,  51,  69,  71,  79,  71
		.word	 41,  43,  46,  49,  51
heights5:
		.word	 52,  51,  56,  87,  60,  50,  51,  53,  52,  45
		.word	 57,  87,  69,  51,  53,  54,  55,  56,  75,  64
		.word	 49,  56,  62,  51,  57,  77,  69,  67,  75,  54
		.word	 64,  41,  42,  53,  66,  54,  46,  53,  56,  63
		.word	 51,  58,  77,  43,  78,  52,  51,  50,  55,  50
		.word	 57,  44,  50,  72,  54,  55,  56,  62,  58,  62
		.word	 53,  52,  46,  76,  51,  56,  64,  65,  35,  56
		.word	 57,  53,  53,  50,  55,  51,  54,  58,  53,  52
		.word	 69,  56,  62,  57,  57,  57,  59,  77,  75,  54
		.word	 81,  55,  55,  52,  57,  55,  50,  59,  52,  54
		.word	 61,  52,  51,  52,  71,  59,  54,  52,  55,  51
		.word	 53,  52,  46,  76,  50,  56,  64,  65,  55,  56
		.word	 71,  47,  50,  57,  74,  65,  51,  67,  31,  59
		.word	 53,  52,  46,  56,  50,  56,  64,  56,  55,  52
		.word	 51,  83,  53,  50,  55,  89,  55,  58,  53,  55
		.word	 64,  41,  42,  53,  66,  54,  46,  53,  56,  63
		.word	 57,  64,  50,  72,  54
tAreas5:	.space	660
len5:		.word	165
estMed5:	.word	0
min5:		.word	0
med5:		.word	0
max5:		.word	0
fSum5:		.float	0.0
fAve5:		.float	0.0

# -----
#  Variables for main.

asstHeader:	.ascii	"\nMIPS Assignment #3\n"
		.asciiz	"Trapezoid Areas Program\n\n"
hdr_sr_un:	.asciiz	"\n\nTrapezoid Areas (unsorted): \n"


# -----
#  Local variables/constants for prtHeaders() function.

hdr_nm:		.ascii	"\n*******************************************************************"
		.asciiz	"\nData Set #"
hdr_ln:		.asciiz	"\nLength: "
hdr_sr_so:	.asciiz	"\n\nTrapezoid Areas (sorted): \n"


# -----
#  Variables/constants for trapAreas() function.

newLine:	.asciiz	"\n"
blnksfive:	.asciiz "     "

# -----
#  Variables/constants for combSort() function.
swapped:    .byte 0      # FALSE
i:          .word 0
gap:        .word 0
TRUE = 1	
FALSE = 0

# -----
#  Variables/constants for trapStats() function.


# -----
#  Variables/constants for showTrapStats() function.

spc:		.asciiz	"     "
new_ln:		.asciiz	"\n"

str1:		.asciiz "\n sum = "
str2:		.asciiz	"\n ave = "
str3:		.asciiz	"\n min = "
str4:		.asciiz	"\n med = "
str5:		.asciiz	"\n max = "
str6:		.asciiz	"\n est med = "
str7:		.asciiz	"\n pct diff = "


#####################################################################
#  text/code segment

# -----
#  Basic flow:
#	for each data set:
#	  * display headers
#	  * find trapezoid areas
#	  * find estimated median
#	  * sort trapezoid areas
#	  * find trapezoid stats (sum, average, min, med, max, est med)
#	  * display trapezoid areas and stats

.text
.globl	main
.ent main
main:

# ----------------------------
#  Display Program Header.

	la	$a0, asstHeader
	li	$v0, 4
	syscall					# print header
	li	$s0, 1				# counter, data set number

# ----------------------------
#  Data Set #1

	move	$a0, $s0
	lw	$a1, len1
	jal	prtHeaders

	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides1
	la	$a1, cSides1
	la	$a2, heights1
	lw	$a3, len1

	la	$t0, tAreas1
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas1
	lw	$a1, len1
	jal	estMedian

	sw	$v0, estMed1

#  Dislpay unsorted trap areas

	la	$a0, tAreas1
	lw	$a1, len1
	la	$a2, hdr_sr_un
# hdr_sr_un:	.asciiz	"\n\nTrapezoid Areas (unsorted): \n"
	jal	printTrapAreas

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas1
	lw	$a1, len1
	jal	combSort

#  Dislpay sorted trap areas
	la	$a0, tAreas1
	lw	$a1, len1
	la	$a2, hdr_sr_so
# hdr_sr_so:	.asciiz	"\n\nTrapezoid Areas (sorted): \n"
	jal	printTrapAreas

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas1			# arg 1
	lw	$a1, len1			# arg 2
	la	$a2, fSum1			# arg 3
	la	$a3, fAve1			# arg 4

	subu	$sp, $sp, 12
	la	$t0, min1
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med1
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max1
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas1			# arg 1
	lw	$a1, len1			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum1			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve1
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min1
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med1
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max1
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed1
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #2

	move	$a0, $s0
	lw	$a1, len2
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides2
	la	$a1, cSides2
	la	$a2, heights2
	lw	$a3, len2
	la	$t0, tAreas2
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas2
	lw	$a1, len2
	jal	estMedian

	sw	$v0, estMed2

#  Dislpay unsorted trap areas

	la	$a0, tAreas2
	lw	$a1, len2
	la	$a2, hdr_sr_un
	jal	printTrapAreas

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas2
	lw	$a1, len2
	jal	combSort

#  Dislpay sorted trap areas
	la	$a0, tAreas2
	lw	$a1, len2
	la	$a2, hdr_sr_so
	jal	printTrapAreas

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas2			# arg 1
	lw	$a1, len2			# arg 2
	la	$a2, fSum2			# arg 3
	la	$a3, fAve2			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min2
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med2
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max2
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas2			# arg 1
	lw	$a1, len2			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum2			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve2
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min2
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med2
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max2
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed2
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #3

	move	$a0, $s0
	lw	$a1, len3
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides3
	la	$a1, cSides3
	la	$a2, heights3
	lw	$a3, len3
	la	$t0, tAreas3
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas3
	lw	$a1, len3
	jal	estMedian

	sw	$v0, estMed3

#  Dislpay unsorted trap areas

	la	$a0, tAreas3
	lw	$a1, len3
	la	$a2, hdr_sr_un
	jal	printTrapAreas

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas3
	lw	$a1, len3
	jal	combSort

#  Dislpay sorted trap areas
	la	$a0, tAreas3
	lw	$a1, len3
	la	$a2, hdr_sr_so
	jal	printTrapAreas

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas3			# arg 1
	lw	$a1, len3			# arg 2
	la	$a2, fSum3			# arg 3
	la	$a3, fAve3			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min3
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med3
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max3
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas3			# arg 1
	lw	$a1, len3			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum3			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve3
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min3
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med3
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max3
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed3
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #4

	move	$a0, $s0
	lw	$a1, len4
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides4
	la	$a1, cSides4
	la	$a2, heights4
	lw	$a3, len4
	la	$t0, tAreas4
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4


#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas4
	lw	$a1, len4
	jal	estMedian

	sw	$v0, estMed4

#  Dislpay unsorted trap areas

	la	$a0, tAreas4
	lw	$a1, len4
	la	$a2, hdr_sr_un
	jal	printTrapAreas

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas4
	lw	$a1, len4
	jal	combSort

#  Dislpay sorted trap areas
	la	$a0, tAreas4
	lw	$a1, len4
	la	$a2, hdr_sr_so
	jal	printTrapAreas

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas4			# arg 1
	lw	$a1, len4			# arg 2
	la	$a2, fSum4			# arg 3
	la	$a3, fAve4			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min4
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med4
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max4
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas4			# arg 1
	lw	$a1, len4			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum4			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve4
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min4
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med4
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max4
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed4
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #5

	move	$a0, $s0
	lw	$a1, len5
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides5
	la	$a1, cSides5
	la	$a2, heights5
	lw	$a3, len5
	la	$t0, tAreas5
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas5
	lw	$a1, len5
	jal	estMedian
	sw	$v0, estMed5

#  Dislpay unsorted trap areas

	la	$a0, tAreas5
	lw	$a1, len5
	la	$a2, hdr_sr_un
	jal	printTrapAreas

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas5
	lw	$a1, len5
	jal	combSort

#  Dislpay sorted trap areas
	la	$a0, tAreas5
	lw	$a1, len5
	la	$a2, hdr_sr_so
	jal	printTrapAreas

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas5			# arg 1
	lw	$a1, len5			# arg 2
	la	$a2, fSum5			# arg 3
	la	$a3, fAve5			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min5
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med5
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max5
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas5			# arg 1
	lw	$a1, len5			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum5			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve5
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min5
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med5
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max5
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed5
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall					# au revoir...
.end main

#####################################################################
#  Display headers.

.globl	prtHeaders
.ent	prtHeaders
prtHeaders:
	sub	$sp, $sp, 12
	sw	$s0, ($sp)
	sw	$s1, 4($sp)
	sw	$fp, 8($sp)
	addu	$fp, $sp, 12

	move	$s0, $a0
	move	$s1, $a1

	la	$a0, hdr_nm
#	Data Set #
	li	$v0, 4
	syscall

	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, hdr_ln
#	Length 
	li	$v0, 4
	syscall

	move	$a0, $s1
	li	$v0, 1
	syscall

	lw	$s0, ($sp)
	lw	$s1, 4($sp)
	lw	$fp, 8($fp)
	add	$sp, $sp, 12

	jr	$ra
.end	prtHeaders

#####################################################################
#  Find estimated median (first, last, and middle or middle two).

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	$v0, estimated median
#	Value returning function


# The HLL call is as follows:
# ans = estMedian(tAreas, len)
# tAreas passed as address (la)
# len passed as value (lw)
#	la	$a0, tAreas5
#	lw	$a1, len5
#	jal	estMedian
#	sw	$v0, estMed5

.globl estMedian
.ent estMedian
estMedian:
# PUSH ALL PRESERVED REGISTERS 
	subu $sp, $sp, 20
	sw $s0, ($sp) 
	sw $s1, 4($sp) 
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	addu $fp, $sp, 20 

	move $s0, $a0	# starting address of the list
	move $s1, $a1	# list length
# # # # # # # # # # #	
	li $s2, 2
	li $s3, 3
	li $s4, 4
# # # # # # # # # # #	
#	First Value
	lw $t0, ($s0) 
#	Last Value 
	sub $t2, $s1, 1
#	Length - 1
	mul $t3, $t2, $s4
	add $t3, $t3, $s0 
	lw $t4, ($t3)
# # # # # # # # # # # # # # #
# Check remainder odd or even length 
	rem $t5, $s1, 2
	bnez $t5, oddCase

# EVEN CASE: summing the first, last, and
# middle value and then dividing by 4
evenCase: 
	div $t5, $s1, $s2       
	sub $t6, $t5, 1      
	mul $t7, $t6, $s4       
	add $t7, $t7, $s0     
	lw $t8, ($t7)   

	add $t7, $t7, 4       
	lw $t9, ($t7)        

	add $v0, $t0, $t4     
	add $v0, $v0, $t8     
	add $v0, $v0, $t9     
	div $v0, $v0, $s4  

	lw $s0, ($sp)        
    lw $s1, 4($sp)
	lw $s2, 8($sp)       
    lw $s3, 12($sp)    
    lw $s4, 16($sp)        
    addu $sp, $sp, 20   
	jr $ra 

# ODD CASE: sum the first, last, and two
# middle values and then dividing by 3
oddCase: 
	div $t5, $s1, $s2
	mul $t6, $t5, $s4
	add $t7, $t6, $s0
	lw $t8, ($t7)

	add $v0, $t0, $t4
	add $v0, $v0, $t8
	div $v0, $v0, $s3

	lw $s0, ($sp)        
    lw $s1, 4($sp)
	lw $s2, 8($sp)       
    lw $s3, 12($sp)    
    lw $s4, 16($sp)        
    addu $sp, $sp, 20   
    jr $ra    
.end estMedian 
# est med = 3949

#####################################################################
#  Find trapezoid araes, tAreas[]

#    Arguments:
#	$a0   - starting address of the aSides array
#	$a1   - starting address of the cSides array
#	$a2   - starting address of the heights array
#	$a3   - length
# The first 4 args are passed in $a0-$a3.

#	($fp) - starting address of the tAreas array
# The ($fp) is used to point to the procedure call frame on the stack.
# Next arg is passed on the stack.  

#    Returns:
#	tAreas areas array via passed address

# The HLL call is as follows:
# trapAreas(aSides, cSides, heights, len, tAreas)
# arrays = passed as reference
# length = passed as value 

# Main program calls the trapAreas routine 
# la $a0, aSides1 # address of array 
# la $a1, cSides1 # address of array 
# la $a2, heights1 # address of array 
# lw $a3, len1	# value of length
# la $t0, tAreas1
# sub $sp, $sp, 4 
# sw $t0, ($sp)
# jal trapAreas
# add $sp, $sp, 4 

.globl trapAreas
.ent trapAreas
trapAreas:
    subu $sp, $sp, 24    
    sw $s0, ($sp)         # aSides
    sw $s1, 4($sp)         # cSides
    sw $s2, 8($sp)         # heights
    sw $s3, 12($sp)        # length
    sw $fp, 16($sp)        # $fp
    sw $ra, 20($sp)        
    addu $fp, $sp, 24

    move $s0, $a0 # address of aSides 
    move $s1, $a1 # address of cSides
    move $s2, $a2 # address of heights
    move $t0, $a3 # length 

# trapAreas(aSides, cSides, heights, len, tAreas)
 
    lw $s5, ($fp) # load address of tAreas array
    li $t1, 0 # index 
    li $s4, 2
	li $t8, 4 

loop:
    lw $t2, ($s0)
    # get aSides array
    lw $t3, ($s1)
    # get cSides array
    lw $t4, ($s2)
    # get heights array

    # areas[i] = (aSides[i] + cSides[i] / 2 * heights[i])
	add $t5, $t2, $t3   # aSides + cSides
    div $t5, $t5, $s4     # div by 2      
    mul $t5, $t5, $t4	# mul heights 

    mul $t6, $t1, $t8   
    add $t6, $t6, $s5
    sw $t5, ($t6)    

    add $s0, $s0, 4  
    add $s1, $s1, 4  
    add $s2, $s2, 4  
    add $t1, $t1, 1  

    bne $t1, $t0, loop

    # Restore registers & return to calling routine 
    lw $s0, ($sp)         # aSides
    lw $s1, 4($sp)         # cSides
    lw $s2, 8($sp)         # heights
    lw $s3, 12($sp)        # length
    lw $fp, 16($sp)        # $fp
    lw $ra, 20($sp) 
    addu $sp, $sp, 24
    jr $ra 
.end trapAreas

#####################################################################
#  Sort a list of numbers using comb sort.
#  MUST use comb sort.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	sorted list (via passed address)

# The HLL call is as follows:
#	combSort(tAreas, len)
# la	$a0, tAreas1
# lw	$a1, len1
# jal	combSort

.globl combSort
.ent combSort
combSort:
# PUSH ALL PRESERVED REGISTERS 
	subu $sp, $sp, 20
	sw $s0, ($sp) 
	sw $s1, 4($sp) 
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	addu $fp, $sp, 20 

    move $s0, $a0  # starting address of the list
    move $s1, $a1  # list length

	la $s3, swapped
	la $s4, i

    # gap = length
    move $s2, $s1  # store gap = length
    
    # swapped = true
    li $t0, TRUE
	sb $t0, ($s3)

# outer loop while gap > 1 OR swapped = true
outerLoop:
	move $t1, $s2 
    li $t2, 1
    bgt $t1, $t2, outerLoopOk  # if gap > 1

    lb $t3, ($s3)
    li $t4, TRUE
    bne $t3, $t4, outerLoopDone 

outerLoopOk:
    # gap = (gap * 10) / 12
	move $t5, $s2 
	li $t6, 10
    mul $t7, $t5, $t6  # mul by 10
	li $t6, 12
    div $t7, $t7, $t6  # div by 12
    move $s2, $t7

    # if gap < 1
	li $t8, 1
    blt $t7, $t8, gapAgain
    # end if
    j outerLoopContinued

gapAgain:
    # gap = 1
    li $s2, 1

outerLoopContinued:
    # i = 0
    sw $zero, ($s4)

    # swapped = false
	li $t9, FALSE 
    sb $t9, ($s3)

# inner loop until i + gap >= length
innerLoop:
    li $t8, 4
	# ($s4) == i
	lw $t0, ($s4) # $t0 == i
 # # # # # # # # # # 
 	add $t2, $t0, $s2  # i + gap 
	bge $t2, $s1, innerLoopDone
 # # # # # # # # # # 
    # array[i]
    mul $t3, $t0, $t8
    add $t3, $t3, $s0
    lw $t4, ($t3)

    # array[i+gap]
    mul $t5, $t2, $t8
    add $t5, $t5, $s0
    lw $t6, ($t5)

	# # if array[i] > array[i+gap]
    bgt $t4, $t6, doSwap
    # end if
    ble $t4, $t6, dontSwap

doSwap:
    # swap (array[i], array[i+gap])
    sw $t6, ($t3)
    sw $t4, ($t5)

    # swapped = true
    li $t7, TRUE
    sb $t7, ($s3)

    # end if i = i + 1
dontSwap:
	lw $t1, ($s4) 
    add $t1, $t1, 1
    sw $t1, ($s4)
    j innerLoop

innerLoopDone:
    j outerLoop

outerLoopDone:
	lw $s0, ($sp)        
    lw $s1, 4($sp)
	lw $s2, 8($sp)       
    lw $s3, 12($sp)    
    lw $s4, 16($sp)        
    addu $sp, $sp, 20 
    jr $ra
.end combSort

#####################################################################
#  MIPS assembly language function, trapStats(), that will
#    find the sum, average, minimum, maximum, and median of the list.
#    The average is returned as floating point value.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length
#	$a2 - addr of fSum
#	$a3 - addr of fAve
#	($fp) - addr of min
#	4($fp) - addr of med
#	8($fp) - addr of max

#    Returns (via addresses):
#	fSum
#	fAve
#	min
#	max
#	med

# The HLL call is as follow:
#	trapStats(tAreas, len, fSum, fAve, min, med, max)
#	la	$a0, tAreas4			# arg 1
#	lw	$a1, len4			# arg 2
#	la	$a2, fSum4			# arg 3
#	la	$a3, fAve4			# arg 4
#	subu	$sp, $sp, 12
#	la	$t0, min4
#	sw	$t0, ($sp)			# arg 5, on stack
#	la	$t0, med4
#	sw	$t0, 4($sp)			# arg 6, on stack
#	la	$t0, max4
#	sw	$t0, 8($sp)			# arg 7, on stack
#	jal	trapStats
#	addu	$sp, $sp, 12			# clear stack


.globl trapStats
.ent trapStats
trapStats:
	subu $sp, $sp, 32
    sw $s0, ($sp)	#	$a0 - starting address of the list
    sw $s1, 4($sp)	#	$a1 - list length
    sw $s2, 8($sp)	#	$a2 - addr of fSum
    sw $s3, 12($sp)	#	$a3 - addr of fAve
    sw $s4, 16($sp)	#	($fp) - addr of min
    sw $s5, 20($sp)	#	4($fp) - addr of med
    sw $fp, 24($sp)	#	8($fp) - addr of max
    sw $ra, 28($sp)
    addu $fp, $sp , 32

	move $s0, $a0 #	$a0 - starting address of the list
    move $s1, $a1 #	$a1 - list length
    move $s2, $a2 #	$a2 - addr of fSum
    move $s3, $a3 #	$a3 - addr of fAve

	lw $s4, ($fp)	#	($fp) - addr of min
    lw $s5, 4($fp)	#	4($fp) - addr of med
    lw $s6, 8($fp)	#	8($fp) - addr of max

	# sorted min = 3600
	# sorted max = 4524
# # # # # # # # # # # # 
	lw $t0, ($s0)
	# deference starting address 
	sw $t0, ($s4)
	# saves deference ($fp)
# # # # # # # # # 
	sub $t1, $s1, 1 
	# length - 1
	mul $t2, $t1, 4
	add $t2, $t2, $s0 
	lw $t3, ($t2)
	sw $t3, ($s6)
	# saves deference 8($fp)
# # # # # # # # # 

	# length : 15 (odd)
	# sorted med = 3888
	div $t5, $s1, 2     
	# length / 2
	rem $t6, $s1, 2    
	
	mul $t7, $t5, 4
	add $t7, $t7, $s0
	lw $t8, ($t7)

	beqz $t6, EvenLen  
	# check if rem = 0 means even length 
	sw $t8, ($s5)  
	# median odd length 
	j end 

	EvenLen:
	div $t5, $s1, 2     
	# length / 2
	sub $t5, $t5, 1   
	# index first middle element
# # # # # # # #
	mul $t7, $t5, 4
	add $t7, $t7, $s0
	lw $t8, ($t7)       #
	# first middle element
# # # # # # # #
	add $t5, $t5, 1    
	# index second middle element
	mul $t9, $t5, 4
	add $t9, $t9, $s0
	lw $t0, ($t9)       
	# second middle element
# # # # # # # #
	add $t8, $t8, $t0  
	div $t8, $t8, 2    
	sw $t8, ($s5)       
	end:

	# sorted sum = 60152.00000000
   	#	$s1 (length)
    #	$s2 (fSum)
    #	$s3 (fAve)
	
	li $t9, 0   
	# sum      
	li $t4, 0 
	# counter         
	move $t6, $s0 
	# move $s0 (array) into $t6     

	sumLoop:
    lw $t0, ($t6)  
	# current element     
    add $t9, $t9, $t0	
	# current element + sum
# # # # # # # # # # 
    add $t6, $t6, 4     
    add $t4, $t4, 1     
    bne $t4, $s1, sumLoop    
	# if counter is not equal to length, continue 

	mtc1 $t9, $f6       
	# move $t9 (sum) into $f6 (sum)
	cvt.s.w $f8, $f6    
	# convert to float: $f6 to $f8 (sum)
	s.s $f8, ($s2)    

	mtc1 $s1, $f0
	# move $s1 (length) into $f1 
	cvt.s.w $f1, $f0    
	# convert length: $f0 to $f1 (length)
	div.s $f2, $f8, $f1 
	s.s $f2, 0($s3)  

#	POP REGISTERS 
    lw $s0, ($sp)	
    lw $s1, 4($sp)	
    lw $s2, 8($sp)	
    lw $s3, 12($sp)	
    lw $s4, 16($sp)
    lw $s5, 20($sp)
    lw $fp, 24($sp)	
    lw $ra, 28($sp)
    addu $fp, $sp, 32  
    jr $ra
.end trapStats

#####################################################################
#  MIPS assembly language function, showTrapStats(), to display
#    the tAreas and the statistical information:
#	sum (float), average (float), minimum, median, maximum,
#	estimated median in the presribed format.
#    The numbers should be printed four (4) per line (see example).

#  Note, due to the system calls, the saved registers must
#        be used.  As such, push/pop saved registers altered.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length
#	($fp) - sum (float)
#	4($fp) - average (float)
#	8($fp) - min
#	12($fp) - med
#	16($fp) - max
#	20($fp) - est median

#    Returns:
#	N/A

# The HLL call is as follows:
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)
#	la $a0, tAreas
#	lw $a1, len
#	subu $sp, $sp, 24
#	l.s $f6, fSum	#float
#	s.s $f6, ($sp)	
#	l.s $f6, fAve	#float
#	s.s $f6, 4($sp)
#	lw	$t0, min
#	sw $t0, 8($sp)
#	lw $t0, med
#	sw $t0, 12($sp)
#	lw $t0, max
#	sw $t0, 16($sp)
#	lw $t0, estMed
#	sw $t0, 20 ($sp)
#	jal showTrapStats
#	addu $sp, $sp, 24 

.globl showTrapStats
.ent showTrapStats
showTrapStats:
	subu $sp, $sp, 48
	sw $s0, ($sp) #	$a0 - starting address of the list
	sw $s1, 4($sp)	#	$a1 - list length
# # # # # # # # # # # #
	sw $s2, 8($sp) #	($fp) - sum (float)
	sw $s3, 12($sp) #	4($fp) - average (float)
# # # # # # # # # # # #
	sw $s4, 16($sp) #	8($fp) - min
	sw $s5, 20($sp) #	12($fp) - med
	sw $s6, 24($sp) #	16($fp) - max
	sw $s7, 28($sp) #	20($fp) - est median
	sw $fp, 32($sp)
	sw $ra, 36($sp)
	addu $fp, $sp, 48

	move $s0, $a0       
	# starting address 
	move $s1, $a1       
	# length
	lw $s2, 8($fp) 
	#	8($fp) - min     
	lw $s3, 12($fp)  
	#	12($fp) - med  
	lw $s4, 16($fp) 
	#	16($fp) - max    
	lw $s5, 20($fp) 
	#	20($fp) - est median

	l.s $f0, ($fp) 
# ($fp) - sum (float)  
	l.s $f1, 4($fp)
#	4($fp) - average (float)  

# # # # # # # # ## # # # # # # # # # # # #

#	Print newline
	li $v0 , 4
	la $a0, newLine
	syscall

#	Print sum header
	li $v0, 4
	la $a0, str1
	syscall

#	Print sum value (FLOAT)
	li $v0, 2 # call code for float 
	mov.s $f12, $f0
	syscall

#	Print ave header
	li $v0, 4
	la $a0, str2
	syscall

#	Print ave value (FLOAT)
	li $v0, 2 # call code for float 
	mov.s $f12, $f1
	syscall

#	Print min header
	li $v0, 4
	la $a0, str3
	syscall

#	Print min value
    li $v0, 1        # Print integer syscall
	move $a0, $s2
    syscall
   
#	Print med header
	li $v0, 4
	la $a0, str4
	syscall

#	Print med value
    li $v0, 1        # Print integer syscall
	move $a0, $s3
    syscall

#	Print max header
	li $v0, 4
	la $a0, str5
	syscall

#	Print max value
    li $v0, 1        # Print integer syscall
	move $a0, $s4
    syscall

#	Print est med header
	li $v0, 4
	la $a0, str6
	syscall

#	Print est med value
    li $v0, 1        # Print integer syscall
	move $a0, $s5
    syscall

#	Print pct diff header 
	la $a0, str7
	li $v0, 4
	syscall


#	Calc. pct diff value 
#	estmed + median / median 
#	pct diff = 2.01568937 (float)

#	estMed
	mtc1 $s5, $f1           
	# move estMed to $f1
	cvt.s.w $f1, $f1        
	# estMed: $f1 

#	med 
	mtc1 $s3, $f3           
	# move med to $f2 
	cvt.s.w $f3, $f3      
	# med: $f3 

	add.s $f5, $f1, $f3     
	div.s $f6, $f5, $f3    

#	Print pct diff value 
	li $v0, 2
	mov.s $f12, $f6
	syscall

#	Newline
	li $v0, 4         
	la $a0, new_ln
	syscall

# # # # # # # # # # # # # # # # # # # #
    
	lw $s0, ($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $fp, 32($sp)
	lw $ra, 36($sp)
	addu $sp, $sp, 48 
	jr $ra
.end showTrapStats

#####################################################################
#  MIPS assembly language void function, printTrapAreas(), to display
#    the tAreas array.
#    The numbers should be printed 7 per line (see example).

#  Note, due to the system calls, the saved registers must
#        be used.  As such, push/pop saved registers altered.

# -----
# Arguments: 
#	$a0   - Starting address of array
#	$a1   - Array length 
#	$a2   - Starting address of the heights array

.globl printTrapAreas
.ent printTrapAreas
printTrapAreas:
    subu $sp, $sp, 24  
    sw $s0, ($sp)    
    sw $s1, 4($sp)    
    sw $s2, 8($sp)    
    sw $s3, 12($sp)   
    sw $fp, 16($sp)   
    sw $ra, 20($sp)   
    addu $fp, $sp, 24 

    move $s0, $a0     
    # Starting address of array
    move $s1, $a1     
    # Array length
    move $s3, $a2    
    # Starting address of the header

    li $v0, 4         
    # Print header
    move $a0, $s3
    syscall

    li $t0, 0         
    # Counter
    li $t1, 7         

printloop:
    beq $t0, $s1, done

	li $v0, 4  
    # Print blnks        
    la $a0, blnksfive
    syscall

    mul $t2, $t0, 4   
    add $t2, $s0, $t2 
    lw $a0, ($t2)     

    li $v0, 1
    # call code for print int         
    syscall

    addu $t0, $t0, 1  
    # Increment counter
    rem $t3, $t0, $t1 
    bnez $t3, printloop 

    li $v0, 4         
    la $a0, newLine
    syscall

    j printloop

done:
    lw $ra, 20($sp)   
    lw $fp, 16($sp)   
    lw $s3, 12($sp)   
    lw $s2, 8($sp)    
    lw $s1, 4($sp)    
    lw $s0, ($sp)    
    addu $sp, $sp, 24 
    jr $ra             

.end printTrapAreas

#####################################################################