; *****************************************************************
;  Name: Michelle Silva
;  NSHE_ID: 5006988436
;  Section: 1001 & 1002
;  Assignment: 10
;  Description: Become more familiar with data representation, program control instructions, function
;handling, stacks, floating point operations, and operating system interaction.


; -----
;  Function: getParams()
;	Gets, checks, converts, and returns command line arguments.

;  Function: drawTorus()
;	Plots torus formulas

;  Function: cvtnonaryint()
;	Convert nonary string to integer

; ---------------------------------------------------------
;  Macro to convert ASCII/nonary value into an integer.
;  Reads <string>, convert to integer and place in <integer>
;  Arguments:
;	%1 -> <string>, register -> string address
;	%2 -> <integer>, register -> result

;  Macro usage
;	anonary2int  <string-address>, <integer-variable>
%macro	aNonary2int	2
	mov rax, 0
	mov dword [%2], 0
	mov r10, 0

	%%conversion:
	mov r10b, byte [%1]
	sub r10b, '0'

	mov eax, dword [%2]
	imul eax, 9
	mov dword [%2], eax

	add dword [%2], r10d
	inc %1
	cmp byte [%1], NULL
	jne %%conversion
%endmacro
; ---------------------------------------------------------

section  .data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; successful operation
NOSUCCESS	equ	1

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; code for read
SYS_write	equ	1			; code for write
SYS_open	equ	2			; code for file open
SYS_close	equ	3			; code for file close
SYS_fork	equ	57			; code for fork
SYS_exit	equ	60			; code for terminate
SYS_creat	equ	85			; code for file open/create
SYS_time	equ	201			; code for get time

LF		equ	10
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

; -----
;  OpenGL constants

GL_COLOR_BUFFER_BIT	equ	16384
GL_POINTS		equ	0
GL_POLYGON		equ	9
GL_PROJECTION		equ	5889

GLUT_RGB		equ	0
GLUT_SINGLE		equ	0

; -----
;  Define program specific constants.

R1_MIN		equ	1			; 1(10) = 1(9)
R1_MAX		equ	100			; 100(10) = 121(9)

R2_MIN		equ	1			; 1(10) = 1(9)
R2_MAX		equ	100			; 100(10) = 121(9)

H_MIN		equ	100			; 100(10) = 121(9)
H_MAX		equ	1000			; 1000(10) = 1331(9)

W_MIN		equ	100			; 1(10) = 121(9)
W_MAX		equ	1000			; 1000(10) = 1331(9)

CL_MIN		equ	50			; 50(10) = 55(9)
CL_MAX		equ	0xffffff		; 16777215(10) = 34511010(9)

; -----
;  Variables for getRadii procedure.

errUsage	db	"Usage:  ./torus -r1 <nonaryNumber> "
		db	"-r2 <nonaryNumber> -h <nonaryNumber> "
		db	"-w <nonaryNumber> -cl <nonaryNumber>"
		db	LF, NULL
errBadCL	db	"Error, invalid or incomplete command line arguments."
		db	LF, NULL

errR1sp		db	"Error, radius 1 specifier incorrect."
		db	LF, NULL
errR1value	db	"Error, radius 1 value must be between 1(9) "
		db	"and 121(9)."
		db	LF, NULL

errR2sp		db	"Error, radius 2 specifier incorrect."
		db	LF, NULL
errR2value	db	"Error, radius 2 value must be between 1(9) "
		db	"and 121(9)."
		db	LF, NULL

errHsp		db	"Error, height specifier incorrect."
		db	LF, NULL
errHvalue	db	"Error, height value must be between 121(9) "
		db	"and 1331(9)."
		db	LF, NULL

errWsp		db	"Error, width specifier incorrect."
		db	LF, NULL
errWvalue	db	"Error, width must be between 121(9) "
		db	"and 1331(9)."
		db	LF, NULL

errCLsp		db	"Error, color specifier incorrect."
		db	LF, NULL
errCLvalue	db	"Error, color value must be between 55(9) "
		db	"and 34511010(9)."
		db	LF, NULL

; -----
;  Variables for torus routine.

pi		dd	3.14159265358979323846
fltZero		dd	0.0
; floating 
fltOne		dd	1.0
fltOnePtFive	dd	1.5
fltTwo		dd	2.0
fltTen		dd	10.0
fltSeventy	dd	70.0
;*********************
fltTmp1		dd	0.0
fltTmp2		dd	0.0

