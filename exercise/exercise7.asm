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
myID byte "107502544"  ;組長學號
myID2 byte "107502509" ;組員學號
size_ID = 9    ; size_ID表示myID的長度
result byte 9 DUP(?)  ;儲存結果



.code
main PROC

	xor eax,eax;eax=0
	xor ebx,ebx;ebx=0
	xor esi,esi;esi=0
	mov ecx,size_ID;loop 跑的次數
L1:
    movzx eax,myID[esi];把數字放進eax
    movzx ebx,myID2[esi];把數字放進ebx
	cmp eax,ebx;比較兩者相減結果
	jz L2;兩數相同跳到L2
	js L3;前數較大跳到L3
    mov result[esi],"B";後數較大result=B
    jmp L4;跳到L4
L2:
    mov result[esi],"A";result=A
    jmp L4;跳到L4
L3:

	mov result[esi],"C";result=C
L4:
	inc esi;esi++
	loop L1
	exit
main ENDP
END main
