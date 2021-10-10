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
	movsx eax,Digit0 ;��Digit0��ieax
	movsx ebx,Digit1 ;��Digit1��iebx
	shl eax,8        ;�]����16�i��A�n������8��bit�~�|�O16�i�쪺���
	add eax,ebx      ;��eax�Mebx�[�_�Ӧs��eax
	movsx ebx,Digit2 ;��Digit2��iebx
	shl eax,8        ;�]����16�i��A�n������8��bit�~�|�O16�i�쪺���
	add eax,ebx      ;��eax�Mebx�[�_�Ӧs��eax
	movsx ebx,Digit3 ;��Digit3��iebx
	shl eax,8        ;�]����16�i��A�n������8��bit�~�|�O16�i�쪺���
	add eax,ebx      ;��eax�Mebx�[�_�Ӧs��eax
	mov MyID,eax     ;��eax�s��MyID
	exit
main ENDP
END main
