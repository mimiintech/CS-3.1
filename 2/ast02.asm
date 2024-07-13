;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: Assignment Two
;  Description: Data Representation (binary, decimal, hex)
;

; *****************************************************************
;  Static Data Declarations (initialized)

section	.data
; -----
;  Define standard constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Initialized Static Data Declarations.
;	Place data declarations here...

bVar1 db 37
bVar2 db 51
bAns1 db 0
bAns2 db 0
wVar1 dw 2654
wVar2 dw 1873
wAns1 dw 0
wAns2 dw 0
dVar1 dd 164126937
dVar2 dd 102512521
dVar3 dd -15476
dAns1 dd 0
dAns2 dd 0
qVar1 dq 123456789112
flt1 dd -15.125
flt2 dd 11.25
tao dd 2.71828
myClass db "CS-218", NULL
saying db "May the force be with you.", NULL
myName db "Michelle Silva", NULL


; ----------------------------------------------
;  Uninitialized Static Data Declarations.

section	.bss

;	Place data declarations for uninitialized data here...
;	(i.e., large arrays that are not initialized)


; *****************************************************************

section	.text
global _start
_start:


; -----
;	YOUR CODE GOES HERE...
; BYTE EXAMPLE (al)
;bAns1 = bVar1 + bVar2
mov al, byte [bVar1]
add al, byte [bVar2]
mov byte [bAns1], al

; BYTE EXAMPLE (al)
;bAns2 = bVar1 - bVar2
mov al, byte [bVar1]
sub al, byte [bVar2]
mov byte [bAns2], al

; WORD EXAMPLE (ax)
;wAns1 = wVar1 + wVar2
mov ax, word [wVar1]
add ax, word [wVar2]
mov word [wAns1], ax

; WORD EXAMPLE (ax)
;wAns2 = wVar1 - wVar2
mov ax, word [wVar1]
sub ax, word [wVar2]
mov word [wAns2], ax

; D-WORD EXAMPLE (EAX)
;dAns1 = dVar1 + dVar2
mov eax, dword [dVar1]
add eax, dword [dVar2]
mov dword [dAns1], eax

; D-WORD EXAMPLE (EAX)
;dAns2 = dVar1 - dVar2
mov eax, dword [dVar1]
sub eax, dword [dVar2]
mov dword [dAns2], eax
; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit		; call call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS	; return code of 0 (no error)
	syscall

