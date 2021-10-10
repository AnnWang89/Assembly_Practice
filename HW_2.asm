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
	xor eax,eax;清空eax
	cmp ecx,8;比較ecx是不是等於8
	jnz  P;若是等於8代表為第一次跑，所以esi要清空
	xor esi,esi;清空esi
P:
	push ecx;因為又是一個迴圈，所以要先把原本的ecx存起來
	MOV ECX,8;新的迴圈一樣跑8次(ChStrs的每一列)
L:
	shl al,1;往左移一位
	cmp ChStrs[esi],' ';判斷是否為空白
	jz L1;若是空白不須加1
	add al,1;不為空白要把那個數字田1
L1:
	inc esi;換判斷ChStrs的下一個
	loop L;迴圈跑完同一列
	pop ecx;放回原本ecx
	mov eax,eax;保持原有的值
	mov ebx,TYPE BYTE;只要1個byte
	call WriteBinB;以Binary方式印出Integer
	call Crlf;換行
	RET
change ENDP

main PROC
	MOV ECX,8
L1:
	CALL change
	LOOP L1
main ENDP
END main
