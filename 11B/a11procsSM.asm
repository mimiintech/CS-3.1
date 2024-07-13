; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: 11
;  Description: Become more familiar with operating system interaction, file input/output operations, and
;file I/O buffering.


; -----
;  The provided main calls four functions.

;  1) checkParameters()
;	Get command line arguments (word, match case flag, and
;	file descriptor), performs appropriate error checking,
;	opens file, and returns the word, match case flag, and
;	the file descriptor and word.  If there any errors in
;	command line arguments, display appropriate error
;	message, and return FALSE status code.


;  2) getWord()
;	Get a single word of text (which must be verified
;	as no more than MAXWORDLENGTH characters).
;	Returned word is terminated with an NULL.
;	Note, this routine performs all buffer management.


;  NOTE: The buffer management is a significant portion of
;	the assignment.  Omitting or skipping the I/O
;	buffering will significantly impact the score.


;  3) checkWord()
;       Given the new word from the file and the user specified
;       word and the current count, update the count if the 
;	words match.

;----------------------------------------------------------------------------

section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
NULL		equ	0			; end of string
SPACE		equ	0x20			; space
TAB		equ	0x09

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

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

O_CREAT		equ	0x40
O_TRUNC		equ	0x200
O_APPEND	equ	0x400

O_RDONLY	equ	000000q			; file permission - read only
O_WRONLY	equ	000001q			; file permission - write only
O_RDWR		equ	000002q			; file permission - read and write

S_IRUSR		equ	00400q
S_IWUSR		equ	00200q
S_IXUSR		equ	00100q

; -----
;  Variables for getFileDescriptors()

usageMsg	db	"Usage: ./grep -w <searchWord> <-mc|-ic> -f <inputFile>"
		db	LF, NULL

errBadCLQ	db	"Error, invalid command line arguments."
		db	LF, NULL

errWordSpec	db	"Error, invalid search word specifier."
		db	LF, NULL

errWordLength	db	"Error, search word length must be < 80 "
		db	"characters."
		db	LF, NULL

errFileSpec	db	"Error, invalid input file specifier."
		db	LF, NULL

errCaseSpec	db	"Error, invalid match case specifier."
		db	LF, NULL

errOpenIn	db	"Error, can not open input file."
		db	LF, NULL
		
errBadRead	db	"Error, can read input file, program terminated."
		db	LF, NULL

; -----
;  Define constants and variables for getWord()

MAXWORDLENGTH	equ	80
; max allowable word length 
BUFFSIZE	equ	2
; buffer defined size 
bfMax		dq	BUFFSIZE
; holds the max 
curr		dq	BUFFSIZE
; current position in the buffer 
wasEOF		db	FALSE
; whether the end of file is reached 
errFileRead	db	"Error reading input file."
		db	LF, NULL
; -------------------------------------------------------

section	.bss

buff		resb	BUFFSIZE+1
; where you read the characters 
tmpString	resb	MAXWORDLENGTH+1
; storing indivual words from buff 
; -------------------------------------------------------
section	.text
; -------------------------------------------------------
;  Check and return command line parameters.
;	Assignment #11 requires a word to search for, flag for
;	case handling and a file name.
;	Example:    % ./grep -w <searchWord> <-mc|-ic> -f <infile>
;					0	 1       2          3       4    5
;	Args Total = 6 

; NOTE: Match case (-mc) is TRUE to match case.
;	Match case (-ic) is FALSE when ignoring case.

;	To ignore case, it is easiest to either uppoer or lower case
;	all letters in both strings to be compared.

;	Note, best to NOT change the original and perform the match on
;	a copy of the original.

; -----
; HLL Call:
;	bool = checkParameters(ARGC, ARGV, searchWord, matchCase, rdFileDesc)

;  Arguments passed:
;	1) argc, value - rdi 
;	2) argv, address - rsi 
;	3) search word [string], address - rdx 
;	4) match case [boolean], address - rcx 
;	5) input file [descriptor], address - r8 

global checkParameters
checkParameters:
; Read/check parameters (file names) from cmd line
; Display error messages
; A printString(str) function provided 
; Error check file name
; Attempt to open if sucessful => is ok
; if fail => error
; If open => return file desriptors
push rbp
mov rbp, rsp
; push maintained registers
	push rbx
    push r12
    push r13 
    push r14
    push r15
; Check args range & do error msgs 
; rdi holds the ARGC	
	cmp rdi, 1
	je ErrorUsageMessage
	cmp rdi, 6
	jb ErrorTooFewArgs
	cmp rdi, 6
	ja ErrorTooManyArgs
; Make MOVES into preserved registers
	; moving ARGV into r12 
	mov r12, rsi 
	; moving search word into r13
	mov r13, rdx 
	; moving match case into r14 
	mov r14, rcx 
	; moving file descriptor into r15
	mov r15, r8
; Check the first argument "-w"
	mov rbx, qword [r12+8] 
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorSWSpecifier
	mov al, byte [rbx+1] ;check "w"
	cmp al, "w"
	jne ErrorSWSpecifier
	mov al, byte [rbx+2] ;check NULL
	cmp al, NULL 
	jne ErrorSWSpecifier
