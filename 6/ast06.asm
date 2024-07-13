; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Six  
;  Description: Become familiar with data conversion, 
; addressing modes, and assembly language macro's.
;

;Convert ASCII string to integers & from integers to ASCII strings
; -----

; =====================================================================
;  STEP #2
;  Macro to convert ASCII/nonary value into an integer.
;  Reads <string>, convert to integer and place in <integer>
;  Assumes valid data, no error checking is performed.

;  Arguments:
;	%1 -> <string>, register -> string address
;	%2 -> <integer>, register -> result

;  Macro usgae
;	anonary2int  <string-address>, <integer-variable>

;  Example usage:
;	anonary2int	rbx, tmpInteger

;  For example, to get address into a local register:
;		mov	rsi, %1

;  To return a value, it might be:
;		mov	dword [%2], eax

;  Note, the register used for the macro call (rbx in this example)
;  must not be altered BEFORE the address is copied into
;  another register (if desired).

%macro aNonary2int 2
; PUSH EVERY REGISTER
	push rax
	push rsi
	push rbx
	push rcx
	push r8


    mov rax, 0              ; running sum = 0
    mov rsi, %1               ; String address into rsi
    mov rbx, 0              ; Used as index

%%skipSpaces:
    movzx rcx, byte [rsi + rbx] 
    cmp rcx, ' '              ; If char is space
    je %%foundSpace          ; JMP to space 
    jmp %%convertDigit        ; Continues to conversion

%%foundSpace:
    inc rbx                 
    jmp %%skipSpaces          

%%convertDigit:
    movzx rcx, byte [rsi + rbx] 
    cmp rcx, '0'
    jb %%conversionDone       ;If below, done

    cmp rcx, '8'
    ja %%conversionDone       ; If above '8', stop conversion

    sub rcx, '0'   

	; base (9)
	mov r8, 9
	mul r8
    add rax, rcx                     

    inc rbx                   
    jmp %%skipSpaces         

%%conversionDone
    mov dword [%2], eax  

; POP EVERY REGISTER
	pop r8
	pop rcx 
	pop rbx
	pop rsi
	pop rax          
%endmacro

; STEP #5
;  Macro to convert integer to nonary value in ASCII format.
;  Reads <integer>, converts to ASCII/nonary string including
;	NULL into <string>

;  Note, the macro is calling using RSI, so the macro itself should
;	 NOT use the RSI register until is saved elsewhere.

;  Arguments:
;	%1 -> <integer-variable>, value
;	%2 -> <string-address>, string address
;	%3 -> <string-length-value>, string length

; STEP #5
;  Macro to convert integer to nonary value in ASCII format.
;  Reads <integer>, converts to ASCII/nonary string including
;	NULL into <string>

;  Note, the macro is called using RSI, so the macro itself should
;	 NOT use the RSI register until it's saved elsewhere.

;  Arguments:
;	%1 -> <integer-variable>, value
;	%2 -> <string-address>, string address
;	%3 -> <string-length-value>, string length

%macro int2aNonary 3
	mov eax, 0
	mov eax, %1 ; integer value
	mov rsi, 0

	mov rdi, %2 + (%3) ;string address + string length
    dec rdi
	mov byte [rdi], 0    

    %%repeat:
       mov edx, 0   
       mov ecx, 9       
       div ecx         
        add dl, '0'   ;convert to numeric    
        dec rdi         
        mov [rdi], dl    
        cmp eax, 0  
       jne %%repeat 

    %%rightJustify:
        cmp rdi, %2   ;string length  
        je %%done  
		dec rdi
		mov byte[rdi], ' '
		jmp %%rightJustify
    %%done:
%endmacro

;====================================================================
;  Simple macro to display a string to the console.
;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

;  Macro usage:
;	printString  <stringAddr>

;  Arguments:
;	%1 -> <stringAddr>, string address

%macro	printString	1
	push	rax			; save altered registers (cautionary)
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	lea	rdi, [%1]		; get address
	mov	rdx, 0			; character count
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	lea	rsi, [%1]		; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; =====================================================================
;  Initialized variables.

section	.data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
NOSUCCESS	equ	1			; unsuccessful operation

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
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

NUMS_PER_LINE	equ	5


; -----
;  Assignment #6 Provided Data

