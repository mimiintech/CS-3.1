; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Seven  
;  Description: Write a simple assembly language program to sort a list of numbers. Learn to use
; addressing modes, arithmetic operations, and control instructions
;
; =====================================================================
;  Macro to convert integer to nonary value in ASCII format.
;  Reads <integer>, converts to ASCII/nonary string including
;	NULL into <string>

;  Note, the macro is calling using RSI, so the macro itself should
;	 NOT use the RSI register until is saved elsewhere.

;  Arguments:
;	%1 -> <integer-variable>, value
;	%2 -> <string-address>, string address
;	%3 -> <string-length-value>, string length

;  Macro usgae
;	int2aNonary	<integer-variable>, <string-address>, <string-length>

;  Example usage:
;	int2aNonary	dword [volumes+rsi*4], tempString, STR_LENGTH


;	YOUR CODE GOES HERE
;	Note:  UPDATE ALGORITHM TO ADD "-" for values <0

%macro int2aNonary 3
	mov eax, 0
	mov eax, %1 ; integer value
	mov rsi, 0

	mov rdi, %2 + (%3) ;string address + string length
    dec rdi
	mov byte [rdi], 0  

	; to check for negative values 
	cmp eax, 0
	jge %%notNegative
	mov ebx, 0
	sub ebx, eax 
	mov eax, ebx

%%notNegative: 
    %%repeat:
       mov edx, 0   
       mov ecx, 9       
       div ecx       
	   add dl, '0'   ;convert to numeric    
	   dec rdi         
	   mov [rdi], dl    
	   cmp eax, 0  
       jne %%repeat 
	   cmp %1, 0
	   jl %%addNegative
	   jmp %%rightJustify
	
	%%addNegative
	dec rdi 
	mov byte [rdi], '-'

    %%rightJustify:
        cmp rdi, %2   ;string length  
        je %%done  
		dec rdi
		mov byte[rdi], ' '
		jmp %%rightJustify
    %%done:
%endmacro
; =====================================================================
;  Simple macro to display a string to the console.
;	Call:	printString  <stringAddr>

;	Arguments:
;		%1 -> <stringAddr>, string address

;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

%macro	printString	1
	push	rax			; save altered registers
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	mov	rdx, 0
	mov	rdi, %1
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	mov	rsi, %1			; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; =====================================================================

section	.data

; -----
;  Define constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; system call code for read
SYS_write	equ	1			; system call code for write
SYS_open	equ	2			; system call code for file open
SYS_close	equ	3			; system call code for file close
SYS_fork	equ	57			; system call code for fork
SYS_exit	equ	60			; system call code for terminate
SYS_creat	equ	85			; system call code for file open/create
SYS_time	equ	201			; system call code for get time

LF		equ	10
NULL		equ	0
ESC		equ	27

;  Program specfic constants

MAX_STR_LENGTH	equ	15

; -----
;  Provided data

array		dd	  147,  1123,  2245,  4440,   165
		dd	  -69,  -126,   571,   147,  -228
		dd	   27,    90,   177,   -75,    14
		dd	  181,   -25,    15,   -22,  1217
		dd	 -127,    64,   140,   172,    24
		dd	 2161,  -134,   151,   -32,   -12
		dd	 1113,  1232,  2146,  3376,  5120
		dd	 2356,  3164, 34565,  -3155, 23157
		dd	 1001,   128,   -33,   105,  8327
		dd	 -101,   115,   108,  1233,  2115
		dd	 1227,  1226,  5129,   117,  -107
		dd	  105,  -109,   730,   150,  3414
		dd	 1107,  6103, -1245,  6440,   465
		dd	-2311,   254,  4528,   913, -6722
		dd	 1149,  2126,  5671, -4647,  4628
		dd	 -327,  2390,   177,  8275,  5614
		dd	 3121,   415,   615,    22,  7217
		dd	 1221,    34, -6151,  -432,  -114
		dd	 -629,   114,   522,  2413,  -131
		dd	 5639,  -126,   -62,   -41,   127
		dd	 2101,   133,   133,    50,  4532
		dd	 1219,  3116,   -62,   -17,   127
		dd	 6787,  4569,    79,  5675,   -14
		dd	 7881,  8320,  3467,  4559,  1190
		dd	 -186,   134, -1125,  5675,  3476
		dd	 2137,  2113,  1647,   114,    15
		dd	 6571,  7624,   128,  -113, -3112
		dd	 1121,   320,  4540,  5679,  1190
		dd	 9125,  -116,  -192,   117,  -127
		dd	 5677,   101,  3727,  -125,  3184
		dd	-1104,   124,  -112,   143,   176
		dd	 7534, -2126,  6112,  -156,  1103
		dd	 6759,  6326,  2171,   147,  5628
		dd	 7527,  7569, -3177,  6785, -3514
		dd	-1156,  -164,  4165,  -155,  5156
		dd	 5634,  7526,  3413,  7686,  7563
		dd	 2147,  -113,  -143,   140,  -165
		dd	 5721,  5615,  4568,  7813,  1231
		dd	-5527,  6364,  -330,  -172,   -24
		dd	 7525,  5616,  5662,  6328,  2342

