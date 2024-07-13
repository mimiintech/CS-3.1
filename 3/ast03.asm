;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Three
;  Description: Assembler, Linker, and Debugger (basic arithmetic)
;

;  Focus on learning basic arithmetic operations
;  (add, subtract, multiply, and divide).
;  Ensure understanding of sign and unsigned operations.

; *****************************************************************
;  Data Declarations (provided).

section	.data
; -----
;  Define constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Assignment #3 data declarations

; byte data
; byte (8-bits) (al)
bNum1		db	31
bNum2		db	23
bNum3		db	19
bNum4		db	29
bNum5		db	18
bNum6		db	-37
bNum7		db	-24
bNum8		db	-14
bAns1		db	0
bAns2		db	0
bAns3		db	0
bAns4		db	0
bAns5		db	0
bAns6		db	0
bAns7		db	0
bAns8		db	0
bAns9		db	0
bAns10		db	0
; word (16-bits) (ax)
wAns11		dw	0
wAns12		dw	0
wAns13		dw	0
wAns14		dw	0
wAns15		dw	0
bAns16		db	0
bAns17		db	0
bAns18		db	0
bRem18		db	0
bAns19		db	0
bAns20		db	0
bAns21		db	0
bRem21		db	0

; word data
wNum1		dw	1348
wNum2		dw	659
wNum3		dw	327
wNum4		dw	125
wNum5		dw	649
wNum6		dw	-124
wNum7		dw	-253
wNum8		dw	-376
wAns1		dw	0
wAns2		dw	0
wAns3		dw	0
wAns4		dw	0
wAns5		dw	0
wAns6		dw	0
wAns7		dw	0
wAns8		dw	0
wAns9		dw	0
wAns10		dw	0
dAns11		dd	0
dAns12		dd	0
dAns13		dd	0
dAns14		dd	0
dAns15		dd	0
wAns16		dw	0
wAns17		dw	0
wAns18		dw	0
wRem18		dw	0
wAns19		dw	0
wAns20		dw	0
wAns21		dw	0
wRem21		dw	0

; double-word data
dNum1		dd	1528236
dNum2		dd	358397
dNum3		dd	126726
dNum4		dd	54372
dNum5		dd	7526
dNum6		dd	-3236
dNum7		dd	-2359
dNum8		dd	-4227
dAns1		dd	0
dAns2		dd	0
dAns3		dd	0
dAns4		dd	0
dAns5		dd	0
dAns6		dd	0
dAns7		dd	0
dAns8		dd	0
dAns9		dd	0
dAns10		dd	0
qAns11		dq	0
qAns12		dq	0
qAns13		dq	0
qAns14		dq	0
qAns15		dq	0
dAns16		dd	0
dAns17		dd	0
dAns18		dd	0
dRem18		dd	0
dAns19		dd	0
dAns20		dd	0
dAns21		dd	0
dRem21		dd	0

; quadword data
qNum1		dq	123456789
qNum2		dq	6215775
qNum3		dq	4912602
qNum4		dq	354879
qNum5		dq	197420
qNum6		dq	-135749
qNum7		dq	-374841
qNum8		dq	-531049
qAns1		dq	0
qAns2		dq	0
qAns3		dq	0
qAns4		dq	0
qAns5		dq	0
qAns6		dq	0
qAns7		dq	0
qAns8		dq	0
qAns9		dq	0
qAns10		dq	0
dqAns11		ddq	0
dqAns12		ddq	0
dqAns13		ddq	0
dqAns14		ddq	0
dqAns15		ddq	0
qAns16		dq	0
qAns17		dq	0
qAns18		dq	0
qRem18		dq	0
qAns19		dq	0
qAns20		dq	0
qAns21		dq	0
qRem21		dq	0

; *****************************************************************

section	.text
global _start
_start:

; ----------------------------------------------
; Byte Operations

; POSITIVE (8-BITS) (0-255) (al)
; unsigned byte additions
;	bAns1  = bNum2 + bNum3
mov al, byte [bNum2]
; 23
add al, byte [bNum3]
; 19 
mov byte [bAns1], al



