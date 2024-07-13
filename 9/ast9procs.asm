; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: 9
;  Description: Learn assembly language functions and standard calling convention. Additionally, become
; more familiar with program control instructions, high-level language function interfacing


; ********************************************************************************

section	.data
test5 db 0
; -----
;  Define standard constants.

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
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

; -----
;  Define program specific constants.

MAXNUM		equ	100000
MINNUM		equ	-100000
BUFFSIZE	equ	51			; 50 chars plus NULL
; -----
;  NO static local variables allowed...


; ********************************************************************************

section	.text

; --------------------------------------------------------
;  Read an ASCII nonary number from the user.
;  Perform appropriate error checking and, if OK,
;  convert to integer.

; -----
;  HLL Call:
;	bool = readNonaryNum(&numberRead, promptStr, errMsg1,
;				errMsg2, errMsg3);

;  Arguments Passed:
;	numberRead, addr - rdi
;	promptStr, addr - rsi
;	errMsg1, addr - rdx
;	errMsg2, addr - rcx
;	errMsg3, addr - r8

;  Returns:
;	true/false
;	number read (via reference)

global    readNonaryNum
readNonaryNum:
    push rbp
    mov rbp, rsp
    sub rsp, 57 ;allocate space
    push rbx
    push r12
    push r13 
    push r14
    push r15
    mov r14, rdx ;message 1
    mov r15, rcx ;message 2
    mov r13, rdi
    mov rdi, rsi 
    ; SI Jorge told me to add push rsi and r8
    ; to preserve those values without using more
    ; stack
    push rsi
    push r8
    call printString
    pop r8
    pop rsi
localVars: 
    ; Initialize local variables
    lea rbx, byte [rbp-51] ;buffer
    mov dword [rbp-55], 0 ;sum 
    mov byte [rbp-56], 0 ;chr
    mov byte [rbp-57], 0 ;flag 
    mov r12, 0  ;count++
getChar:
    ; SI Jorge told me to add push rsi and r8
    ; to preserve those values without using more
    ; stack
    push rsi
    push r8
    mov rax, SYS_read    
    mov rdi, STDIN       
    lea rsi, byte [rbp-56] ;chr
    mov rdx, 1         
    syscall  
    pop r8
    pop rsi

    mov al, byte [rbp-56] ;chr 
    cmp al, LF
    je inputDone  

; Exceeding input max 
    cmp r12, BUFFSIZE
    jae aboveFifty 
    ;chr stored 
    mov byte [rbx + r12], al 
    inc r12 
aboveFifty:
    jmp getChar
inputDone:
; if i = 0, set false condiiton
    cmp r12, 0

    ja checkSize 
    mov rax, FALSE
    jmp Cleanup
checkSize:
; if input > BUFFSIZE, set code exit function
    cmp r12, BUFFSIZE
    jb checkInput 
; if below, check the input 
   jmp ErrorInputTooLong
checkInput:
    ;mov r9d, 1 
    mov byte [rbx+r12], NULL  
    lea rbx, byte [rbp-51] ;loop again 
; ERROR CHECKING SECTION
    mov rcx, 0
ErrorCheckLoop:
    mov cl, byte [rbx]
    cmp cl, SPACE
; leading spaces ignored 
    jne secondCheck
    inc rbx
    jmp ErrorCheckLoop
; Signs(+/-) included 
secondCheck:
; leading spaces ignored
    cmp cl, '+'
    je continue 
    cmp cl, '-'
    je setNegative
    jmp ErrorInvalidInput
setNegative:
    mov byte [rbp-57], 1 
    inc rbx 
    jmp WithinRangeCheck
continue:
    inc rbx ;inc string postiion 
    jmp WithinRangeCheck
; CONVERSION SECTION
WithinRangeCheck:
    mov cl, byte [rbx]
    cmp cl, NULL
    je doneConversion
    cmp cl, '0'
    jb ErrorInvalidInput
    cmp cl, '8'
    ja ErrorInvalidInput
; Conversion chr to int 
    mov r9, 0
    sub cl, '0'
    mov r9b, cl
