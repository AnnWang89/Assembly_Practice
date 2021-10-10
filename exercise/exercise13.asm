TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

Str_remove PROTO,pStart:PTR BYTE,nChars:DWORD

main  EQU start@0 ;
.data
target BYTE "107502509107502544ABCDEF",0

.code
main PROC

	mov edi, OFFSET target  ;edi = target��ʼλ��
	mov al, '4'  ;al = �W̖2����һ�a(��Ԫ)
	mov ecx, lengthof target ;ecx = target �ִ����L��
	cld              ;clear direction flag
	repne scasb      ;repeat searching while not equal
	dec edi         ;���ҵ�����Ԫλ�Üpһ
	mov eax, OFFSET target  ;eax = target��ʼλ��
	sub edi, eax  ;edi -= target��ʼλ��
	call DumpRegs   ;�@ʾĿǰ��������r

	mov edx,OFFSET target
	call WriteString
	call Crlf
	INVOKE Str_remove, OFFSET target, edi	;���� Str_remove
	mov edx,OFFSET target
	call WriteString
	call Crlf
	call WaitMsg
	exit
main ENDP

Str_remove PROC,
	pStart:PTR BYTE,	; Ҫ�Ƴ����ִ��^
	nChars:DWORD		; ���Ƴ�����Ԫ��

	INVOKE Str_length, pStart
	mov	ecx,eax		;ecx = �ִ��L��

	.IF nChars <= ecx	; check range of nChars
	  sub ecx, nChars 	; set counter for REP prefix
	.ENDIF

	mov esi, pStart	;esi = �ִ���ʼλ��
	add esi, nChars	;esi += Ҫ�Ƴ�����Ԫ��
	mov edi, pStart	;edi = �ִ���ʼλ��

	cld               ;clear direction flag
	rep movsb	     ;do the move

	mov	BYTE PTR [edi],0	; insert new null byte

Exit_proc:
	ret
Str_remove ENDP
END main
