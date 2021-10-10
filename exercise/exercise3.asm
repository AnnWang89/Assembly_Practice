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
Val1	SBYTE	03h
Val2	SBYTE	02h
Val3	SBYTE	8fh
Rval	SDWORD	?
	;some data

.code
main PROC
	movsx eax,Val1
	movsx ebx,Val2
	movsx ecx,Val3
	add eax,ebx
	mov edx,eax
	shl edx,4
	shl eax,1
	sub edx,eax
	sub ecx,edx
	neg ecx
	mov Rval,ecx
	exit
main ENDP
END main