temp1		dd	0.0
temp2		dd	0.0
;*********************

x		dd	0.0			; current x
y		dd	0.0			; current y
z		dd	0.0			; current z

t		dd	0.0			; t=0.0
u		dd	0.0			; u=0.0

rd1		dd	0.0			; radius 1 (float)
rd2		dd	0.0			; radius 2 (float)

iterations	dd	0			; set based on tStep
temp3 		dd	0.0 
; ------------------------------------------------------------

section  .text

; -----
;  External references for openGL routines.

extern	glutInit, glutInitDisplayMode, glutInitWindowSize, glutInitWindowPosition
extern	glutCreateWindow, glutMainLoop
extern	glutDisplayFunc, glutIdleFunc, glutReshapeFunc, glutKeyboardFunc
extern	glutSwapBuffers, gluPerspective, glutPostRedisplay
extern	glClearColor, glClearDepth, glDepthFunc, glEnable, glShadeModel
extern	glClear, glLoadIdentity, glMatrixMode, glViewport
extern	glTranslatef, glRotatef, glBegin, glEnd, glVertex3f, glColor3f
extern	glVertex2f, glVertex2i, glColor3ub, glOrtho, glFlush, glVertex2d
extern	glPushMatrix, glPopMatrix, glPointSize, glRotatef

extern	cosf, sinf

; ******************************************************************
;  Function: getParams()
;	Gets radius 1, radius 2, height, width, and color values
;	from the command line.

;	Performs error checking, converts ASCII/Undecimal string
;	to integer.  Required command line format (fixed order):
;	  "-r1 <unDecimal> -r2 <unDecimal> -h <unDecimal> 
;			-w <unDecimal> -cl <unDecimal"

; -----
;  Arguments:
;	- ARGC ;rdi 
;	- ARGV  ;rsi 
;	- radius 1, double-word int, address ;rdx
;	- radius 2, double-word int, address ;rcx
;	- height, double-word int, address ;r8
;	- width, double-word int, address ;r9
;	- color, double-word int, address ;qword [rbp+16]

; ./torus -r1 40 -r2 7 -h 800 -w 800 -cl 21664283
;	0		1 2	  3  4  5  6   7  8   9  10
; Args Total = 11 
global getParams
getParams:
	push rbp
	mov	rbp, rsp
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
	cmp rdi, 11
	jb ErrorInvalidArgs
	cmp rdi, 11
	ja ErrorInvalidArgs
;./torus -r3 18 -r2 5 -h 600 -w 600 -cl 34401103 extra 
;**************CHECKING INPUT SECTION*****************
; Check the first argument
; "-r1 <unDecimal>" 
; If argv[1] not equal "-r1" NULL jmp error 
;*****************************
	; moving ARGV into r12 
	mov r12, rsi 
	; moving radius 1 into r13
	mov r13, rdx 
	; moving radius 2 into r14 
	mov r14, rcx 
	; moving height into r15
	mov r15, r8
;*****************************
	mov rbx, qword [r12+8] 
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorR1Specifier
	mov al, byte [rbx+1] ;check "r"
	cmp al, "r"
	jne ErrorR1Specifier
	mov al, byte [rbx+2] ;check "1"
	cmp al, "1"
	jne ErrorR1Specifier
	mov al, byte [rbx+3] ;check NULL
	cmp al, NULL 
	jne ErrorR1Specifier
; If argv[2] not equal check/convert
; ASCII/Base 9 jmp error 
; If valid, vertify range 
; if < min || > max jmp error 
	mov rbx, qword [r12+16]
;*************************
; Convert ASCII to integer
	mov rbx, qword [r12+16]
; call aNonary2int
	aNonary2int rbx, r13
; Check if within MIN & MAX
	cmp eax, 0
	jl ErrorAValue
	cmp eax, R1_MIN
	jb ErrorAValue
; The string was valid but out of range
	cmp eax, R1_MAX
	ja ErrorAValue
; The string was valid but out of range
	mov dword [r13], eax

;****************************************
; Check the second argument
; "-r2 <unDecimal>"
	mov rbx, qword [r12+24]
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorR2Specifier
	mov al, byte [rbx+1] ;check "r"
	cmp al, "r"
	jne ErrorR2Specifier
	mov al, byte [rbx+2] ;check "2"
	cmp al, "2"
	jne ErrorR2Specifier
	mov al, byte [rbx+3] ;check NULL
	cmp al, NULL 
	jne ErrorR2Specifier
