;Mossah Aljalal
;11/18/2016
;revision history
;
;Quadratic formula
;Use the quadratic formula to compute the value of X, given A, B, and C

%include "along32.inc"

global main

section .data

promptA       db "Enter a number for A", 10, 0   ;this becomes A
promptB       db "Enter a number for B", 10 , 0  ;this becomes B
promptC       db "Enter a number for C", 10 , 0  ;this becomes C

firstX        db "For AX^2 + BX + C = 0, X = ", 0  ;prints out the first/only X value
secondX       db "X also equals ", 0            ;prints out the second X value

errorUndfned  db "A cannot equal 0 since the denominator cannot be 0, the answer is undefined."
imaginary     db "4*A*C is greater than B squared, which creates an imaginary number. Please use another set of numbers."

A             dq  0.0
B             dq  0.0
C             dq  0.0
Bsquared      dq  0.0
discrim       dq  0.0
four          dq  4.0
fourA         dq  0.0
fourAC        dq  0.0
sqrtDiscrim   dq  0.0
addNum        dq  0.0
subNum        dq  0.0
two           dq  2.0
negB          dq  0.0
negativeOne   dq  -1.0
den           dq  0.0
X1            dq  0.0
X2            dq  0.0
zero          dq  0.0

section .text

main:

        call        Clrscr              ;clears terminal
        call        floatA              ;calls floatA
        call        floatB              ;calls floatB
        call        floatC              ;calls floatC
        fstp        qword [C]           ;pops float C to C
        fstp        qword [B]           ;pops float B to B
        fstp        qword [A]           ;pops float A to A

        fld         qword [zero]        ;loads 0 to the stack
        fld         qword [A]           ;loads A to stack
        fcomi                           ;compares A to 0
        je          undefined           ;jumps to undefined if A is 0

        fninit                          ;clears stack, if A is not 0 then this is required

        jmp         numerator            ;jump to numerator function

floatA:

        mov         edx, promptA        ;moves the A prompt to edx
        call        WriteString         ;prints that string
        call        ReadFloat           ;reads in a numerical input
        call        Crlf                ;skips a line
        ret                             ;goes back to program

floatB:

        mov         edx, promptB        ;moves the B prompt to edx
        call        WriteString         ;prints that string
        call        ReadFloat           ;reads in a numerical input
        call        Crlf                ;skips a line
        ret                             ;goes back to program

floatC:

        mov         edx, promptC        ;moves the C prompt to edx
        call        WriteString         ;prints that string
        call        ReadFloat           ;reads in a numerical input
        call        Crlf                ;skips a line
        ret                             ;goes back to program

numerator:

        fld         qword [B]           ;loads B to stack
        fld         qword [negativeOne] ;loads -1 to the stack
        fmul        st0, st1            ;multiplies -1 and B
        fstp        qword [negB]        ;stores negative B and pops it off the stack
        fld         qword [B]           ;loads B to stack
        fmul        st0, st0            ;this is the square root of B, B*B
        fstp        qword [Bsquared]    ;stores this value and pops it
        fld         qword [four]        ;loads the number 4 to stack
        fld         qword [A]           ;loads A to the stack
        fmul        st0, st1            ;multiplies A*4
        fst         qword [fourA]       ;stores A*4 on the stack
        fld         qword [C]           ;loads C to the stack
        fmul        st0, st1            ;multiplies C and A*4
        fstp        qword [fourAC]      ;saves and pops 4*A*C

        fld         qword [Bsquared]    ;loads B squared to the stack
        fld         qword [fourAC]      ;loads 4*A*C to stack
        fcomi                           ;compares B squared to 4*A*C
        je          oneNumerator        ;jumps to oneNumerator if A is equal to Bsquared

        fninit                          ;clears stack

        fld         qword [Bsquared]    ;loads B squared to the stack
        fld         qword [fourAC]      ;loads 4*A*C to stack
        fcomi                           ;compares B squared to 4*A*C
        ja          imaginaryNumber     ;jumps to imaginaryNumber if B squared is less than 4*A*C

        fninit                          ;clears stack

        fld         qword [fourAC]      ;loads 4*A*C
        fld         qword [Bsquared]    ;loads B squared
        fsub        st1                 ;subtracts 4*A*C from B squared
        fstp        qword [discrim]     ;stores this value as the discriminant and pops it

        fld         qword [discrim]     ;loads discrim on to the stack
        fsqrt                           ;gets the square root of the discriminant
        fst         qword [sqrtDiscrim] ;stores the square root of the discriminant
        fld         qword [negB]        ;loads -B
        fadd        st1                 ;adds sqrtDiscrim to -B
        fstp        qword [addNum]      ;stores the sum in addNum and pops it off the stack
        fld         qword [negB]        ;loads -B
        fsub        st1                 ;subtrats sqrtDiscrim from -B
        fstp        qword [subNum]      ;stores the difference in subNum and pops it off the stack

        jmp         denominator         ;jumps to the denominator where x1 and x2 will be calculated

denominator:

        fld         qword [A]           ;load A to the stack
        fld         qword [two]         ;load the number 2
        fmul        st0, st1            ;multiplies 2*A
        fst         qword [den]         ;stores the value and it goes on the stack
        fld         qword [addNum]      ;loads the result of addition of -B and the discriminant
        fdiv        st1                 ;divides (-b + sqrt(b^2 - 4*A*C)) by 2*A
        fstp        qword [X1]          ;stores the quotient in x1
        fld         qword [subNum]      ;loads the result of subtraction of -B and the discriminant
        fdiv        st1                 ;divides (-b - sqrt(b^2 - 4*A*C)) by 2*A
        fstp        qword [X2]          ;stores the quotient in x2

        jmp         twoXs               ;jumps to twoXs where the values of x1 and x2 will be printed

twoXs:

        fninit                          ;clears the stack
        mov         edx, firstX         ;moves message to edx
        call        WriteString         ;writes message
        fld         qword [X1]          ;loads x1
        call        WriteFloat          ;writes x1 to console
        call        Crlf                ;skips a line
        mov         edx, secondX        ;moves message for second x to edx
        call        WriteString         ;writes message
        fld         qword [X2]          ;loads x2
        call        WriteFloat          ;writes x2 to console
        call        Crlf                ;skips a line

        jmp         exit                ;goes to exit prompt

undefined:

        mov         edx, errorUndfned   ;moves the error message for an undefined result to edx
        call        WriteString         ;prints errorUndfned
        jmp         exit                ;goes to exit prompt

oneNumerator:

        fld         qword [A]           ;load A
        fld         qword [two]         ;load the number 2
        fmul        st0, st1            ;multiplies 2*A
        fst         qword [den]         ;stores the product and it goes on the stack
        fld         qword [negB]        ;loads negative B on to the stack
        fdiv        st1                 ;divides negative B by 2*A
        fstp        qword [X1]          ;stores the value in X1 and pops it off the stack

        jmp         oneX                ;jumps to oneX

oneX:

        fninit                          ;clears the stack
        mov         edx, firstX         ;moves message to edx
        call        WriteString         ;writes message
        fld         qword [X1]          ;loads x1
        call        WriteFloat          ;prints the result on the console
        call        Crlf                ;skips a line

        jmp         exit                ;goes to exit prompt

imaginaryNumber:

        fninit                          ;clears the stack
        mov         edx, imaginary      ;moves the imaginary number message to edx
        call        WriteString         ;writes message
        call        Crlf                ;skips a line

        jmp         exit                ;goes to exit prompt

exit:

      	mov            eax, 1           ;exitC)
      	int            80h              ;call kernel
