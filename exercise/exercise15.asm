INCLUDE Irvine32.inc
.data
consoleHandle    DWORD ?
xyInit COORD <((44 mod 79) + 1),((44 mod 24 )+ 1)> ; �_�l�y��
xyBound COORD <80,25> ; �@�ӭ����̤j�����
xyPos COORD <((44 mod 79) + 1),((44 mod 24 )+ 1)> ; �{�b����Ц�m(�i���i����)
main EQU start@0
.code
main PROC

; Get the Console standard output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax

; �]�w�^��_�l��m
INITIAL:
	mov ax,xyInit.x
	mov xyPos.x,ax
	mov ax,xyInit.y
	mov xyPos.y,ax
START:
	call ClrScr
	INVOKE SetConsoleCursorPosition, consoleHandle , xyPos;��{�b��m��i�h
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

	; �ˬd�@���W�U���k�ᦳ�S���W�L�������
	.IF xyPos.x == 0h ;x lowerbound
		 add xyPos.x,1; �]����0�F�A�ҥH�n�[1�A���L���n�W�X���
	.ENDIF
	mov ax,xyBound.x ; ���G�����������w�}�A�G�N�䤤�@���ন register
	.IF xyPos.x == ax ;x upperbound
		sub xyPos.x,1 ; �]����80�F�A�ҥH�n��1�A���L���n�W�X���
	.ENDIF

	.IF xyPos.y == 0h ;y lowerbound
		add xyPos.y,1 ; �]����0�F�A�ҥH�n�[1�A���L���n�W�X���
	.ENDIF
	mov ax,xyBound.y
	.IF xyPos.y == ax ;y upperbound
		sub xyPos.y,1; �]����25�F�A�ҥH�n��1�A���L���n�W�X���
	.ENDIF

	jmp START
END_FUNC:
	exit
main ENDP

END main