; x/ub &bAns1 = 42
;	bAns2  = bNum1 + bNum3
mov	al, byte [bNum1]
; 31
add	al, byte [bNum3]
; 19
mov	byte [bAns2], al
; x/ub &bAns2 = 50 ?? 54
;	bAns3  = bNum4 + bNum3
mov al, byte [bNum4]
;29
add al, byte [bNum3]
;19
mov byte [bAns3], al 
;48
; x/ub &bAns3 = 48
; -----
; POSITIVE & NEGATIVE (8-BITS) (-128-+127) (al)
; signed byte additions
;	bAns4  = bNum5 + bNum7
mov al, byte [bNum5]
;18
add al, byte [bNum7]
;23
mov byte [bAns4], al
; 41
; x/db &bAns4 = 0
;	bAns5  = bNum6 + bNum8
mov al, byte [bNum6]
; -37
add al, byte [bNum8]
; -14
mov byte [bAns5], al
; -51
; x/db &bAns5 = 0
; -----
; POSITIVE (8-BITS) (0-255) (al)
; unsigned byte subtractions
;	bAns6  = bNum1 - bNum3
mov al, byte [bNum1]
;31
sub al, byte [bNum3]
;19
mov byte [bAns6], al
; 12


; x/ub &bAn6
;	bAns7  = bNum2 - bNum3
mov al, byte [bNum2]
; 23
sub al, byte [bNum3]
; 19
mov byte [bAns7], al
; 4
; x/ub &bAns7
;	bAns8  = bNum3 - bNum4
mov al, byte [bNum3]
; 19 
sub al, byte [bNum4]
; 29
mov byte [bAns8], al
; -10
; x/ub &bAns8 = 0
; -----
; POSITIVE & NEGATIVE (8-BITS) (-128-+127) (al)
; signed byte subtraction
;	bAns9  = bNum5 - bNum8
mov al, byte [bNum5]
; 18
sub al, byte [bNum8]
; -14
mov byte [bAns9], al
; 4
;x/db &bAns9 = 0
;	bAns10 = bNum7 - bNum6
mov al, byte [bNum7]
; -24
sub al, byte [bNum6]
; -37
mov byte [bAns10], al
; -61
; x/db &bAns10 = 0
; -----
; POSITIVE (8-BITS) (0-255) (al) (mul)
; unsigned byte multiplication
;	wAns11  = bNum1 * bNum4
mov al, byte [bNum1]
mul byte [bNum4]
mov word [wAns11], ax


;	wAns12  = bNum2 * bNum2
mov al, byte [bNum2]
mul byte [bNum2]
mov word [wAns12], ax
;	wAns13  = bNum3 * bNum2
mov al, byte [bNum3]
mul byte [bNum2]
mov word [wAns13], ax
; -----
; signed byte multiplication
; POSITIVE & NEGATIVE (8-BITS) (-128-+127) (al) (imul)
;	wAns14  = bNum5 * bNum6
mov al, byte [bNum5]
imul byte [bNum6]
mov word [wAns14], ax
;	wAns15  = bNum7 * bNum8
mov al, byte [bNum7]
imul byte [bNum8]
mov word [wAns15], ax
; -----
; POSITIVE (8-BITS) (0-255) (al) (div)
; unsigned byte division
;	bAns16 = bNum1 / bNum3
mov ax, 0
mov al, byte [bNum1]
div byte [bNum3]
mov byte [bAns16], al

;	bAns17 = bNum4 / bNum2
mov ax, 0
mov al, byte [bNum4]
div byte [bNum2]
mov byte [bAns17], al

;	bAns18 = wNum3 / bNum4
mov ax, 0
mov ax, word [wNum3]
div al, byte [bNum4]
mov byte [bAns18], al
;	bRem18 = wNum3 % bNum4
mov ax, word [wNum3]
div al, byte [bNum4]
mov byte [bRem18], ah
; -----
; signed byte division
;	bAns19 = bNum5 / bNum8
mov al, byte [bNum5]
cbw 
; byte (cbw) converts byte (al) into word (ax)
idiv byte [bNum8]
mov byte [bAns19], al
;	bAns20 = bNum6 / bNum7
mov al, byte [bNum6]
cbw
; byte (cbw) converts byte (al) into word (ax)
idiv byte [bNum7]
mov byte [bAns20], al
;	bAns21 = wNum5 / bNum8
mov ax, word [wNum5]
cwd
; word (cwd) converts word (ax) into dword (dx) dx:ax
idiv byte [bNum8]
mov byte [bAns21], al
;	bRem21 = wNum5 % bNum8
mov ax, word [wNum5]
cwde
; word (cwde) converts word (ax) into dword (eax)
idiv byte [bNum8]
mov byte [bRem21], al
mov byte [bRem21], ah 