;****************************
;	Convert ASCII to integer
	mov rbx, qword [r12+32]
	;call aNonary2int
	aNonary2int rbx, r14
	cmp dword [r14], R2_MIN
	jb ErrorBValue
	cmp dword [r14], R2_MAX
	ja ErrorBValue 
;***************************************
; Check the third argument
; "-h <unDecimal>"
	mov rbx, qword [r12+40]
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorHSpecifier
	mov al, byte [rbx+1] ;check "h"
	cmp al, "h"
	jne ErrorHSpecifier
	mov al, byte [rbx+2] ;check NULL
	cmp al, NULL 
	jne ErrorHSpecifier
;***************************
;	Convert ASCII to integer
	mov rbx, qword [r12+48]
	aNonary2int rbx, r8

; Check if within MIN & MAX
	cmp dword [r8], H_MIN
	jb ErrorHeightValue
	cmp dword [r8], H_MAX
	ja ErrorHeightValue
;****************************************
; Check the fourth argument
; "-w <unDecimal>"
	mov rbx, qword [r12+56]
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorWidthSpecifier
	mov al, byte [rbx+1] ;check "w"
	cmp al, "w"
	jne ErrorWidthSpecifier
	mov al, byte [rbx+2] ;check NULL
	cmp al, NULL 
	jne ErrorWidthSpecifier
;*******************************
;	Convert ASCII to integer
	mov rbx, qword [r12+64]
	;call aNonary2int
	aNonary2int rbx, r9 
; Check if within MIN & MAX
	cmp dword [r9], W_MIN
	jb ErrorWidthSpecifierRange
	cmp dword [r9], W_MAX
	ja ErrorWidthSpecifierRange
;*******************************************
; Check the fifth argument
; "-cl <unDecimal"
	mov rbx, qword [r12+72]
	mov al, byte [rbx] ;check "-"
	cmp al, "-"
	jne ErrorDrawColorSpecifier
	mov al, byte [rbx+1] ;check "c"
	cmp al, "c"
	jne ErrorDrawColorSpecifier
	mov al, byte [rbx+2] ;check "l"
	cmp al, "l"
	jne ErrorDrawColorSpecifier
	mov al, byte [rbx+3] ;check NULL
	cmp al, NULL 
	jne ErrorDrawColorSpecifier
;********************************
	mov rbx, qword [r12+80]
	;call aNonary2int
	mov r11, qword [rbp+16]
	aNonary2int rbx, r11 
; Check if within MIN & MAX
	cmp dword [r11], CL_MIN
	jb ErrorDrawColorValue
; The string was valid but out of range
	cmp dword [r11], CL_MAX
	ja ErrorDrawColorValue
; The string was valid but out of range

jmp NoErrorsCleanup
;**************************************
; ERROR SECTION
; Usage:  ./torus -r1 <nonaryNumber> -r2 <nonaryNumber> -h <nonaryNumber> -w <nonaryNumber> -cl <nonaryNumber>
ErrorUsageMessage:
mov rdi, errUsage
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
; Error, invalid or incomplete command line arguments.
mov rdi, errBadCL
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
ErrorInvalidArgs:
; Error, invalid or incomplete command line arguments.
mov rdi, errBadCL
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
ErrorR1Specifier:
;Error, radius 1 specifier incorrect.
mov rdi, errR1sp
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
ErrorAValue:
;Error, radius 1 value must be between 1(9) and 121(9).
mov rdi, errR1value
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
ErrorR2Specifier:
;Error, radius 2 specifier incorrect.
mov rdi, errR2sp
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
ErrorBValue:
; Error, radius 2 value must be between 1(9) and 121(9).
mov rdi, errR2value
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
ErrorHSpecifier:
; Error, height specifier incorrect.
mov rdi, errHsp
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
ErrorHeightValue:
; Error, height value must be between 121(9) and 1331(9).
mov rdi, errHvalue
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
ErrorWidthSpecifier:
; Error, width specifier incorrect.
mov rdi, errWsp
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
ErrorWidthSpecifierRange:
; Error, width must be between 121(9) and 1331(9).
mov rdi, errWvalue
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
ErrorDrawColorSpecifier:
; Error, color specifier incorrect.
mov rdi, errCLsp
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
ErrorDrawColorValue:
; Error, color value must be between 55(9) and 34511010(9).
mov rdi, errCLvalue
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
; ******************************************************************
;  Function: cvtnonary2int()
;  Boolean function to convert nonary string to integer.
global cvtnonary2int
cvtnonary2int:
ret 
; ******************************************************************
;  Function: drawTorus()
;  Torus Plotting Function.