length		dd	200

minimum		dd	0
median		dd	0
maximum		dd	0
sum			dd	0
average		dd	0

; -----
;  Misc. data definitions (if any).
swapped		db 0	;FALSE
i			dd 0
gap			dd 0 
m10 		dd 10
d12			dd 12	
; -----
;  Provided string definitions.

newLine		db	LF, NULL

hdr		db	LF, "---------------------------"
		db	"---------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #7", ESC, "[0m"
		db	LF, "Comb Sort", LF, LF, NULL

hdrMin		db	"Minimum:  ", NULL
hdrMax		db	"Maximum:  ", NULL
hdrMed		db	"Median:   ", NULL
hdrSum		db	"Sum:      ", NULL
hdrAve		db	"Average:  ", NULL

; ---------------------------------------------

section .bss

tempString	resb	MAX_STR_LENGTH

; ---------------------------------------------

section	.text
global	_start
_start:
; ******************************
; COMBSORT
; void function combSort(array, length)
; 	SIGNED jl, jle, jg, jge, jne je 
; gap = length
mov eax, dword [length]
mov dword [gap], eax 
; swapped = true
mov byte [swapped], TRUE 

; outer loop while gap > 1 OR swapped = true
outerLoop:
cmp dword [gap], 1
jg outerLoopOk

cmp byte [swapped], TRUE 
jne outerLoopDone

outerLoopOk:
; gap = (gap * 10) / 12
mov eax, dword [gap]
imul eax, dword [m10]
mov edx, 0 ;clears edx
cdq ;sign extend
mov ecx, dword [d12]
idiv ecx
mov dword [gap], eax 

; if gap < 1
cmp eax, 1
jl gapAgain
; end if 
jmp outerLoopContinued 

gapAgain:
; gap = 1
	mov dword [gap], 1

outerLoopContinued:
; end if i = 0
mov dword [i], 0
; swapped = false
mov byte [swapped], FALSE

;inner loop until i + gap >= length
innerLoop:
	mov rsi, 0
	mov esi, dword [i] ;index 
;********************************
	mov rdi, 0
	mov edi, dword [gap] ;gap
	add edi, esi ;i + gap
;********************************
	cmp edi, dword [length]
	jge innerLoopDone
;********************************
	mov eax, dword [array + rsi * 4] ;array[i]
	mov ebx, dword [array + rdi * 4] ;array[i+gap]
; The indices have to be quads 64-bits
;*************************************
;if array[i] > array[i+gap]
	cmp eax, ebx
; end if 
	jle dontSwap
; swap (array[i], array[i+gap])
	mov dword [array + rsi * 4], ebx
	mov dword [array + rdi * 4], eax 
; swapped = true
	mov byte [swapped], TRUE 
; end if i = i + 1
	dontSwap:
	inc dword [i]
jmp innerLoop
	innerLoopDone:
jmp outerLoop
outerLoopDone: 

; ******************************
;minimum: -6722
;maximum: 34565
;median:  440
;sum:     414082
;average: 2070
; 	SIGNED jl, jle, jg, jge, jne je 
mov ecx, dword [length]	;length counter
mov rsi, 0				;index

mov eax, dword [array]
mov dword [minimum], eax
mov dword [maximum], eax
mov dword [sum], 0

statsLoop:
mov eax, dword [array + rsi * 4]
add dword [sum], eax

cmp eax, dword [minimum]
jge notNewLaMin

mov dword [minimum], eax  

notNewLaMin:
cmp eax, dword [maximum]
jle notNewLaMax

mov dword [maximum], eax

notNewLaMax:
inc rsi 
loop statsLoop

; Calculate the average
mov eax, dword [sum]
cdq ;sign extend 
idiv dword [length]
mov dword [average], eax 

;FIND THE STATISTICAL MEDIAN
; For an even number of values, 
; it is the integer average of the two middle values
mov eax, dword [array + 99 * 4]
mov ebx, dword [array + 100 * 4]

add eax, ebx
cdq	;sign extend
mov ecx, 2	;to divide by 2
idiv ecx 
mov dword [median], eax  
; ******************************
;  Display results to screen in duodecimal.

	printString	hdr

	printString	hdrMin
	int2aNonary	dword [minimum], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrMax
	int2aNonary	dword [maximum], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrMed
	int2aNonary	dword [median], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrSum
	int2aNonary	dword [sum], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrAve
	int2aNonary	dword [average], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine
	printString	newLine


; ******************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