; *****************************************
; Word Operations
; (16-bits) (ax)
; -----
; unsigned word additions
;	wAns1  = wNum4 + wNum1
mov ax, word [wNum4]
add ax, word [wNum1]
mov word [wAns1], ax
;	wAns2  = wNum3 + wNum2
mov ax, word [wNum3]
add ax, word [wNum2]
mov word [wAns2], ax
;	wAns3  = wNum3 + wNum3
mov ax, word [wNum3]
add ax, word [wNum3]
mov word [wAns3], ax
; -----
; signed word additions
;	wAns4  = wNum5 + wNum7
mov ax, word [wNum5]
add ax, word [wNum7]
mov word [wAns4], ax
;	wAns5  = wNum6 + wNum8
mov ax, word [wNum6]
add ax, word [wNum8]
mov word [wAns5], ax
; -----
; unsigned word subtractions
;	wAns6  = wNum1 - wNum3
mov ax, word [wNum1]
sub ax, word [wNum3]
mov word [wAns6], ax
;	wAns7  = wNum2 - wNum4
mov ax, word [wNum2]
sub ax, word [wNum4]
mov word [wAns7], ax
;	wAns8  = wNum4 - wNum2
mov ax, word [wNum4]
sub ax, word [wNum2]
mov word [wAns8], ax

; -----
; signed word subtraction
;	wAns9  = wNum5 - wNum8
mov ax, word [wNum5]
sub ax, word [wNum8]
mov word [wAns9], ax
;	wAns10  = wNum6 - wNum7
mov ax, word [wNum6]
sub ax, word [wNum7]
mov word [wAns10], ax
; -----
; unsigned word multiplication
;	dAns11 = wNum1 * wNum4
; 16 * 16 = 32 dx:ax (2)
mov ax, word [wNum1]
mul word [wNum4]

mov word [dAns11], ax
mov word [dAns11+2], dx
;	dAns12  = wNum4 * wNum4
mov ax, word [wNum4]
mul word [wNum4]
mov word [dAns12], ax
mov word [dAns12+2], dx
;	dAns13  = wNum2 * wNum3
mov ax, word [wNum2]
mul word [wNum3]
mov word [dAns13], ax
mov word [dAns13+2], dx
; -----
; signed word multiplication
;	dAns14  = wNum5 * wNum7
mov ax, word [wNum5]
imul word [wNum7]
mov word [dAns14], ax
mov word [dAns14+2], dx
;	dAns15  = wNum6 * wNum8
mov ax, word [wNum6]
imul word [wNum8]
mov word [dAns15], ax
mov word [dAns15+2], dx
; -----
; unsigned word division
;	wAns16 = wNum2 / wNum3
mov ax, word [wNum2]
mov dx, 0
div word [wNum3]
mov word [wAns16], ax
;	wAns17 = wNum1 / wNum4
mov ax, word [wNum1]
mov dx, 0
div word [wNum4]
mov word [wAns17], ax
;	wAns18 = dNum1 / wNum2
;	wRem18 = dNum1 % wNum2 
;(dword) (eax) (dNum1)
;1528236
; (word) (ax) (wNum2)
;659
mov ax, word [dNum1]
mov dx, word [dNum1+2]
div word [wNum2]
mov word [wAns18], ax
mov word [wRem18], dx
; -----
; signed word division
;	wAns19 = wNum5 / wNum8
mov ax, word [wNum5]
cwd
idiv word [wNum8]
mov word [wAns19], ax
;	wAns20 = wNum7 / wNum6
mov ax, word [wNum7]
cwd
idiv word [wNum6]
mov word [wAns20], ax
;	wAns21 = dNum5 / wNum7
mov ax, word [dNum5]
cwd 
;mov ax, word [dNum5+2]
idiv word [wNum7]
mov word [wAns21], ax
mov word [wRem21], dx
;	wRem21 = dNum5 % wNum7