; Sum * 9
    mov eax, dword [rbp - 55] ;sum
    imul eax, 9
    mov dword [rbp - 55], eax ; stored sum
; Sum + int 
    add dword [rbp - 55], r9d
    inc rbx
    jmp WithinRangeCheck
    doneConversion:
; If the value after conversion is within min & max
    mov eax, dword [rbp-55]
    cmp eax, MINNUM
    jl ErrorOutOfRange
    cmp eax, MAXNUM
    jg ErrorOutOfRange
;**************************************
; HANDING NEGATIVE NUMBERS SECTION 
mov cl, byte [rbp - 57] ;load sum
cmp cl, 1 ;compare flag to true 
jne continues 
mov eax, 0
sub eax, dword [rbp - 55]
mov dword [rbp - 55], eax
continues:
mov eax, dword [rbp - 55] ;load flag 
mov dword [rbx], eax ;saves into rbx 
mov dword [r13], eax ;Store into r13
mov rax, TRUE ;flag true  
jmp Cleanup ;leads to pops 
;**************************************
; ERROR SECTION
; "Error, invalid. Please re-enter.\n";
ErrorInvalidInput:
    mov rdi, r14 ;message 1
    ; SI Jorge told me to add push rsi and r8
    ; to preserve those values without using more
    ; stack
    push rsi
    push r8
    call printString
    pop r8
    pop rsi
	; reprompt for input
    mov rdi, r13
    mov rdx, r14
    mov rcx, r15

    pop r15
    pop r14
    pop r13
	pop r12
	pop rbx
    add rsp, 57
    mov rsp, rbp
    pop rbp
    jmp readNonaryNum
;"Error, out of range. Please re-enter.\n";
 ErrorOutOfRange:
    mov rdi, r15 ;message 2
    ; SI Jorge told me to add push rsi and r8
    ; to preserve those values without using more
    ; stack
    push rsi
    push r8
    call printString
    pop r8
    pop rsi
    ; reprompt for input
    mov rdi, r13
    mov rdx, r14
    mov rcx, r15

    pop r15
    pop r14
    pop r13
	pop r12
	pop rbx
    add rsp, 57
    mov rsp, rbp
    pop rbp
    jmp readNonaryNum
;"Error, input too long. Please re-enter.\n";
ErrorInputTooLong:
    mov rdi, r8 ;message 3 
    ; SI Jorge told me to add push rsi and r8
    ; to preserve those values without using more
    ; stack
    push rsi
    push r8
    call printString
    pop r8
    pop rsi

	; reprompt for input
    mov rdi, r13
    mov rdx, r14
    mov rcx, r15

    pop r15
    pop r14
    pop r13
	pop r12
	pop rbx
    add rsp, 57
    mov rsp, rbp
    pop rbp
    jmp readNonaryNum
Cleanup:
    mov rdi, r13
    mov rdx, r14
    mov rcx, r15
    
    pop r15
    pop r14
    pop r13
	pop r12
	pop rbx
    add rsp, 57
    mov rsp, rbp
    pop rbp
ret
; **********************************************************************************
;  Perform comb sort

; -----
;  HLL Call:
;	call combSort(list, len)

;  Arguments Passed:
;	1) list, addr - rdi
;	2) length, value - rsi

;  Returns:
;	sorted list (list passed by reference)
global	combSort
combSort:
;  void function combSort(array, length)
; CREATE STACK DYNAMIC LOCALS
; PUSH REGISTERS
	push rbp ;prologue
	mov rbp, rsp
	sub rsp, 5 ;allocate locals
	push rbx
	push r14
;**********************************************
	; Initialize local variables
	mov dword [rbp-4], esi 	;Store the 'length' in 'gap' (4 bytes)
	mov byte [rbp-5], TRUE ;swapped (1 byte) ;FALSE