STR_LENGTH	equ	15			; chars in string, with NULL

edgeLengths	db	"            23", NULL, "            37", NULL
		db	"            45", NULL, "            61", NULL
		db	"            55", NULL, "            78", NULL
		db	"           123", NULL, "           137", NULL
		db	"           144", NULL, "           151", NULL
		db	"           180", NULL, "           217", NULL
		db	"           234", NULL, "           240", NULL
		db	"           267", NULL, "           281", NULL
		db	"           302", NULL, "           322", NULL
		db	"           312", NULL, "           327", NULL
		db	"           342", NULL, "           362", NULL
		db	"           372", NULL, "           381", NULL
		db	"           400", NULL, "           411", NULL
		db	"           427", NULL, "           431", NULL
		db	"           445", NULL, "           450", NULL
		db	"           462", NULL, "           477", NULL
		db	"           512", NULL, "           523", NULL
		db	"           532", NULL, "           548", NULL
		db	"           615", NULL, "           627", NULL
		db	"           632", NULL, "           648", NULL
		db	"           652", NULL, "           678", NULL
		db	"           711", NULL, "           728", NULL
		db	"           737", NULL, "           748", NULL
		db	"           777", NULL, "           827", NULL
		db	"           850", NULL, "           888", NULL

aNonaryLength	db	"            55", NULL
length		dd	0

cubeSum		dd	0
cubeAve		dd	0
cubeMin		dd	0
cubeMax		dd	0


; -----
;  Misc. variables for main.

hdr		db	"-----------------------------------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #6", ESC, "[0m", LF
		db	"Cube Calculations", LF, LF
		db	"Cube Volumes:", LF, NULL
shdr		db	LF, "Cube Sum:  ", NULL
avhdr		db	LF, "Cube Ave:  ", NULL
minhdr		db	LF, "Cube Min:  ", NULL
maxhdr		db	LF, "Cube Max:  ", NULL

newLine		db	LF, NULL
spaces		db	"   ", NULL

; =====================================================================
;  Uninitialized variables

section	.bss

tmpInteger	resd	1				; temporary value

volumes		resd	50
edgeLenInts	resd	50

lenString	resb	STR_LENGTH
tempString	resb	STR_LENGTH			; bytes

cubeSumString	resb	STR_LENGTH
cubeAveString	resb	STR_LENGTH
cubeMinString	resb	STR_LENGTH
cubeMaxString	resb	STR_LENGTH


; **************************************************************

section	.text
global	_start
_start:

; -----
;  Display assignment initial headers.

	printString	hdr

; -----
;  STEP #1
;	Convert integer length, in ASCII/nonary format to integer.
;	Do not use macro here...
;	Read string aNonaryLength, convert to integer, and store in length
;	YOUR CODE GOES HERE

; aNonLength db (8)
; length dd (32)
calcLoop:
; running sum = 0
mov eax, 0  
; get address of string
mov r8, aNonaryLength
mov r9, 0

skipSpaces:
; byte to dword unsigned widening
movzx ecx, byte [r8 + r9]
cmp ecx, ' '
je spaceFound

jmp nextChr

spaceFound:
inc r9
jmp skipSpaces

; To process each character 
; 1-8 (10,11,12,13,14,15)
nextChr:
; byte to dword unsigned widening
movzx ecx, byte [r8 + r9]
cmp ecx, '0' ;To check if char is less than 0
jb chrDone ;If below, done 

cmp ecx, '8' ;To check if the char is greater than 8
ja chrDone ;If above 8, done

; Converts to numeric value (0-8)
sub ecx, '0' ;53-48=5 53-48=5

; base(9)
mov r11d, 9
; eax * base(9)
mul r11d ; 5 * 9^0 = 5 5 * 9^1 = 45
; adds current char to the total 
add eax, ecx ; 5 + 45 = 50

inc r9
jmp nextChr

chrDone:
mov [length], eax ; eax = 50
; stores the final in eax
; length: 50

; -----
;  Convert radii from ASCII/nonary format to integer.
;  STEP #2 must complete before this code.

	mov	ecx, dword [length] ;number of items to process
	mov	rdi, 0					; index for array
	mov	rbx, edgeLengths		;starting address
cvtLoop:
	push	rbx					; safety push's
	push	rcx
	push	rdi