; *****************************************
; Double-Word Operations
; -----
; unsigned double-word additions
;	dAns1  = dNum1 + dNum4
mov eax, dword [dNum1]
add eax, dword [dNum4]
mov dword [dAns1], eax
;	dAns2  = dNum2 + dNum3
mov eax, dword [dNum2]
add eax, dword [dNum3]
mov dword [dAns2], eax
;	dAns3  = dNum3 + dNum4
mov eax, dword [dNum3]
add eax, dword [dNum4]
mov dword [dAns3], eax

; -----
; signed double-word additions
;	dAns4  = dNum5 + dNum8
mov eax, dword [dNum5]
add eax, dword [dNum8]
mov dword [dAns4], eax
;	dAns5  = dNum6 + dNum7
mov eax, dword [dNum6]
add eax, dword [dNum7]
mov dword [dAns5], eax

; -----
; unsigned double-word subtractions
;	dAns6  = dNum1 - dNum4
mov eax, dword [dNum1]
sub eax, dword [dNum4]
mov dword [dAns6], eax

;	dAns7  = dNum2 - dNum3
mov eax, dword [dNum2]
sub eax, dword [dNum3]
mov dword [dAns7], eax

;	dAns8  = dNum3 - dNum4
mov eax, dword [dNum3]
sub eax, dword [dNum4]
mov dword [dAns8], eax

; -----
; signed double-word subtraction
;	dAns9  = dNum5 - dNum7
mov eax, dword [dNum5]
sub eax, dword [dNum7]
mov dword [dAns9], eax
;	dAns10 = dNum6 – dNum8
mov eax, dword [dNum6]
sub eax, dword [dNum8]
mov dword [dAns10], eax

; -----
; unsigned double-word multiplication
;	qAns11  = dNum1 * dNum2
mov eax, dword [dNum1]
mul dword [dNum2]
mov dword [qAns11], eax
mov dword [qAns11+4], edx
;	qAns12  = dNum3 * dNum4
mov eax, dword [dNum3]
mul dword [dNum4]
mov dword [qAns12], eax
mov dword [qAns12+4], edx
;	qAns13  = dNum2 * dNum3
mov eax, dword [dNum2]
mul dword [dNum3]
mov dword [qAns13], eax
mov dword [qAns13+4], edx
; -----
; signed double-word multiplication
;	qAns14  = dNum5 * dNum6
mov eax, dword [dNum5]
imul dword [dNum6]
mov dword [qAns14], eax
mov dword [qAns14+4], edx
;	qAns15  = dNum7 * dNum8
mov eax, dword [dNum7]
mul dword [dNum8]
mov dword [qAns15], eax
mov dword [qAns15+4], edx
; -----
; unsigned double-word division
;	dAns16 = dNum1 / dNum4
;	dAns17 = dNum2 / dNum3
mov edx, 0
mov eax, dword [dNum1]
div dword [dNum4]
mov dword [dAns16], eax

mov edx, 0
mov eax, dword [dNum2]
div dword [dNum3]
mov dword [dAns17], eax

;	dAns18 = qAns12 / dNum4
;	dRem18 = qAns12 % dNum4
mov	eax, dword [qAns12]
mov	edx, dword [qAns12+4]

div	dword [dNum4]
mov	dword [dAns18], eax
mov dword [dRem18], edx

; -----
; signed double-word division
;	dAns19 = dNum5 / dNum8
mov eax, dword [dNum5]
cdq
idiv dword [dNum8]
mov dword [dAns19], eax 
;	dAns20 = dNum6 / dNum7
mov eax, dword [dNum6]
cdq 
idiv dword [dNum7]
mov dword [dAns20], eax 
;	dAns21 = qAns12 / dNum8
;	dRem21 = qAns12 % dNum8
mov eax, dword [qAns12]
mov edx, dword [qAns12+4]

