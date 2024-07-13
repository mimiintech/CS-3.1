; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: 12
;  Description: Become more familiar with operating system interaction, threading, and race conditions.

; -----
;  Example Duck Number Count for 1 to 200: 27
;	10, 20, 30, 40, 50, 60, 70, 80, 90
;	101, 102, 103, 104, 105, 106, 107, 108, 109
;	110, 120, 130, 140, 150, 160, 170, 180, 190

; ***************************************************************


section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
NULL		equ	0			; end of string
ESC		equ	27			; escape key

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; call code for read
SYS_write	equ	1			; call code for write
SYS_open	equ	2			; call code for file open
SYS_close	equ	3			; call code for file close
SYS_fork	equ	57			; call code for fork
SYS_exit	equ	60			; call code for terminate
SYS_creat	equ	85			; call code for file open/create
SYS_time	equ	201			; call code for get time

; -----
;  Globals (used by threads)

currentIndex	dq	1
myLock		dq	0

; -----
;  Local variables for thread function(s).

msgThread1	db	" ...Thread starting...", LF, NULL

; -----
;  Local variables for getParams function

THREAD_MIN	equ	1
THREAD_MAX	equ	24

LIMIT_MIN	equ	10
LIMIT_MAX	equ	4000000000
BLOCK_SIZE	equ	1000

errUsage	db	"Usage: ./duckNums -th <nonaryNumber> ",
		db	"-l <nonaryNumber>", LF, NULL
errOptions	db	"Error, invalid command line options."
		db	LF, NULL

errLSpec	db	"Error, invalid limit specifier."
		db	LF, NULL
errLValue	db	"Error, invalid limit value."
		db	LF, NULL
errLRange	db	"Error, limit out of range."
		db	LF, NULL


errTSpec	db	"Error, invalid thread count specifier."
		db	LF, NULL
errTValue	db	"Error, invalid thread count value."
		db	LF, NULL
errTRange	db	"Error, thread count out of range."
		db	LF, NULL

; -----
;  Local variables for aNonary2int function

qNine		dq	9
qTen		dq	10
tmpNum		dq	0

; ***************************************************************

section	.text

; ******************************************************************
;  Function getParmas()
;	Get, check, convert, verify range, and return the
;	sequential/parallel option and the limit.

;  Example HLL call:
;	stat = getParams(argc, argv, &thdCount, &numberLimit)

;  This routine performs all error checking, conversion of ASCII/nonary
;  to integer, verifies legal range.
;  For errors, applicable message is displayed and FALSE is returned.
;  For good data, all values are returned via addresses with TRUE returned.

;  Command line format (fixed order):
;	-th <nonaryNumber> -lm <nonaryNumber>

; ./duckNums -th 4 -lm 21520
;	0		  1  2   3  4 

; -----
;  Arguments:
;	1) ARGC, value ;rdi 
;	2) ARGV, address ;rsi 
;	3) thread count (dword), address ;rdx 
;	4) user limit (qword), address ;rcx 

global getParams
getParams:
	push rbx
    push r12
    push r13 
    push r14

	cmp rdi, 1
	je ErrorUsage 
	cmp rdi, 5
	jne ErrorOptions

	mov r12, rsi 
	mov r13, rdx 
	mov r14, rcx 

	mov r11, qword [r12+8] 
	mov al, byte [r11]
	cmp al, "-"
	jne ErrorTSpecifier
	mov al, byte [r11+1] 
	cmp al, "t"
	jne ErrorTSpecifier
	mov al, byte [r11+2]
	cmp al, "h"
	jne ErrorTSpecifier
	mov al, byte [r11+3] 
	cmp al, NULL 
	jne ErrorTSpecifier

	mov rdi, qword [r12+16]
	mov rsi, tmpNum ;pass as address 
;***************************
	call aNonary2int
	cmp rax, 0 
	je ErrorTValue 
	mov rax, qword [tmpNum]  
;***************************
	cmp rax, THREAD_MIN    
	jb ErrorTRange 
	cmp rax, THREAD_MAX    
	ja ErrorTRange   
	mov qword [r13], rax   

	mov r11, qword [r12+24]
	mov al, byte [r11] 
	cmp al, "-"
	jne ErrorLSpecifier
	mov al, byte [r11+1] 
	cmp al, "l"
	jne ErrorLSpecifier
	mov al, byte [r11+2] 
	cmp al, "m"
	jne ErrorLSpecifier
	mov al, byte [r11+3] 
	cmp al, NULL 
	jne ErrorLSpecifier

	mov rdi, qword [r12+32]
	mov rsi, tmpNum ;pass as address 
;***************************
	call aNonary2int
	cmp rax, 0
	je ErrorLValue
	mov rax, qword [tmpNum]
;***************************
	cmp rax, LIMIT_MIN
	jb ErrorLRange
	cmp rax, LIMIT_MAX
	ja ErrorLRange 
	mov qword [r14], rax

	mov rax, TRUE 
	pop r14
	pop r13
	pop r12
	pop rbx
	ret 

