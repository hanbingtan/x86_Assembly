;Mossah Aljalal
;10/28/2016
;
;Assignment 3
;read in 32 bit hexadecimal value, find LSB, MSB, and total number of 1 bits set.

%include "along32.inc"

global main

section .data

    string    db "Enter 32 bit value in hexadecimal", 10, 0
    LSB       db "LSB set: ", 0
    MSB       db "MSB set: ", 0
    oneBit    db "Total number of 1 bits set: ", 0

section .text

main:

    call    Clrscr            ;clears terminal
    mov     edx, string       ;moves the string asking for input to edx
    call    WriteString       ;writes the string
    mov     eax, 0            ;clears register
    mov     edi, 0
    mov     ebp, 0
    call    ReadHex           ;saves hex number to eax
    call    Crlf              ;goes to next line
    mov     ecx, 0            ;clears register
    mov     ebx, 32           ;sets register to 32 to check all 32 bit values
    jmp     carrycount
carrycount:
    shr     eax, 1
    jnc     zerobit
    mov     ebp, ecx
    jmp     increment

increment:
    inc     edi
    cmp     ebx, ecx
    jl      zerobit
    mov     ebx, ecx

zerobit:
    inc     ecx
    cmp     ecx, ebx
    je      LSBset
    jmp     carrycount

LSBset:
    mov     edx, LSB
    call    WriteString
    mov     eax, ebx
    call    WriteInt
    call    Crlf
    jmp     MSBset

MSBset:
    mov     edx, MSB
    call    WriteString
    mov     eax, ebp
    call    WriteInt
    call    Crlf
    jmp     oneBitSet

oneBitSet:
    mov     edx, oneBit
    call    WriteString
    mov     eax, edi
    call    WriteInt
    jmp     exit

exit:

  	mov            eax, 1        ;exitC)
  	int            80h           ;call kernel
