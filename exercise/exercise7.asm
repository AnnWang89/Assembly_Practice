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
myID byte "107502544"  ;�ժ��Ǹ�
myID2 byte "107502509" ;�խ��Ǹ�
size_ID = 9    ; size_ID���myID������
result byte 9 DUP(?)  ;�x�s���G



.code
main PROC

	xor eax,eax;eax=0
	xor ebx,ebx;ebx=0
	xor esi,esi;esi=0
	mov ecx,size_ID;loop �]������
L1:
    movzx eax,myID[esi];��Ʀr��ieax
    movzx ebx,myID2[esi];��Ʀr��iebx
	cmp eax,ebx;�����̬۴�G
	jz L2;��ƬۦP����L2
	js L3;�e�Ƹ��j����L3
    mov result[esi],"B";��Ƹ��jresult=B
    jmp L4;����L4
L2:
    mov result[esi],"A";result=A
    jmp L4;����L4
L3:

	mov result[esi],"C";result=C
L4:
	inc esi;esi++
	loop L1
	exit
main ENDP
END main
