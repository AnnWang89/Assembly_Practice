TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword	;宣告 proto type
DifferentInputs proto, v1:dword, v2:dword, v3:dword	;為了符合v1.v2.v3的大小，所以使用dword

main          EQU start@0

.data
.code

main PROC
  invoke DifferentInputs,2,2,3
    invoke DifferentInputs,2,3,2
    invoke DifferentInputs,3,5,5
    invoke DifferentInputs,2,2,2
    invoke DifferentInputs,104522064,107502509,107502544; 填上學號

    call WaitMsg
    invoke ExitProcess,0
main endp

DifferentInputs proc,
    v1:dword, v2:dword, v3:dword
    mov eax,v1   	 ; 取出 v1
    cmp v2,eax      ; 與v2比較
    je  Label_Equal ; 若相等則跳到Label_Equal,回傳0
    cmp v3, eax     ;因為要比較，所以使用cmp
    je  Label_Equal ;因為相等，使用je，跳到Label_Equal
    mov eax,v2      ; 取出 v2
    cmp v3, eax     ; 與v3做比較
    je  Label_Equal
    mov eax,1       ; 回傳1，所以將1存進eax
    jmp  exit_label  ; return true

Label_Equal:
    mov  eax,0      ; return false

exit_label:
    call DumpRegs
    ret
DifferentInputs endp



END main
