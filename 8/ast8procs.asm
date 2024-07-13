; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Eight
;  Description:	Learn assembly language functions. Additionally, become more familiar with program
; control instructions, function handling, and stack usage

; ********************************************************************************

section	.data

; -----
;  Define constants.c

TRUE		equ	1
FALSE		equ	0

; -----
;  Local variables for combSort() function.
; swapped		db 0	;FALSE
; gap			dd 0 

; -----
;  Local variables for lstStats() function (if any).




section	.bss

; -----
;  Unitialized variables.




; ********************************************************************************

section	.text

; --------------------------------------------------------
;  Function to calculate the estimated median of an unsorted list.

; -----
;  Call:
;	ans = lstEstMedian(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	estimated median (in eax)
; The estimated the median is computed by summing the first,
; last, and two middle values and dividing by 4 for even
; length lists and 3 for odd length lists. The integer
; function returns the double-word value in eax
; UNSORTED LIST
global lstEstMedian
section .text

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
; **********************************************************************************
;  Comb Sort Algorithm:
;  The function, combSort(), sorts the numbers into ascending
;  order (large to small).
; -----
;  HLL Call:
;	call combSort(list, len)

;  Arguments Passed:
;	1) list, addr - rdi
;	2) length, value - rsi

;  Returns:
;	sorted list (list passed by reference)

;  call combSort(list, len)
; mov	rdi, list1 ;1st arg, addr of arr
; mov	esi, dword [len1] ;2nd arg, value of len
; call	combSort
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
;	jle dontSwap
	jge dontSwap
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
;	minimum, median, maximum, sum, and average

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  This function must call the lstAverage() function
;  to get the average.

;  Note, assumes the list is already sorted.

; -----
;  Call:
;	call lstStats(list, len, sum, ave, min, max, med)

;  Arguments Passed:
;	1) list, addr - rdi
;	2) length, value - rsi
;	3) sum, addr - rdx
;	4) average, addr - rcx
;	5) minimum, addr - r8
;	6) maximum, addr - r9
;	7) median, addr - stack, rbp+16

;  Returns:
;	minimum, median, maximum, sum, and average
;		via pass-by-reference
; VOID FUNCTION
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
	mov dword [r9], eax

	; Get Min (Sorted Last)
	mov eax, dword [rdi +rsi * 4 - 4]
	mov dword [r8], eax 

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
;*****************************************
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
; The list is SORTED
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
;**********************************************************
;  Function to calculate the sum of a list.

; -----
;  Call:
;	ans = lstSum(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	sum (in eax)
; sum1:    37814
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
;  kStat1 = lstKurtosis(list, len, ave)
; mov	rdi, list1
; mov	esi, dword [len1]
; mov	edx, dword [ave1]
; call	lstKurtosis
; mov	dword [kStat1], eax

section .text
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