; -----
;  Basic flow:
;	set openGL drawing initializations
;	set draw color (i.e., glColor3ub)
;	convert integer values to float for calculations
;	calculate number of iterations (for loops)

;	for (double t=0.0; t<(2.0*pi); t+=tStep) {
;		for (double u=0.0; u<(2.0*pi); u+=tStep) {

;			x = 70.0 * (cos(t) * (radius1/10 + (radius2/10 * cos(u))));
;			y = 70.0 * (sin(t) * (radius1/10 + (radius2/10 * cos(u))));
;			z = 70.0 * (radius2/10 * sin(u));
;		        glVertex3f(x, y, z);
;		}
;	}
;	close openGL plotting (i.e., glEnd and glFlush)

;  The loop is from 0.0 to 2*pi by tStep.
;   Note, tStep is define in main and accessible via below common statement.

; -----
;  Global variables accessed
;	There are defined and set in the main, accessed herein by
;	name as per the below declarations.

common	viewAngle	1:4		; viewAngle, dword, float value
common	tipAngle	1:4		; tipAngle, dword, float value
common	tStep		1:4		; tStep (increment)
common	radius1		1:4		; radius 1, dword, [integer value]
common	radius2		1:4		; radius 2, dword, [integer value]
common	color		1:4		; color code letter, byte, [ASCII value]

global drawTorus
drawTorus:
; PUSH MAINTAINED REGISTERS
push r12 
;push r13 
;**********************************
; -----
;  Set openGL drawing initializations
	; glClear(GL_COLOR_BUFFER_BIT);
	mov	rdi, GL_COLOR_BUFFER_BIT
	call	glClear
	; glPushMatrix();
	call	glPushMatrix
	; glRotatef(viewAngle, 1.0, 0.0, 0.0);
	movss	xmm0, dword [viewAngle]
	movss	xmm1, dword [fltOne]
	movss	xmm2, dword [fltZero]
	movss	xmm3, dword [fltZero]
	call	glRotatef
	; glRotatef(tipAngle, 0.0, 1.0, 0.0);
	movss	xmm0, dword [tipAngle]
	movss	xmm1, dword [fltZero]
	movss	xmm2, dword [fltOne]
	movss	xmm3, dword [fltZero]
	call	glRotatef
	; glPointSize(1.5);
	movss	xmm0, dword [fltOnePtFive]
	call	glPointSize
	; glBegin(GL_POINTS);
	mov	rdi, GL_POINTS
	call	glBegin
;**********************************
; -----
;  Set draw color(r,g,b)
;call glColor3ub(red, green, blue); // set color
mov eax, dword [color] ;get the color 32-bits
movzx rdx, al
shr eax, 8
movzx rsi, al
shr eax, 8
movzx rdi, al 
call glColor3ub
;**********************************
; -----CONVERSIONS TO FLOAT
;  Convert integers to floats for use in formulas.
; For conversion use:
; get ints, convert to floats
cvtsi2ss xmm0, dword [radius1] ;get radius 1 int value 
movss dword [rd1], xmm0 ;store it into rd1 (float)

cvtsi2ss xmm0, dword [radius2] ;get radius 2 int value
movss dword [rd2], xmm0 ;store into rd2 (float)
; -------------------------------------------------------------------
;  Main plotting loops
;  Calculate iterations (2 * pi / tStep)
; Each loop requires (2.0 * pi) / tStep iterations
movss xmm0, dword [pi] ;get pi 
mulss xmm0, dword [fltTwo] ; x 2
;divss xmm0, dword [tStep] ;/tStep
;convert float to int 
;cvtss2si eax, xmm0 
; store into register eax 
movss dword [temp3], xmm0
;movss dword [iterations], xmm0 
; iterations = (2*pi/tStep)

;PRESERVED COUNTERS 
;mov r12, 0
;mov r13, 0

; INITIALIZES T & U
movss xmm0, dword [fltZero]
; moves the float (t=0.0) into the register
movss dword [t], xmm0

TLoop:
movss xmm0, dword [fltZero]
movss dword [u], xmm0 
;mov r12, 0 ;resets preserved register
movss xmm1, dword [t]
addss xmm1, dword [tStep]
movss dword [t], xmm1 
ucomiss xmm1, dword [temp3]
jae TLoopEnd
 