ErrorUsage:
mov rdi, errUsage
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorOptions:
mov rdi, errOptions
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorTRange:
mov rdi, errTRange
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorLRange:
mov rdi, errLRange
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorLSpecifier:
mov rdi, errLSpec
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorTSpecifier:
mov rdi, errTSpec
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorTValue:
mov rdi, errTValue
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret

ErrorLValue:
mov rdi, errLValue
call printString
mov rax, FALSE
pop r14
pop r13
pop r12
pop rbx
ret
; ******************************************************************
;  Function: Check and convert ASCII/nonary to integer.

;  Example HLL Call:
;	bool = aNonary2int(senaryStr, &num);
; 							rdi     rsi 
; rax (1) = TRUE
; rax (0) = FALSE 

; Convert a string into 64-bit quad integer 
global aNonary2int
aNonary2int:
    push rbp
    mov rbp, rsp      

    mov rax, 0        
	mov rbx, 0		;index 
    mov qword [rsi], 0 

    conversion:
		mov r8, 0
        movzx r8, byte [rdi+rbx]  ;loads the string into r8   
	    cmp r8b, NULL      ;this is for the null     
        je conversionDone    ;If below, done 
;*******************
		; when it is not ASCII senary value 
		cmp r8b, '0'
		jb falseCondition
		cmp r8b, '8'
		ja falseCondition
;*******************
        sub r8, '0'  ;Convert ASCII to Integer (0-9)
		mov rax, qword [rsi]
        imul rax, [qNine] 
		mov qword [rsi], rax 

        add qword [rsi], r8           
        inc rbx     ;move to next char      
        jmp conversion 

    conversionDone:
        mov rax, TRUE  
		jmp end 

	falseCondition:  
		mov rax, FALSE   

	end: 
        mov rsp, rbp
        pop rbp
		ret
; ******************************************************************
;  Thread function, findDuckNumberCnt()
;	Determine count of duck numbers for all values between
;	1 and userLimit (globally available)

; -----
;  Arguments:
;	N/A (global variable accessed)
;  Returns:
;	N/A (global variable accessed)

common	userLimit	1:8				; from main
common	duckNumberCount	1:8				; from main

global findDuckNumberCnt

findDuckNumberCnt:
    push rbp
    mov rbp, rsp
    sub rsp, 8
	push rbx 
    push r15 
	push r13 

localVars: 
    mov rdi, msgThread1
    call printString
	mov qword [rbp-8], FALSE 
	mov r8, BLOCK_SIZE

nextblock:
   call spinLock
	mov r14, qword [userLimit]
    mov r10, qword [currentIndex]
    cmp r10, r14
    jae beyondLimit 
    add r8, r10
    cmp r8, r14
    jbe updateCurrentIndex
    mov r8, r14 

updateCurrentIndex:
    mov qword [currentIndex], r8

beyondLimit:
   call spinUnlock
	mov r15, r10 
    cmp r10, r14
    jae exitLoop 
	mov qword [rbp-8], FALSE 

numsLoop:
	mov rdi, r15
	mov rbx, FALSE
    cmp r15, r8
    jae incGlobalCnt 

cntOfZeros:
    mov rax, rdi
    mov rdx, 0
    mov r13, [qTen]
    div r13
    cmp rdx, 0
	je incCounter 
    jmp continueProcess 

incCounter:
	inc rbx 

continueProcess:
    mov rdi, rax
    cmp rdi, 0
    ja cntOfZeros

exactlyOne: 
    cmp rbx, TRUE 
    jne nextNum
    inc qword [rbp-8] 

nextNum:
    inc r15
    jmp numsLoop

blockProcess: 
    cmp r15, r8 
    jb numsLoop

incGlobalCnt:
    mov r10, qword [rbp-8]
   lock add [duckNumberCount], r10
    jmp nextblock

exitLoop:
	pop r13 
    pop r15
	pop rbx 
    mov rsp, rbp
    pop rbp
    ret
; ******************************************************************
;  Mutex lock
;	checks lock (shared global variable)
;		if unlocked, sets lock
;		if locked, lops to recheck until lock is free

global	spinLock
spinLock:
	mov	rax, 1			; Set the RAX register to 1.

lock	xchg	rax, qword [myLock]	; Atomically swap the RAX register with
					;  the lock variable.
					; This will always store 1 to the lock, leaving
					;  the previous value in the RAX register.

	test	rax, rax	        ; Test RAX with itself. Among other things, this will
					;  set the processor's Zero Flag if RAX is 0.
					; If RAX is 0, then the lock was unlocked and
					;  we just locked it.
					; Otherwise, RAX is 1 and we didn't acquire the lock.

	jnz	spinLock		; Jump back to the MOV instruction if the Zero Flag is
					;  not set; the lock was previously locked, and so
					; we need to spin until it becomes unlocked.
	ret

; ******************************************************************
;  Mutex unlock
;	unlock the lock (shared global variable)

global	spinUnlock
spinUnlock:
	mov	rax, 0			; Set the RAX register to 0.

	xchg	rax, qword [myLock]	; Atomically swap the RAX register with
					;  the lock variable.
	ret

; ******************************************************************
;  Generic function to display a string to the screen.
;  String must be NULL terminated.
;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

;  Arguments:
;	- address, string
;  Returns:
;	nothing

global	printString
printString:

; -----
; Count characters to write.

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