; Check within the search word 
;loop for ARGV[2] to count how many chars exist in the search word 
; (sans the NULL char), and cmp the count against 80
; Assuming r12 contains argv
mov r10, qword [r12+16] ; ARGV[2], the search word
mov r11, 0  ;count chars         
countLoop:
    mov al, byte [r10+r11]
	mov byte [r13+r11], al  
    cmp al, NULL       
    je endCount  
    inc r11                             
    jmp countLoop     
endCount:  
	cmp r11, MAXWORDLENGTH
	jle next
	mov byte[r13+r11], NULL
	jg ErrorWordLength ;if greater, error word length
; Check the second argument "-mc" or "-ic"
	next:
	mov rbx, qword [r12+24] 
	cmp dword [rbx], 0x00636D2D 
	je isMatchCase 
	cmp dword [rbx], 0x0063692D
	je IgnoreCase
; If neither, error message
	jmp ErrorMCSpecifier
	isMatchCase: 
	mov byte [r14], 1 ;TRUE 
	jmp continue 
	IgnoreCase:
	mov byte [r14], 0 ;FALSE
	jmp continue
; Check the third argument
	continue: 
	mov rbx, qword [r12+32] 
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorIFSpecifier
	mov al, byte [rbx+1] ;check "f"
	cmp al, "f"
	jne ErrorIFSpecifier
	mov al, byte [rbx+2] ;check NULL
	cmp al, NULL 
	jne ErrorIFSpecifier
; Check if the input file is being read in
; Opens file
	mov rax, SYS_open ;file opens
	mov rdi, qword [r12+40] 
	mov rsi, O_RDONLY ;read only access
	syscall
; check for open success
	cmp rax, 0
	jl ErrorCantOpenFile
	mov qword [r15], rax ;saves descriptor 
jmp NoErrorsCleanup
;**************************************
; ERROR SECTION
; Usage: ./grep -w <searchWord> <-mc|-ic> -f <inputFile>
ErrorUsageMessage:
mov rdi, usageMsg
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorTooFewArgs:
;Error, invalid command line arguments.
mov rdi, errBadCLQ
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorTooManyArgs:
;Error, invalid command line arguments.
mov rdi, errBadCLQ
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorSWSpecifier:
;Error, invalid search word specifier.
mov rdi, errWordSpec
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorWordLength:
mov rdi, errWordLength
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorMCSpecifier:
;Error, invalid match case specifier.
mov rdi, errCaseSpec
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorIFSpecifier:
;Error, invalid input file specifier.
mov rdi, errFileSpec
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
ErrorCantOpenFile:
;Error, can not open input file.
mov rdi, errOpenIn
call printString
mov rax, FALSE
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
NoErrorsCleanup:
mov rax, TRUE 
pop r15
pop r14
pop r13
pop r12
pop rbx
mov rsp, rbp
pop rbp
ret 
; -------------------------------------------------------
;  Get a single word of text and return.
;  Implements basic C++ (searchWord << inFile) functionality.

;  A "word" is considered a set of contiguous non-white space
;  characters.  White space includes spaces, tabs, and LF.
;  Any character <= a space character is considered white space.
;  Function terminates word string with a NULL.

;  If a word exceeds the passed max length, must not over-write
;  the buffer.  Instead, just skip remaining characters.
;  This returns a partial word (which is ok in this context).

;  This routine handles the I/O buffer management.
;	- if buffer is empty, get more chars from file
;	- return word and update buffer pointers

;  If a word is returned, return TRUE.
;  Otherwise, return FALSE.

; -----
; HLL Call:
;	bool = getWord(currentWord, maxLength, rdFileDesc)

;  Arguments passed:
;	1) word buffer, address - rdi 
;	2) max word length (excluding NULL), value -rsi 
;	3) file descriptor, value - rdx 

global getWord
getWord:
; push maintained registers
	push rbx
    push r12
    push r13 
    push r14
	push r15 

; make moves into preserved registers
	mov r12, rdi ;currentWord
	mov r13, rsi ;maxLength
	mov r14, rdx ;rdFileDesc

	mov rsi, buff
;	i = 0 
	mov rbx, 0 ;my index 

getNextByte:
	; if (currIdx >= buffMax) 
		mov r15, qword [curr] ;800000
		cmp r15, [bfMax] ;BUFFSIZE
		jb readBuffer 

		; if (end of file) is TRUE, EXIT  
		cmp byte [wasEOF], TRUE 
		; not equal to, then continue to read file 
		jne readFile 
		 
		mov al, FALSE
		; EXIT 
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		ret

; read file (BUFFSIZE bytes)
; Call OS to read from the file 
	readFile: 
		mov rax, SYS_read  ;number of chars read 
		mov rdi, r14 ;where
		mov rsi, buff ;addr
		mov rdx, BUFFSIZE
		syscall