ULoop:
movss xmm1, dword [u]
addss xmm1, dword [tStep]
movss dword [u], xmm1 
ucomiss xmm1, dword [temp3]
jae ULoopEnd

;  Calculate x,y,z 
; X = 70.0 × [ cos( t ) × ( radius 1/10 + ( radius 2/10 × cos( u)))]
; Function call
movss xmm0, dword [t]
call cosf ;cos(t)
movss dword [fltTmp1], xmm0
; Function call 
movss xmm0, dword [u]
call cosf ;cos(u)
movss dword [fltTmp2], xmm0
;**********************************
; rd1 = float (rad1)/10
movss xmm0, dword [rd1]
divss xmm0, dword [fltTen]
movss dword [temp1], xmm0
;movss dword [rd1], xmm0 
; rd2 = float (rad1)/10
movss xmm0, dword [rd2]
divss xmm0, dword [fltTen]
movss dword [temp2], xmm0
;movss dword [rd2], xmm0 
;****************************
;movss xmm1, dword [rd2]
movss xmm1, dword [temp2]
mulss xmm1, dword [fltTmp2]
;addss xmm1, dword [rd1]
addss xmm1, dword [temp1]
mulss xmm1, dword [fltTmp1]
mulss xmm1, dword [fltSeventy]
movss dword [x], xmm1 
;**********************************
; Y = 70.0 × [ sin(t) × ( radius 1/10 + ( radius 2/10 × cos (u)))]
movss xmm0, dword [t]
call sinf ;sin(t)
movss dword [fltTmp1], xmm0
; Function call 
movss xmm0, dword [u]
call cosf ;cos(u)
movss dword [fltTmp2], xmm0
;**********************************
;movss xmm1, dword [rd2]
movss xmm1, dword [temp2]
mulss xmm1, dword [fltTmp2]
;addss xmm1, dword [rd1]
addss xmm1, dword [temp1]
mulss xmm1, dword [fltTmp1]
mulss xmm1, dword [fltSeventy]
movss dword [y], xmm1 
;**********************************
; Z = 70.0 × [radius 2/ 10 × sin(u)]
movss xmm0, dword [u]
call sinf ;sin(u)
movss dword [fltTmp2], xmm0
;********************
;movss xmm1, dword [rd2]
movss xmm1, dword [temp2]
mulss xmm1, dword [fltTmp2]
mulss xmm1, dword [fltSeventy]
movss dword [z], xmm1 
;**********************************
; OPENGL CALL TO PLOT 
;call glVertex3f(x, y, z); // plot point (float
; plot (x,y,z) => glVertex3d(x,y,z)
movss xmm0, dword [x]
movss xmm1, dword [y]
movss xmm2, dword [z]
call glVertex3f 
;*********************************
;incremented by tStep for each iteration
; u += tStep
;movss xmm1, dword [fltZero]
;addss xmm1, dword [tStep]
;addss xmm1, dword [u]
;movss dword [u], xmm1 
; compares with iterations 
; being stored as a int 
;inc r12 ;preserved counter
;ucomiss xmm1, dword [iterations]
;jb ULoop
; in 
jmp ULoop
ULoopEnd:
;**********************************
;incremented by tStep for each iteration
; t += tStep
;movss xmm1, dword [fltZero]
;addss xmm1, dword [tStep]
;addss xmm1, dword [t]
;movss dword [t], xmm1
;compares with iterations 
; being stored as a int
;inc r13 ;preserved counter 
;ucomiss xmm1, dword [iterations]

; compare counter to interations 
;jb TLoop
; out 
jmp TLoop
TLoopEnd:
; -------------------------------------------------------------------
;  Plotting done.

	call	glEnd
	call	glPopMatrix
	call	glFlush
; ----
;pop r13 
pop r12 
ret 
; ******************************************************************
;  Generic procedure to display a string to the screen.
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
	push	rbp
	mov	rbp, rsp
	push	rbx
	push	rsi
	push	rdi
	push	rdx

; -----
;  Count characters in string.

	mov	rbx, rdi			; str addr
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL
	je	strCountDone
	inc	rbx
	inc	rdx
	jmp	strCountLoop
strCountDone:

	cmp	rdx, 0
	je	prtDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; EDX=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

prtDone:
	pop	rdx
	pop	rdi
	pop	rsi
	pop	rbx
	pop	rbp
	ret

; ******************************************************************

