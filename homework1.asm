TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang

main          EQU start@0

.data
MyID   DWORD ?
Digit0 BYTE 2
Digit1 BYTE 5
Digit2 BYTE 0
Digit3 BYTE 9
	;some data

.code
main PROC
	movsx eax,Digit0 ;把Digit0放進eax
	movsx ebx,Digit1 ;把Digit1放進ebx
	shl eax,8        ;因為為16進位，要往左移8個bit才會是16進位的兩位
	add eax,ebx      ;把eax和ebx加起來存到eax
	movsx ebx,Digit2 ;把Digit2放進ebx
	shl eax,8        ;因為為16進位，要往左移8個bit才會是16進位的兩位
	add eax,ebx      ;把eax和ebx加起來存到eax
	movsx ebx,Digit3 ;把Digit3放進ebx
	shl eax,8        ;因為為16進位，要往左移8個bit才會是16進位的兩位
	add eax,ebx      ;把eax和ebx加起來存到eax
	mov MyID,eax     ;把eax存到MyID
	exit
main ENDP
END main
