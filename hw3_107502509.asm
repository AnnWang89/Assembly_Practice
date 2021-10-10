TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang

CountMatches proto, A1:ptr sdword, A2:ptr sdword, leng:dword	;才v1.v2.v3┮ㄏノdword
main          EQU start@0

.data
Array1 sdword 2,  4, -3, -9, 7, 1, 8;
Array2 sdword 2, -3,  6,  0, 7, 8, 5;
size_Array dword lengthof Array1;
matches BYTE " matches",0
.code

main PROC
  invoke CountMatches,
    OFFSET Array1,
    OFFSET Array2,
    size_Array;
    mov edx,OFFSET matches;陪ボmatches
    call WriteString;string
    call Crlf;传︽
    call WaitMsg;
main endp

CountMatches proc,
    A1:ptr sdword, A2:ptr sdword, leng:dword
    mov ecx,leng   ;ぶ碞禲碭Ωeax
    mov esi,A1     ;р材array竚秈esi
    mov edi,A2     ;р材array竚秈edi
    mov eax,0      ;eaxㄢarray单计ヘ
L:
    mov ebx,[esi]
    mov edx,[edi]
    cmp ebx,edx;ゑ耕琌ㄢ计ぃ琌竚┮璶рebx㎝edx
    jne  NOTEqual ; 璝ぃ单玥铬NOTEqual
    add eax,1;单eax+1
 NOTEqual:
    add esi,4;传ゑ琌sdword┮4
    add edi,4;传ゑ琌sdword┮4
    loop L
    call WriteInt;计ヘ
    ret
CountMatches endp

END main
