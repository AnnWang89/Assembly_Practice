TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
main          EQU start@0

.data
myID byte "107502544"
size_ID = LENGTHOF myID
myID2 byte "107502509"	     
size_ID2 = LENGTHOF myID2

.code
Convert PROC USES ax
    L1:
	mov al, [esi];把esi的值放到al
	add al,11h;把數字換英文
        mov [esi],al;再把al值傳回去esi
	inc esi;esi加一
	loop L1
    ret
Convert ENDP

Convert2 PROC		
    L1:
	push eax;先把eax的值存起來
	mov al, [esi];把esi的值放到al
	add al,11h;把數字換英文
        mov [esi],al;再把al值傳回去esi
	pop eax;把原來的值再拿出來
	inc esi;esi加一
	loop L1
    ret
Convert2 ENDP

main PROC
    mov eax, 9999h         ;eax結果的值不能被改變
    mov ebx, 9999h         ;ebx結果的值不能被改變
    mov edx, 9999h         ;edx結果的值不能被改變
    mov esi, OFFSET myID	
    mov ecx, size_ID
    call Convert
    mov esi, OFFSET myID2
    mov ecx, size_ID2
    call Convert2
	
exit
main ENDP
END main