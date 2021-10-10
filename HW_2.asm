TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc
;Define MACRO

main          EQU start@0


.data
	ChStrs BYTE " ****** "
		   BYTE " **  ** "
		   BYTE " **  ** "
		   BYTE " ****** "
		   BYTE "     ** "
		   BYTE "    **  "
		   BYTE "   **   "
		   BYTE "  **    "

.code
change PROC
	xor eax,eax;�M��eax
	cmp ecx,8;���ecx�O���O����8
	jnz  P;�Y�O����8�N���Ĥ@���]�A�ҥHesi�n�M��
	xor esi,esi;�M��esi
P:
	push ecx;�]���S�O�@�Ӱj��A�ҥH�n����쥻��ecx�s�_��
	MOV ECX,8;�s���j��@�˶]8��(ChStrs���C�@�C)
L:
	shl al,1;�������@��
	cmp ChStrs[esi],' ';�P�_�O�_���ť�
	jz L1;�Y�O�ťդ����[1
	add al,1;�����ťխn�⨺�ӼƦr��1
L1:
	inc esi;���P�_ChStrs���U�@��
	loop L;�j��]���P�@�C
	pop ecx;��^�쥻ecx
	mov eax,eax;�O���즳����
	mov ebx,TYPE BYTE;�u�n1��byte
	call WriteBinB;�HBinary�覡�L�XInteger
	call Crlf;����
	RET
change ENDP

main PROC
	MOV ECX,8
L1:
	CALL change
	LOOP L1
main ENDP
END main
