;Mossah Aljalal
;11/4/2016
;
;Assignment 4
;read in integers and print them out in ascending order

%include "along32.inc"

global main

section .data

    prompt            db "Enter up to 100 numbers, entering 0 will sort the numbers into ascending order", 10, 0
    nonzero           db "Please enter at least one non-zero number", 0
    overflow          db "You entered too many numbers", 0
    amountOfNum       db "This many numbers were read in: ", 0
    ascending         db "These are your numbers in ascending order", 0
    arrayp times 100  dq 0
    count dq 100

section .text

main:

    call    Clrscr            ;clears terminal
    mov     eax, 0
    mov     ebx, 0
    mov     ecx, 0            ;sets counter to 0
    mov     edx, prompt       ;moves the string asking for input to edx
    call    WriteString       ;writes the string
    call    readInput         ;goes to the readInput function

readInput:

    call    ReadInt           ;reads the numbers
    inc     ecx               ;increments the number counter
    mov     eax, ecx
    cmp     eax, 0
    jnz     readInput         ;starts the loop over if the input is not zero
    jz      sort              ;once the input is 0, goes to sort

sort:
    dec     ecx               ;removes the 0 input from the counter
    cmp     ecx, 100
    jg      over
    jecxz   zero              ;jumps if only 0 was put in
    mov     edx, 0            ;sets edx to 0, gets floating point error removed
    call    WriteString       ;prints the average message
    call    WriteInt          ;prints the average
    call    Crlf              ;skips a line
    mov     edx, amountOfNum  ;moves the amount of numbers message to edx to be printed
    mov     eax, ecx          ;moves the count to eax
    call    WriteString       ;writes the amount of numbers message to the console
    call    WriteInt          ;writes out the total amount in eax from the numbers typed
    jmp     exit              ;exits

zero:
    mov     edx, nonzero
    call    WriteString
    jmp     exit

over:
    mov     edx, overflow
    call    WriteString
    jmp     exit

exit:

  	mov            eax, 1        ;exitC)
  	int            80h           ;call kernel