; 	if (rax < 0) 
	cmp rax, 0
	jge noError 
	; if greater, then there's no issue 

	;if less, continues to bad read error 
		mov rdi, qword [errBadRead] 
		call printString
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		mov al, FALSE
		ret 

	noError:
	mov qword [curr], 0
	mov qword [bfMax], rax 

	; If (rax < BUFFSIZE) {
		cmp rax, BUFFSIZE
		jb handleFile
		jmp getNextByte

			handleFile: 
			;eof = True
			mov byte [wasEOF], TRUE
			;bfMax = rax
			mov qword [bfMax], rax 

		mov r15, qword [curr]
		jmp getNextByte

readBuffer: 
	mov rcx, 0
	mov cl, byte [rsi+r15]

; if (chr is letter)
; ASCII table lower case a-z and uppercase A-Z
	cmp cl, 'A' ;65
	jb notLetter
	cmp cl, 'z' ;122
	ja notLetter

	cmp cl, 'a' ;97
	jae isLetter
	cmp cl, 'Z' ;90
	jbe isLetter
	
	jmp notLetter

		isLetter:	
		; store if its a letter
		 mov byte [r12+rbx], cl 
		 inc rbx 
		 add qword[curr], 1

		 cmp rbx, r13 
		 ; check for maxlength 
		 jae exitLoopFalse

		 jmp getNextByte

		notLetter:
		cmp rbx, 0 
		ja endOfWord
		add qword [curr], 1
		jmp getNextByte

		endOfWord: 
		mov byte [r12+rbx], NULL
		jmp exitLoopTrue

	exitLoopTrue: 
		pop r15 
		pop r14
		pop r13
		pop r12
		pop rbx
		mov al, TRUE ;constant return TRUE 
		ret 

	exitLoopFalse:
		pop r15 
		pop r14
		pop r13
		pop r12
		pop rbx
		mov al, FALSE ;constant return FALSE 
		ret 
; -------------------------------------------------------
;  Compare strings, searchWord to currWord.
;  If same, increment word count.
;  Must handle match based on case flag.
; NOTE: Match case (-mc) is TRUE to match case.
;	Match case (-ic) is FALSE when ignoring case.
;	To ignore case, it is easiest to either uppoer or lower case
;	all letters in both strings to be compared.
;	Note, best to NOT change the original and perform the match on
;	a copy of the original.

; -----
;  HLL Call:
;	call checkWord(searchWord, currentWord, matchCase, wordCount)

;  Argument passed:
;	1) searchWord, address - rdi
;	2) currentWord, address - rsi 
;	3) match case flag, value - rdx 
;	4) word count, address - rcx 

global checkWord
checkWord:
	; Push preserved registers 
		push rbx
		push r12
		push r13
		push r14
		push r15

   		mov r12, rdi ; rdi: address of searchWord
    	mov r13, rsi ; rsi: address of currentWord
    	mov r14, rdx ; rdx: match case flag (match case (1), ignore case (0))
    	mov r15, rcx ; rcx: address of word count
		mov rbx, 0	;loop counter 

	cmpSWordCWord:
; The cpp says char for sword/cword 
		mov r10b, byte [r12+rbx] ;char
    	mov r11b, byte [r13+rbx] ;char 

    cmp r10b, NULL
	je checkother
	jmp notnull

	checkother:
    cmp r11b, NULL
	je endLoop
	jne end

	notnull:
    ; If r14 = 0, convert to lower case 
    cmp r14, FALSE ;bool

	je lowerConversion

	; // if -mc, check if they are the same
	jmp match

	lowerConversion:
	cmp r10b, r11b 
	je match

	cmp r10b, 'a'
	jb conversion

	jmp noConversion

	conversion:
	add r10b, 32
	cmp r10b, r11b 
	
	jne end 
	inc rbx 
	jmp cmpSWordCWord

	jne end  

;	-ic conversion
	noConversion: 
	cmp r10b, r11b 
	sub r10b, 32

	match:
	cmp r10b, r11b 

	jne end
	inc rbx 
	jmp cmpSWordCWord

	endLoop:
		; // if index is greater then 0, return a word
		cmp rbx, 0
		ja incWordCnt
		; // if index is 0, end without incrementing count
		jmp end

	incWordCnt:
    	inc dword [r15]
; Pop preserved registers

end:
 		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		ret  

; ******************************************************************
;  Generic function to display a string to the screen.
;  String must be NULL terminated.

;  Algorithm:
;	Count characters in string (excluding NULL)
;	Uses syscall to output characters

; -----
;  HLL Call:
;	printString(stringAddr);

;  Arguments:
;	1) address, string
;  Returns:
;	nothing

global	printString
printString:

; -----
;  Count characters to write.

	mov	rdx, 0
strCountLoop:
	cmp	byte [rdi+rdx], NULL
	je	strCountLoopDone
	inc	rdx
	jmp	strCountLoop
strCountLoopDone:
	cmp	rdx, 0
	je	printStringDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; rdx=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

printStringDone:
	ret

; ******************************************************************

