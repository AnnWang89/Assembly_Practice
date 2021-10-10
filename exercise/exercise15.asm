INCLUDE Irvine32.inc
.data
consoleHandle    DWORD ?
xyInit COORD <((44 mod 79) + 1),((44 mod 24 )+ 1)> ; 起始座標
xyBound COORD <80,25> ; 一個頁面最大的邊界
xyPos COORD <((44 mod 79) + 1),((44 mod 24 )+ 1)> ; 現在的游標位置(可打可不打)
main EQU start@0
.code
main PROC

; Get the Console standard output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax

; 設定回到起始位置
INITIAL:
	mov ax,xyInit.x
	mov xyPos.x,ax
	mov ax,xyInit.y
	mov xyPos.y,ax
START:
	call ClrScr
	INVOKE SetConsoleCursorPosition, consoleHandle , xyPos;把現在位置放進去
	call ReadChar
	.IF ax == 4800h ;UP
		sub xyPos.y,1
	.ENDIF
	.IF ax == 5000h ;DOWN
		add xyPos.y,1
	.ENDIF
	.IF ax == 4B00h ;LEFT
		sub xyPos.x,1
	.ENDIF
	.IF ax == 4D00h ;RIGHT
		add xyPos.x,1
	.ENDIF
	.IF ax == 011Bh ;ESC
		jmp END_FUNC
	.ENDIF

	; 檢查作完上下左右後有沒有超過限制邊界
	.IF xyPos.x == 0h ;x lowerbound
		 add xyPos.x,1; 因為到0了，所以要加1，讓他不要超出邊界
	.ENDIF
	mov ax,xyBound.x ; 註：比較不能用雙定址，故將其中一個轉成 register
	.IF xyPos.x == ax ;x upperbound
		sub xyPos.x,1 ; 因為到80了，所以要減1，讓他不要超出邊界
	.ENDIF

	.IF xyPos.y == 0h ;y lowerbound
		add xyPos.y,1 ; 因為到0了，所以要加1，讓他不要超出邊界
	.ENDIF
	mov ax,xyBound.y
	.IF xyPos.y == ax ;y upperbound
		sub xyPos.y,1; 因為到25了，所以要減1，讓他不要超出邊界
	.ENDIF

	jmp START
END_FUNC:
	exit
main ENDP

END main