; stored into tmpInteger
	aNonary2int	rbx, tmpInteger
	pop	rdi
	pop	rcx
	pop	rbx
; loaded converted edge length into eax
	mov	eax, dword [tmpInteger]
	mov	dword [edgeLenInts+rdi*4], eax		; save for reference

	; YOUR CODE -> Calculate volume and store in volumes array
	; volumes [ i] = edge [i ]^3
	mov eax, dword [edgeLenInts+rdi*4] ;Length into eax
	mov ecx, eax        ;moved edge length into ecx           
	mul ecx         ; eax * ecx (edge^2)              
	mov ecx, eax         ;(edge^2 to ecx)        
	mov eax, dword [edgeLenInts+rdi*4]  
	mul ecx        ; edge length by edge^2              
	mov dword [volumes+rdi*4], eax     

	add	rbx, STR_LENGTH
	inc	rdi
	dec	ecx
	cmp	ecx, 0
	jg	cvtLoop

; -----
;  Display each the volumes array (five per line).

	mov	ecx, dword [length]
	mov	rsi, 0
	mov	r12, 0
printLoop:
	push	rcx					; safety push's
	push	rsi
	push	r12

	int2aNonary	dword [volumes+rsi*4], tempString, STR_LENGTH
	printString	tempString
	printString	spaces

	pop	r12
	pop	rsi
	pop	rcx

	inc	r12
	cmp	r12, 3
	jne	skipNewline
	mov	r12, 0
	printString	newLine
skipNewline:
	inc	rsi

	dec	ecx
	cmp	ecx, 0
	jne	printLoop
	printString	newLine

; -----
;  STEP #3
;	Find volumes array stats (sum, min, max, and average).
;	Reads data from volumes array (set above).
; FIND MIN, MAX, SUM, & AVE FROM VOLUMES ARRAY
mov ecx, dword [length]
mov ebx, 0

mov eax, dword [volumes]
mov dword [cubeMin], eax
mov dword [cubeMax], eax
mov dword [cubeSum], 0

statsOne:
mov eax, dword [volumes+ebx*4]
add dword [cubeSum], eax
cmp eax, dword [cubeMin]
jae notMin
mov dword [cubeMin], eax
notMin:
cmp eax, dword [cubeMax]
jbe notMax 
mov dword [cubeMax], eax
notMax:
inc ebx
loop statsOne 

mov eax, dword [cubeSum]
mov edx, 0
div dword [length]
mov dword [cubeAve], eax 
; -----
;  STEP #4
;	Convert sum to ASCII/nonary for printing.
;	Do not use macro here...

	printString	shdr				; display header

;	Read volumes sum inetger (set above), convert to
;		ASCII/nonary and store in cubeSumString.
;	The ASCII version of the number should be STR_LENGTH
;		(globally available constant) characters (including the NULL),
;		right justified with the appropriate number of leading blanks.
; cubeSumString:    11112461667
;cubeAveString:      173576135
;cubeMinString:          13630
;cubeMaxString:      886002888

mov eax, dword [cubeSum]
mov rdi, cubeSumString+STR_LENGTH-1  
mov byte [rdi], 0    
mov rsi, 1

convertLoop:
  mov edx, 0       
  mov ecx, 9             
  div ecx              
  add dl, '0'      
  dec rdi           
  mov [rdi], dl    
  inc rsi   
  cmp eax, 0        
  jne convertLoop    

rightJustifyLoop:
  cmp rsi, STR_LENGTH 
  je finish    
  inc rsi          
  dec rdi              
  mov byte [rdi], ' '    
  jmp rightJustifyLoop
finish: 
;	print the cubeSumString (set above).
	printString	cubeSumString

; =====================================================================
; -----
;  Convert average, min, and max integers to ASCII/nonary for printing.
;  STEP #5 must complete before this code.

	printString	avhdr
	int2aNonary	dword [cubeAve], cubeAveString, STR_LENGTH
	printString	cubeAveString

	printString	minhdr
	int2aNonary	dword [cubeMin], cubeMinString, STR_LENGTH
	printString	cubeMinString

	printString	maxhdr
	int2aNonary	dword [cubeMax], cubeMaxString, STR_LENGTH
	printString	cubeMaxString

	printString	newLine
	printString	newLine

; *****************************************************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

