TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive
; using "start" is because for linking to WinDbg.  added by Huang

CountMatches proto, A1:ptr sdword, A2:ptr sdword, leng:dword	;���F�ŦXv1.v2.v3���j�p�A�ҥH�ϥ�dword
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
    mov edx,OFFSET matches;���matches
    call WriteString;�L�Xstring
    call Crlf;����
    call WaitMsg;
main endp

CountMatches proc,
    A1:ptr sdword, A2:ptr sdword, leng:dword
    mov ecx,leng   ;���׬��h�ִN�]�X���A��Jeax
    mov esi,A1     ;��Ĥ@��array����m��iesi
    mov edi,A2     ;��ĤG��array����m��iedi
    mov eax,0      ;eax�s���array�۵����ƥ�
L:
    push ecx       ;�Ψ�Ӱj��A�ҥH����ecx���Ӧs�_��
    mov ecx,leng   ;�@�˩񥦪�����
    mov ebx,[esi]  ;��esi���V����m���ȩ��ebx
L2:
    mov edx,[edi]  ;��edi���V����m���ȩ��edx
    cmp ebx,edx    ;�����ƬO�_�۵�
    jne  NOTEqual  ; �Y���۵��h����NOTEqual
    add eax,1      ;�۵�eax+1
    jmp L3         ;����Ĥ@��array���U�@��
NOTEqual:
    add edi,4      ;���U�@�ӥh��A�]���Osdword�ҥH�[4�A�S����~���
    loop L2        ;�^��L2
L3:
    add esi,4      ;���U�@�ӥh��A�]���Osdword�ҥH�[4
    mov edi,A2     ;�q�Ĥ@�ӥh�ݦ��S���@�˪�
    pop ecx        ;�n�^�쥻��ecx
    loop L
    call WriteInt;�L�X�ۦP���ƥ�
    ret
CountMatches endp

END main
