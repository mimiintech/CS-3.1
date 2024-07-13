;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Five  
;  Description: Arithmetic instructions | Control instructions | Compare instructions |
; Conditional jump instructions
;

;Learn to use arithmetic instructions, 
;control instructions, compare instructions, 
;and conditional jump instructions
; -----

section .data

;  Define constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Data Set data declarations

bases		db	 148,  194,  162,  163,  118 
		db	 161,  145,  152,  129,  165 
		db	 112,  100,  185,  163,  125 
		db	 176,  147,  155,  110,  113 
		db	 108,  145,  161,  164,  165 
		db	 177,  120,  156,  147,  161 
		db	 152,  119,  165,  161,  131 
		db	 165,  114,  123,  115,  114 
		db	 101,  171,  111

slants		dw	 233,  214,  223,  211,  234 
		dw	 212,  200,  285,  263,  205 
		dw	 264,  213,  224,  213,  265 
		dw	 244,  212,  213,  212,  223 
		dw	 265,  264,  273,  216,  234 
		dw	 253,  213,  243,  213,  235 
		dw	 244,  169,  234,  233,  232 
		dw	 234,  223,  215,  214,  201 
		dw	 222,  242,  233

heights		dd	 245,  234,  223,  223,  223 
		dd	 253,  253,  243,  253,  235 
		dd	 234,  234,  256,  264,  242 
		dd	 253,  253,  284,  242,  234 
		dd	 245,  234,  223,  223,  223 
		dd	 234,  234,  256,  264,  242 
		dd	 253,  253,  284,  242,  234 
		dd	 256,  264,  242,  234,  201 
		dd	 201,  223,  272

length		dd	43

laMin		dd	0
laEstMed	dd	0
laMax		dd	0
laSum		dd	0
laAve		dd	0

taMin		dd	0
taEstMed	dd	0
taMax		dd	0
taSum		dd	0
taAve		dd	0

vMin		dd	0
vEstMed		dd	0
vMax		dd	0
vSum		dd	0
vAve		dd	0

; -----
; Additional variables

ddTwo		dd	2
ddThree		dd	3

; --------------------------------------------------------------
; Uninitialized data

section	.bss

lateralAreas	resd	43
totalAreas	resd	43
volumes		resd	43
;**********************************************************
section	.text
global _start
_start:
;********************************************************
;FIND THE LATERAL AREAS
;lateralAreaMin:      40222
;lateralAreaMax:      89562
;lateralAreasEstMed:  65751
;lateralAreaSum:      2835586
;lateralAreaAve:      65943
; lateralAreas[ n] = 
; 2 × bases[ n] × slants [ n]
mov ecx, dword [length] 	; length counter
mov rsi, 0                   ; index

calcLoop:
    movzx eax, byte [bases+rsi]	;bases[i]
    movzx r8d, word [slants+rsi*2] ;slants[i]

    mul r8d
    mov ebx, 2
    mul ebx

    mov dword [lateralAreas+rsi*4], eax
    inc rsi
    loop calcLoop

; Find MIN, MAX, SUM, & AVE FOR LATERAL AREAS
mov ecx, dword [length] 	; length counter
mov rsi, 0                   ; index

mov eax, dword [lateralAreas]
mov dword [laMin], eax
mov dword [laMax], eax
mov dword [laSum], 0

statsLoop:
mov eax, dword [lateralAreas+rsi*4]
add dword [laSum], eax
cmp eax, dword [laMin]
jae notNewLaMin
mov dword [laMin], eax  
notNewLaMin:
cmp eax, dword [laMax]
jbe notNewLaMax
mov dword [laMax], eax
notNewLaMax:
inc rsi 
loop statsLoop

; calc average
mov eax, dword [laSum]
mov edx, 0
div dword [length]
mov dword [laAve], eax

; Find the estimated median value lateralAreas
; lateralAreas when length is odd
; first value
mov eax, dword [lateralAreas] 
mov r8d, eax

; last value
mov esi, dword [length] 
dec esi
mov eax, dword [lateralAreas+esi*4]
mov r13d, eax

; middle value 
mov eax, dword [length]
mov edx, 0
mov ecx, 2
div ecx
mov r10d, eax
mov eax, dword [lateralAreas+r10d*4] 
mov r10d, eax 

; Sum the first, last, & middle value 
mov r12d, r8d    
add r12d, r13d   
add r12d, r10d   

; divide by 3 
mov eax, r12d
cdq             ; Sign extend 
mov ebx, 3
idiv ebx        ; eax = eax / 3

