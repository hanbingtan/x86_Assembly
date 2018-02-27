;Mossah Aljalal
;12/2/2016
;
;Assignment 6
;read in N integers and determine the number of positive, negative and zero numbers in the numbers that have been read in

%include "along32.inc"

global main

section .data

    prompt           db "Type in numbers. Type 0 twice to get the number of positive, negative, and zero numbers entered.", 10, 0
    positiveNums     db "This many positive numbers were read in: ", 0
    negativeNums     db "This many negative numbers were read in: ", 0
    zeroNums         db "This many zeroes were read in: ", 0

    var      db 0

section .text

main:

    call     Clrscr             ;clears terminal
    mov      eax, 0             ;clears register
    mov      ebx, 0             ;clears register
    mov      ecx, 0             ;clears register
    mov      edx, 0             ;clears register
    mov      edx, prompt        ;moves the string asking for input to edx
    call     WriteString        ;writes the string
    mov      edx, 0             ;clears register
    call     readInput          ;goes to the readInput function

readInput:

    call     ReadInt            ;reads the numbers
    cmp      eax, 0             ;checks if the input is 0, if so then this loop goes to jz
    jz       zeroCounter        ;once the input is 0, goes to twoZerosCheck
    jmp      negativeCounter

zeroCounter:

    add      edx, 1                ;increments the 0 counter
    mov      eax, 0
    call     ReadInt            ;reads the numbers
    cmp      eax, 0             ;checks if the input is 0, if so then this loop goes to jz
    jz       output             ;once the input is 0, goes to Average
    jmp      negativeCounter          ;starts the loop over if the input is not zero

positiveCounter:

    inc      ecx
    jmp      readInput          ;starts the loop over if the input is not zero

negativeCounter:

    cmp      eax, 0
    jg       positiveCounter

    add      esi, 1
    jmp      readInput          ;starts the loop over if the input is not zero

output:

    dec      edx                ;removes the 0 input from the counter
    mov      eax, edx           ;moves the numbers that were sent to the total to eax so they can be divided
    mov      edx, 0             ;sets edx to 0, gets floating point error removed
    mov      edx, zeroNums      ;moves the average message to edx so it can be printed
    call     WriteString        ;prints the average message
    call     WriteInt           ;prints the average
    mov      eax, 0
    call     Crlf               ;skips a line

    mov      eax, ecx           ;moves the numbers that were sent to the total to eax so they can be divided

    mov      edx, positiveNums  ;moves the average message to edx so it can be printed
    call     WriteString        ;prints the average message
    call     WriteInt           ;prints the average
    mov      eax, 0
    call     Crlf               ;skips a line


    mov      eax, esi           ;moves the numbers that were sent to the total to eax so they can be divided

    mov      edx, negativeNums  ;moves the average message to edx so it can be printed
    call     WriteString        ;prints the average message
    call     WriteInt           ;prints the average
    call     Crlf               ;skips a line


    jmp      exit               ;exits

exit:

  	mov            eax, 1       ;exitC)
  	int            80h          ;call kernel
