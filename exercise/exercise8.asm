TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc
;Define MACRO

main          EQU start@0

divide MACRO dividend, divisor, quotient, remainder
    mov dx,0;�����0
    mov ax,dividend;ax��Q����
    mov bx,divisor;bx�񰣼�
    div bx;��̬۰�
    mov quotient,ax;�ھ�16bit�ӼƦbax
    mov remainder,dx;�ھ�16bit�l�Ʀbdx


ENDM

.data
dividend WORD 2509;�ժ����Ǹ����|�X(�Q�i��)
divisor WORD 100
quotient WORD 1 DUP(?)
remainder WORD 1 DUP(?)

.code
main PROC
	movsx eax, dividend
	call WriteDec
	call Crlf

	divide dividend, divisor, quotient, remainder

	movsx eax, quotient
	call WriteDec
	call Crlf

	movsx eax, remainder
	call WriteDec
	call Crlf

	call WaitMsg
	exit
main ENDP
END main