;**********************************************
;     outer loop (until gap = 1) and (swapped = false)
; while (gap != 1 && swapped == true)
outerLoop:
	mov eax, dword [rbp-4] ;load gap
	cmp eax, 1 ;compare to 1
	jg outerLoopOk ;continues loop
	mov al, byte [rbp-5] ;load swapped flag
	cmp al, TRUE ;compare if swapped = TRUE
	je outerLoopOk ;if swapped = true, continue 
	jmp outerLoopDone
outerLoopOk:
;    gap = (gap * 10) / 12	     			// update gap for next sweep
	mov eax, dword [rbp-4] ;load gap
	imul eax, 10	;mul by 10
	mov edx, 0 ;clears edx
	cdq ;sign extend
	mov ecx, 12 
	idiv ecx
	mov dword [rbp-4], eax ;stores gap
;    if gap < 1
	cmp eax, 1
	jl gapAgain
	; end if
	jmp outerLoopContinued
	gapAgain:
;     gap = 1
	mov dword [rbp-4], 1
	outerLoopContinued:
;         end if i = 0
	mov r14, 0
;         swapped = false
	mov byte [rbp-5], FALSE 
;         inner loop until i + gap >= length	       // single comb sweep
;   while (i+gap < length)
	innerLoop:
	mov r8, 0 	;64-bit register
	mov r8d, r14d ;moves ebx (index) into dword (r8d)
;***************************************
	mov r10, 0
	mov r10d, dword [rbp-4] ;gap
	add r10d, r8d ;i + gap
;***************************************
	cmp r10d, esi ;compare with length (esi)
	jge innerLoopDone
;***************************************
	mov eax, dword [rdi + r8 * 4] ;array[i]
	mov ebx, dword [rdi + r10 * 4] ;array[i+gap]
; rdi(list1) + r8 * 4
; The indices have to be quads 64-bits
;*************************************
;if array[i] > array[i+gap]
	cmp eax, ebx
; end if 
	jle dontSwap
	;jge dontSwap
; swap (array[i], array[i+gap])
	mov dword [rdi + r8 * 4], ebx
	mov dword [rdi + r10 * 4], eax 
; swapped = true
	mov byte [rbp-5], TRUE 
; end if i = i + 1
	dontSwap:
	inc r14d
jmp innerLoop
	innerLoopDone:
jmp outerLoop
outerLoopDone: 
; POP REGISTERS
	pop r14
	pop rbx 
	mov rsp, rbp ;clear locals 
	pop rbp
ret 
; --------------------------------------------------------
;  Find statistical information for a list of integers:
;	sum, average, minimum, maximum, and, median

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  This function must call the lstAvergae() function
;  to get the average.

;  Note, assumes the list is already sorted.

; -----
;  Call:
;	call lstStats(list, len, sum, ave, min, max, med)

;  Arguments Passed:
;	list, addr - rdi
;	length, value - rsi
;	sum, addr - rdx
;	average, addr - rcx
;	minimum, addr - r8
;	maximum, addr - r9
;	median, addr - stack, rbp+16

;  Returns:
;	sum, average, minimum, maximum, and median
;		via pass-by-reference
global lstStats
lstStats:
    push rbp    ;prologue
   	mov rbp, rsp

; PUSH MAINTAINED REGISTERS
	push rbx
	push r12
	push r13
	push r14

	; Get Max (Sorted First)
	mov eax, dword [rdi]
	mov dword [r8], eax

	; Get Min (Sorted Last)
	mov eax, dword [rdi +rsi * 4 - 4]
	mov dword [r9], eax 

;  Call:
;	VALUE RETURNING 
;	ans = lstSum(lst, len)
	call lstSum
	mov dword [rdx], eax

;  Call:
;	VALUE RETURNING
;	ans = lstAverage(lst, len)
	call lstAverage
	mov dword [rcx], eax

;  Call:
;	ans = lstMedian(lst, len)
; median, addr - stack, rbp+16
	call lstMedian
	mov r12, qword [rbp + 16]
	mov dword[r12], eax

; PUSH MAINTAINED REGISTERS
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret 
; --------------------------------------------------------
;  Function to calculate the median of a sorted list.

