TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc
;Define MACRO

main          EQU start@0

divide MACRO dividend, divisor, quotient, remainder
    mov dx,0;高位放0
    mov ax,dividend;ax放被除數
    mov bx,divisor;bx放除數
    div bx;兩者相除
    mov quotient,ax;根據16bit商數在ax
    mov remainder,dx;根據16bit餘數在dx


ENDM

.data
dividend WORD 2509;組長的學號末四碼(十進位)
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
