TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang

main          EQU start@0

.stack 4096
ExitProcess proto,dwExitCode:dword
FindLargest proto a1:PTR sdword,a2:dword
;宣告FindLargest procedure 的prototype


.data
Ex1Array sdword 105522063 , 107502509 , 107502544
;陣列初始為105522063, 組員學號1 ,組員學號2
Ex2Array sdword -105522063 ,-107502509,-107502544
;陣列初始為-105522063, 組員學號1加負號 ,組員學號2加負號

.code

main PROC
  INVOKE FindLargest, OFFSET Ex1Array, LENGTHOF Ex1Array
  INVOKE FindLargest, OFFSET Ex2Array, LENGTHOF Ex2Array
    ;呼叫FindLargest procedure

    call WaitMsg
    invoke ExitProcess,0

main ENDP
FindLargest proc, aPtr:PTR SDWORD, arraysize:DWORD

    push esi
    push ecx
    mov  eax,80000000h  ; smallest possible 32bit signed integer
    mov  esi,aPtr    ; point to the first element
    mov  ecx,arraysize    ; set iteration times
L1: cmp eax,[esi]     ; compare the current value and current maximum
    jg L2          ; if smaller than max,jump to L2
    mov  eax,[esi]     ; update max value

L2: add  esi,4
    loop L1

    call WriteInt
    call Crlf

    pop ecx
    pop esi
    ret             ; Return from subroutine
FindLargest endp


END main