; -----
;  Call:
;	ans = lstMedian(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	median (in eax)
global  lstMedian
lstMedian:
    mov r8, 2           
    mov edx, 0           
    mov rax, rsi        
    div r8             
    cmp edx, 0      
    jne handleOdd     
    mov r10d, dword [rdi + rax * 4]   
    dec eax
    handleOdd:
    mov r11d, dword [rdi + rax * 4]   
    mov eax, r11d      
    cmp edx, 0         
    jne handleEven
	add r10d, r11d  
	mov eax, r10d
	cdq      
	idiv r8           
    handleEven:
ret 
; --------------------------------------------------------
;  Function to calculate the estimated median of a sorted list.

; -----
;  Call:
;	ans = lstEstMedian(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	estimated median (in eax)
global  lstEstMedian
lstEstMedian:
    push rbx
    push r12
    push r13

    mov eax, dword [rdi]
    mov ebx, eax 
    mov rax, rsi
    dec rax
    mov eax, dword [rdi + rax * 4]
    mov r12d, eax 

    mov rcx, 2
    mov rax, rsi
    mov edx, 0  
    div rcx 

    cmp edx, 0
    je calculateEven  

calculateOdd:
    mov r8d, dword [rdi + rax * 4]  
    add ebx, r12d  
    add ebx, r8d  

    mov eax, ebx
    cdq  
    mov ecx, 3
    idiv ecx 
    jmp done  

calculateEven:
    dec rax
    mov r8d, dword [rdi + rax * 4]  
    mov r9d, dword [rdi + rax * 4 + 4]  

    add ebx, r12d 
    add ebx, r8d   
    add ebx, r9d  

    mov eax, ebx
    cdq  
    mov ecx, 4
    idiv ecx 

done:
    pop r13
    pop r12
    pop rbx
    ret
; --------------------------------------------------------
;  Function to calculate the sum of a list.

; -----
;  Call:
;	ans = lstSum(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	sum (in eax)
global	lstSum
lstSum:
	push rbp    	;prologue
    mov rbp, rsp
    push r12    

	mov r12, 0 ;index
	mov rax, 0 ;running sum
; 	GET SUM
	sumLoop:
	add eax, dword [rdi + r12 * 4] ;sum += arr[i]
	inc r12
	cmp r12, rsi
	jl sumLoop
	mov dword [rdx], eax  ;return sum
	pop r12		;epilogue
	pop rbp
	ret 
; --------------------------------------------------------
;  Function to calculate the average of a list.

; -----
;  Call:
;	ans = lstAverage(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	average (in eax)
global lstAverage
lstAverage:
    push rbp          
    mov rbp, rsp        
    push rdi            
    push rsi            
    call lstSum         
    mov rdx, 0         
    cdq                
    idiv rsi            
    pop rsi            
    pop rdi          
    pop rbp        
    ret   
; --------------------------------------------------------
;  Function to calculate the kurtosis statisic.

; -----
;  Call:
;  kStat = lstKurtosis(list, len, ave)

;  Arguments Passed:
;	1) list, address - rdi
;	2) len, value - esi
;	3) ave, value - edx

;  Returns:
;	kurtosis statistic (in rax)
global lstKurtosis
lstKurtosis:
;	4th powers
    mov r8, 0   
    mov r9, 0  
;	2nd powers
    mov r10, 0 
    mov r11, 0 

    mov rax, rdx ;putting ave into rax
    mov rcx, 0   ;counter

calculateLoop:
    mov edx, dword [rdi + rcx * 4] 
    sub edx, eax           
    imul edx, edx          
    add r9, rdx            

    imul rdx, rdx          
    add r8, rdx            

    inc rcx                
    cmp rcx, rsi       
    jl calculateLoop     

    cmp r9, 0       
    je calcDone     
    mov rax, r8            
    mov rdx, 0            
    div r9            

calcDone:
    ret 
; ********************************************************************************
;  Generic procedure to display a string to the screen.
;  String must be NULL terminated.

;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

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
	mov	rsi, rdi			; address of char to write
	mov	rdi, STDOUT			; file descriptor for std in
						; rdx=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

printStringDone:
	ret

; ******************************************************************

