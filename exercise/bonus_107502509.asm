TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

Str_nextWord PROTO,
pString:PTR BYTE, ; pointer to string
delimiter:BYTE ; delimiter to find

main  EQU start@0 ;

.data
testStr BYTE "ABC\DE\FGHIJK\LM",0
.code
main PROC
call Clrscr
mov edx, OFFSET testStr ; display string
call WriteString
call Crlf
; Loop through the string, replace each delimiter, and
; display the remaining string.
mov esi, OFFSET testStr
L1: INVOKE Str_nextword, esi, '\'
jnz Exit_prog ;quit if not found
mov esi,edi ; point to next substring
mov edx,edi ;put edi to edx
call WriteString ; display remainder of string
call Crlf
jmp L1
Exit_prog:
call WaitMsg
exit
main ENDP

Str_nextWord proc,
    pString:PTR BYTE,delimiter:BYTE
    mov edi,pString     ;
    mov al,delimiter
    mov ecx,16 ;the length of testStr
    cld
    repne scasb;repeat until we find '\' the set zero flag
    ret
Str_nextWord endp

END main
