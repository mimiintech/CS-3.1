;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Four 
;  Description: Arithmetic instructions | Control instructions | Compare instructions |
; Conditional jump instructions
;

;Learn to use arithmetic instructions, 
;control instructions, compare instructions, 
;and conditional jump instructions

; *****************************************************************
;  Data Declarations (provided).

section	.data
;
; -----
;  Define constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Assignment #4 data declarations

list		dd	 2140, -2376,  2540, -2240,  2677, -2635,  2426,  2000
		dd	-2614,  2418, -2513,  2420, -2119,  2215, -2556,  2712
		dd	 2436, -2622,  2731, -2729,  2615, -2724,  2208,  2220
		dd	-2580,  2146, -2324,  2425, -2816,  2256, -2718,  2192
  		dd	 2004, -2235,  2764, -2615,  2312, -2765,  2954,  2960
		dd	-2515,  2556, -2342,  2321, -2556,  2727, -2227,  2844
		dd	 2382, -2465,  2955, -2435,  2225, -2419,  2534,  2348
		dd	-2467,  2316, -2961,  2335, -2856,  2553, -2032,  2832
		dd	 2246, -2330,  2317, -2115,  2726, -2140,  2565,  2868
		dd	-2464,  2915, -2810,  2465, -2544,  2264, -2612,  2656
		dd	 2192, -2825,  2916, -2312,  2725, -2517,  2498,  3672
		dd	-2475,  2034, -2223,  2883, -2172,  2350, -2415,  2335
		dd	 2124, -2118,  2713,  2025
length		dd	100

listMin		dd	0
listEstMed	dd	0
listMax		dd	0
listSum		dd	0
listAve		dd	0

negCnt		dd	0
negSum		dd	0
negAve		dd	0

twelveCnt	dd	0
twelveSum	dd	0
twelveAve	dd	0

; *****************************************************************
section	.text
global _start
_start:
;******************************************************************
; SIGNED idiv/imul/jl/jle/jg/jge/ dd(32-bits)
; find the summation
; listSum:     35,660
mov dword [listMin], eax
mov dword [listMax], eax

mov ecx, dword [length] ; get length value
mov rsi, 0 ; index = 0

sumLoop:
; [ baseAddr + (indexReg * scaleValue ) + displacement ]
mov eax, dword [list+(rsi*4)] ;get list[rsi]
add dword [listSum], eax ; ;update sum
inc rsi ;next element 
loop sumLoop



;****************************************
mov ecx, dword [length] ; reset length
mov rsi, 0 ; reset rsi
;***************************************

;find the minimum
; listMin:     -2961
wasLess:
mov eax, dword [list+(rsi*4)] ;get list[rsi]
cmp eax, dword [listMin] ;compare mins
jl ifLess 
jmp ifMore
ifLess:
mov dword [listMin], eax ;updates min
ifMore:
inc rsi ; next element
loop wasLess

;****************************************
mov ecx, dword [length] ; reset length
mov rsi, 0 ; reset rsi
;***************************************

;find the max
;listMax:     3672
wasGreater:
mov eax, dword [list+(rsi*4)]
cmp eax, dword [listMax]
jg ifGreater
jmp ifLeast
ifGreater:
mov dword [listMax], eax ;updates max
ifLeast:
inc rsi
loop wasGreater

;****************************************
mov rsi, 0 ; reset rsi

; find the est median value
;listEstMed:  1163
; get first, last, middle 2 values (even)
; first value
mov r8d, dword [list] 
; last value
mov esi, dword [length] 
sub esi, 1
mov r13d, dword [list+(esi)*4]
; subtract by 4 since its sized dword 
; middle 2 values
mov edx, 0
mov eax, esi 
mov r9d, 2
div r9d
; so eax has length/2 now
;we want the middle two values here
mov r10d, dword [list+(eax)*4]
mov r11d, dword [list+(eax)*4+4]
; sum the first, last, & middle 2 values  
mov r12d, 0
; sum first value
add r12d, r8d    
; add last value
add r12d, r13d   ;
; add first middle value
add r12d, r10d   
; add second middle value
add r12d, r11d
; then divide by 4
mov rdx, 0
mov eax, r12d
mov ebx, 4
cdq ; sign extend
idiv ebx
; store the result
mov dword [listEstMed], eax 
; 1012
;****************************************

;find the average
;listAve:     356
mov eax, dword [listSum]
mov ebx, dword [length]
cdq 
idiv ebx
mov dword [listAve], eax

;************************************
; FIND SUM (NEG) (43), 
; COUNT (NEG) (-106528), AVE (NEG) (-2477)

mov ecx, dword [length] ; get length value
mov rsi, 0 ; index = 0

; if less than 0, add negative numbers
lessZero:
mov eax, dword [list+(rsi*4)] ;get list[rsi]
cmp eax, 0

jl addNeg ;jump to add negative if less than 0
jmp done
addNeg:
add dword [negSum], eax ;add neg number to sum
inc dword [negCnt] ;increment neg count
done:
inc rsi ;move to next 
loop lessZero ;repeat loop

; to find the average
mov eax, dword [negSum]
cdq 
idiv dword [negCnt]
mov dword [negAve], eax 


; FIND THE 12 COUNT (22), 12 SUM (15600), 12 AVE (709)
; For positive & negative values in the list
mov ecx, dword [length]   ; get length value
mov esi, 0                ; index = 0

twelve:
mov eax, dword [list+(esi*4)] 
; load list[esi] into eax
cdq ;sign extend
mov ebx, 12
idiv ebx
cmp edx, 0                   

jne notTwelve               

; if the remainder is zero (number is divisible by 12)
inc dword [twelveCnt]
mov ebx, dword [list+(esi*4)]
add dword [twelveSum], ebx 

notTwelve:
inc esi   
cmp esi, dword [length]
jne twelve                   

; to find the average
mov eax, dword [twelveSum]          
cdq                             
idiv dword[twelveCnt]                      
mov dword [twelveAve], eax     
; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall
