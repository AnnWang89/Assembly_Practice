TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

Str_copyN PROTO,
    source:PTR BYTE,   ; source string address
    target:PTR BYTE,   ; target string address
    maxChars:DWORD     ; maximum number of characters to copy

main   EQU start@0

.data
string_1 BYTE "107502509",0    ;��J�խ�1�Ǹ�
string_2 BYTE "107502544",0    ;��J�խ�2�Ǹ�

.code
main PROC
    INVOKE Str_copyN,             ; copy string_1 to string_2
      OFFSET string_1,
      OFFSET string_2 + 9,
      (SIZEOF string_2) - 1       ; save space for null byte

    ; display the destination string:
    mov  edx, OFFSET string_2
    call WriteString
    call Crlf
    call WaitMsg
    exit
main ENDP

Str_copyN PROC USES eax ecx esi edi,
    source:PTR BYTE,        ; source string
    target:PTR BYTE,        ; target string
    maxChars:DWORD          ; max chars to copy

; Copy a string from source to target, limiting the number of
; characters to copy by maxChars.
; The value in maxChars does not include the null byte.

    mov ecx,maxChars    ; set counter for REP
    mov esi,source    ; ��source ���esi
    mov edi,target    ; ��target ���edi
    cld               ; clear direction flag
    rep movsb         ; ��esi���edi�A�M���ӳ��[1
    mov al, 0         ; ��string2���̫�@�ӬO0
    stosb             ; ��al����(0)�A�s��edi
    ret
Str_copyN ENDP

END main