idiv dword [dNum8]
mov dword [dAns21], eax
mov dword [dRem21], edx
; *****************************************
; QuadWord Operations

; -----
; unsigned quadword additions
;	qAns1  = qNum1 + qNum3
mov rax, qword [qNum1]
add rax, qword [qNum3]
mov qword [qAns1], rax
;	qAns2  = qNum2 + qNum4
mov rax, qword [qNum2]
add rax, qword [qNum4]
mov qword [qAns2], rax
;	qAns3  = qNum3 + qNum4
mov rax, qword [qNum3]
add rax, qword [qNum4]
mov qword [qAns3], rax
; -----
; signed quadword additions
;	qAns4  = qNum5 + qNum8
mov rax, qword [qNum5]
add rax, qword [qNum8]
mov qword [qAns4], rax
;	qAns5  = qNum6 + qNum7
mov rax, qword [qNum6]
add rax, qword [qNum7]
mov qword [qAns5], rax
; -----
; unsigned quadword subtractions
;	qAns6  = qNum1 - qNum2
mov rax, qword [qNum1]
sub rax, qword [qNum2]
mov qword [qAns6], rax
;	qAns7  = qNum3 - qNum4
mov rax, qword [qNum3]
sub rax, qword [qNum4]
mov qword [qAns7], rax
;	qAns8  = qNum2 - qNum4
mov rax, qword [qNum2]
sub rax, qword [qNum4]
mov qword [qAns8], rax
; -----
; signed quadword subtraction
;	qAns9  = qNum6 - qNum7
mov rax, qword [qNum6]
sub rax, qword [qNum7]
mov qword [qAns9], rax
;	qAns10 = qNum5 - qNum8
mov rax, qword [qNum5]
sub rax, qword [qNum8]
mov qword [qAns10], rax
; -----
; unsigned quadword multiplication
;	dqAns11  = qNum1 * qNum2
mov rax, qword [qNum1]
mul qword [qNum2]
mov qword [dqAns11], rax
mov qword [dqAns11+8], rdx
;	dqAns12  = qNum3 * qNum4
mov rax, qword [qNum3]
mul qword [qNum4]
mov qword [dqAns12], rax
mov qword [dqAns12+8], rdx
;	dqAns13  = qNum2 * qNum3
mov rax, qword [qNum2]
mul qword [qNum3]
mov qword [dqAns13], rax
mov qword [dqAns13+8], rdx
; -----
; signed quadword multiplication
;	dqAns14  = qNum5 * qNum8
mov rax, qword [qNum5]
imul qword [qNum8]
mov qword [dqAns14], rax
mov qword [dqAns14+8], rdx
;	dqAns15  = qNum6 * qNum7
mov rax, qword [qNum6]
imul qword [qNum7]
mov qword [dqAns15], rax
mov qword [dqAns15+8], rdx
; -----
; unsigned quadword division
;	qAns16 = qNum1 / qNum4
mov rdx, 0
mov rax, qword [qNum1]
div qword [qNum4]
mov qword [qAns16], rax
;	qAns17 = qNum2 / qNum3
mov rdx, 0
mov rax, qword [qNum2]
div qword [qNum3]
mov qword [qAns17], rax
;	qAns18 = dqAns12 / qNum2
;	qRem18 = dqAns12 % qNum2
mov	rax, qword [dqAns12]
mov	rdx, qword [dqAns12+8]
div	qword [qNum2]
mov	qword [qAns18], rax
mov qword [qRem18], rdx
; -----
; signed quadword division
;	qAns19 = qNum5 / qNum6
mov rax, qword [qNum5]
cqo
idiv qword [qNum6]
mov qword [qAns19], rax 
;	qAns20 = qNum7 / qNum6
mov rax, qword [qNum7]
cqo
idiv qword [qNum6]
mov qword [qAns20], rax 
;	qAns21 = dqAns12 / qNum8
;	qRem21 = dqAns12 % qNum8
mov rax, qword [dqAns12]
mov rdx, qword [dqAns12+8]

idiv qword [qNum8]
mov qword [qAns21], rax
mov qword [qRem21], rdx
; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall

