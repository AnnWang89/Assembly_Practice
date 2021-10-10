TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang

CountMatches proto, A1:ptr sdword, A2:ptr sdword, leng:dword	;為了符合v1.v2.v3的大小，所以使用dword
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
    mov edx,OFFSET matches;顯示matches
    call WriteString;印出string
    call Crlf;換行
    call WaitMsg;
main endp

CountMatches proc,
    A1:ptr sdword, A2:ptr sdword, leng:dword
    mov ecx,leng   ;長度為多少就跑幾次，放入eax
    mov esi,A1     ;把第一個array的位置放進esi
    mov edi,A2     ;把第二個array的位置放進edi
    mov eax,0      ;eax存兩個array相等的數目
L:
    push ecx       ;用兩個迴圈，所以先把ecx的植存起來
    mov ecx,leng   ;一樣放它的長度
    mov ebx,[esi]  ;把esi指向的位置的值放到ebx
L2:
    mov edx,[edi]  ;把edi指向的位置的值放到edx
    cmp ebx,edx    ;比較兩數是否相等
    jne  NOTEqual  ; 若不相等則跳到NOTEqual
    add eax,1      ;相等eax+1
    jmp L3         ;換找第一個array的下一個
NOTEqual:
    add edi,4      ;換下一個去比，因為是sdword所以加4，沒找到繼續找
    loop L2        ;回到L2
L3:
    add esi,4      ;換下一個去比，因為是sdword所以加4
    mov edi,A2     ;從第一個去看有沒有一樣的
    pop ecx        ;要回原本的ecx
    loop L
    call WriteInt;印出相同的數目
    ret
CountMatches endp

END main
