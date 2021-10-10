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
ExitProcess proto,dwExitCode:dword	;�ŧi proto type
DifferentInputs proto, v1:dword, v2:dword, v3:dword	;���F�ŦXv1.v2.v3���j�p�A�ҥH�ϥ�dword

main          EQU start@0

.data
.code

main PROC
  invoke DifferentInputs,2,2,3
    invoke DifferentInputs,2,3,2
    invoke DifferentInputs,3,5,5
    invoke DifferentInputs,2,2,2
    invoke DifferentInputs,104522064,107502509,107502544; ��W�Ǹ�

    call WaitMsg
    invoke ExitProcess,0
main endp

DifferentInputs proc,
    v1:dword, v2:dword, v3:dword
    mov eax,v1   	 ; ���X v1
    cmp v2,eax      ; �Pv2���
    je  Label_Equal ; �Y�۵��h����Label_Equal,�^��0
    cmp v3, eax     ;�]���n����A�ҥH�ϥ�cmp
    je  Label_Equal ;�]���۵��A�ϥ�je�A����Label_Equal
    mov eax,v2      ; ���X v2
    cmp v3, eax     ; �Pv3�����
    je  Label_Equal
    mov eax,1       ; �^��1�A�ҥH�N1�s�ieax
    jmp  exit_label  ; return true

Label_Equal:
    mov  eax,0      ; return false

exit_label:
    call DumpRegs
    ret
DifferentInputs endp



END main
