;Mossah Aljalal
;10/11/2016
;
;Assignment 2
;read in N integers and compute their average

%include "along32.inc"

global main

section .data

    string    db "Type numbers to add together and get their average; Typing 0 will give you the average", 10, 0
    amountOfNum     db "This many numbers were read in: ", 0
    average   db "Average is: ", 0

section .text

main:

    call    Clrscr            ;clears terminal
    mov     eax, 0            ;clears register
    mov     ebx, 0            ;clears register
    mov     ecx, 0            ;clears register
    mov     edx, 0            ;clears register
    mov     edx, string       ;moves the string asking for input to edx
    call    WriteString       ;writes the string
    call    readInput         ;goes to the readInput function

readInput:

    call    ReadInt           ;reads the numbers
    inc     ecx               ;increments the number counter
    add     ebx, eax          ;adds the numbers being read in into the total to be averaged
    cmp     eax, 0            ;checks if the input is 0, if so then this loop goes to jz
    jz      Average           ;once the input is 0, goes to Average
    jmp     readInput         ;starts the loop over if the input is not zero

Average:

    dec      ecx              ;removes the 0 input from the counter
    mov      eax, ebx         ;moves the numbers that were sent to the total to eax so they can be divided
    mov      edx, 0           ;sets edx to 0, gets floating point error removed
    idiv     ecx              ;divides eax by ecx
    mov      edx, average     ;moves the average message to edx so it can be printed
    call     WriteString      ;prints the average message
    call     WriteInt         ;prints the average
    call     Crlf             ;skips a line
    mov      edx, amountOfNum ;moves the amount of numbers message to edx to be printed
    mov      eax, ecx         ;moves the count to eax
    call     WriteString      ;writes the amount of numbers message to the console
    call     WriteInt         ;writes out the total amount in eax from the numbers typed
    jmp      exit             ;exits

exit:

  	mov            eax, 1        ;exitC)
  	int            80h           ;call kernel