mov dword [laEstMed], eax
;********************************************************
;FIND THE TOTAL AREAS
;totalAreasMin:     52600
;totalAreasMax:     120891
;totalAreasEstMed:  84168
;totalAreasSum:     3747453
;totalAreasAve:     87150
; totalAreas [ n] = 
; BASES [N] * (2 * SLANTS [N] + BASES [N])
mov ecx, dword [length]
mov rsi, 0

calcLoopTwo:
	movzx r8d, byte [bases+rsi] ;bases[i]
	movzx r9d, word [slants+rsi*2] ;slants[i]

	;(PEMDAS)
	; (*) eax = 2 * slant
	mov eax, r9d
	mul dword [ddTwo] ;2
	; (+) eax = 2 * slant + base
	mov ebx, r8d ; stores r8d into ebx
	add eax, ebx ; adds eax and ebx 
	; (*) eax = base * (2 * slant + base)
	mul ebx 

	mov dword [totalAreas+rsi*4], eax 
	inc rsi
	loop calcLoopTwo

; Find MIN, MAX, SUM, & AVE FOR TOTAL AREAS
mov ecx, dword [length] 
mov rsi, 0

mov eax, dword [totalAreas]
mov dword [taMin], eax
mov dword [taMax], eax
mov dword [taSum], 0

statsLoopTwo:
mov eax, dword [totalAreas+rsi*4]
add dword [taSum], eax
cmp eax, dword [taMin]
jae notNewTaMin
mov dword [taMin], eax
notNewTaMin:
cmp eax, dword [taMax]
jbe notNewTaMax
mov dword [taMax], eax
notNewTaMax:
inc rsi
loop statsLoopTwo

;calc average
mov eax, dword [taSum]
mov edx, 0
div dword [length]
mov dword [taAve], eax

; Find the estimated med values total areas
mov eax, dword [totalAreas] 
mov r8d, eax

; last value
mov esi, dword [length] 
dec esi
mov eax, dword [totalAreas+esi*4]
mov r13d, eax

; middle value 
mov eax, dword [length]
mov edx, 0
mov ecx, 2
div ecx
mov r10d, eax
mov eax, dword [totalAreas+r10d*4] 
mov r10d, eax 

; Sum the first, last, & middle value 
mov r12d, r8d    
add r12d, r13d   
add r12d, r10d   

; divide by 3 
mov eax, r12d
cdq             ; Sign extend 
mov ebx, 3
idiv ebx        ; eax = eax / 3

mov dword [taEstMed], eax
;********************************************************
;FIND THE VOLUMES
;volumesMin:     683467
;volumesMax:     2935608
;volumesEstMed:  1515293
;volumesSum:     73901875
;volumesAve:     1718648
; volumes [ n] = 
; BASES [N]2 X HEIGHTS [N] / 3

; (P-E-M-D-A-S)
; First - expo base [n]2
; Second - multi * heights[n]
; Third - div / 3
    mov ecx, dword [length]       
    mov rsi, 0                  

calcLoopThreeStart:
    movzx eax, byte [bases + rsi]  

; FIRST
    mul eax                       
    mov ebx, eax    
; SECOND
    mov eax, [heights + rsi*4]     
    mul ebx                         
; THIRD 
    mov ebx, [ddThree]              
    div ebx                         

    mov [volumes + rsi*4], eax      
    inc rsi                        
    loop calcLoopThreeStart

; Find MIN, MAX, SUM, & AVE FOR TOTAL AREAS
mov ecx, dword [length] 
mov rsi, 0

mov eax, dword [volumes]
mov dword [vMin], eax
mov dword [vMax], eax
mov dword [vSum], 0

statsLoopThree:
mov eax, dword [volumes+rsi*4]
add dword [vSum], eax
cmp eax, dword [vMin]
jae notNewVMin
mov dword [vMin], eax
notNewVMin:
cmp eax, dword [vMax]
jbe notNewVMax
mov dword [vMax], eax
notNewVMax:
inc rsi
loop statsLoopThree

;calc average
mov eax, dword [vSum]
mov edx, 0
div dword [length]
mov dword [vAve], eax

;Find the estimated med values total areas
mov eax, dword [volumes] 
mov r8d, eax

; last value
mov esi, dword [length] 
dec esi
mov eax, dword [volumes+esi*4]
mov r13d, eax

; middle value 
mov eax, dword [length]
mov edx, 0
mov ecx, 2
div ecx
mov r10d, eax
mov eax, dword [volumes+r10d*4] 
mov r10d, eax 

; Sum the first, last, & middle value 
mov r12d, r8d    
add r12d, r13d   
add r12d, r10d   

; divide by 3 
mov eax, r12d
cdq             ; Sign extend 
mov ebx, 3
idiv ebx        ; eax = eax / 3

mov dword [vEstMed], eax
; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall
