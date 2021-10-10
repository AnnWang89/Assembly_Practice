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
	ninenine byte 9 DUP(?)
.code
main PROC
	mov ecx, 9;
	mov esi, OFFSET ninenine;
	mov al,0;
	L:
		add al,09h;
		mov [esi],al;
	L2:
		inc esi;
		loop L		
	exit
main ENDP
END main