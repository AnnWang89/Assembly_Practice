TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang

main          EQU start@0
Str_remove PROTO,
pStart:PTR BYTE,
nChars:DWORD

.data
target1 BYTE "107502509",0 ;��J�խ����Ǹ�
target2 BYTE "107502544",0 ;��J�խ����Ǹ�
target3 BYTE "999999999",0

.code


main PROC
INVOKE Str_remove, OFFSET target1, 5 ;�Ĥ@�Ӧr�겾��5�Ӧr��
    mov edx,OFFSET target1
    call WriteString
    call Crlf
INVOKE Str_remove, OFFSET target2, 2 ;�ĤG�Ӧr�겾��2�Ӧr��
    mov edx,OFFSET target2
    call WriteString
    call Crlf
INVOKE Str_remove, OFFSET [target2+1], 15  ; �ĤG�Ӧr�겾���W�L�r����ת��r��
    mov edx,OFFSET target2
    call WriteString
    call Crlf
    call WaitMsg
exit

main endp

Str_remove PROC,
	pStart:PTR BYTE,	; points to first character to delete
	nChars:DWORD	; number of characters to delete

	INVOKE Str_length, pStart
	mov	ecx,eax		; ���r����צs��b ecx ������ƻs�j���

	.IF nChars <= ecx	; �ˬd�����r���O�_�W�L�r��j�p
	  sub ecx,nChars	; �p�G�S���W�L�A�N�ű��������r���ƶq
	.ENDIF

	mov	esi,pStart		; �ƻspStart���_�l�I
	add	esi,nChars		; �N�L����n�ƻs����m(�R���X��A�N�������)
	mov	edi,pStart	    ; �N�s�r�ꪺ�_�l�I�]�w�n

	cld					; clear direction flag = cld
	rep	movsb			; ��esi���edi�A��ӳ��[�@
    mov	BYTE PTR [edi],0; insert new null byte

Exit_proc:
	ret
Str_remove ENDP

END main
