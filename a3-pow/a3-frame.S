  # *********************************************************************************
# * Program name: pow                                                             *
# * Description :                                                                 *
# *********************************************************************************

#ifndef MACOS
.ifndef CODEGRADE
    .global main
    main: jmp my_main
.endif
#else
    .global _main
    _main: jmp my_main
    printf: jmp _printf
    scanf: jmp _scanf
    exit: jmp _exit
#endif

.text
string:
      .asciz "Assignment 3: pow\n"
basenum:
        .asciz "Enter a positive base:\n"
exponentnum:
        .asciz "Enter a positive exponent:\n"
text:
        .asciz "The pow is: %ld \n"
result:
        .asciz "%ld"

# your strings here

.global my_main
.global my_pow


my_main:
    pushq   %rbp #push the base pointer.
    movq    %rsp , %rbp # and copy stack pointer to RBP.
#base number
    movq    $0 , %rax       # no vector registers in use for printf
    leaq    basenum(%rip) , %rdi   # load address of a string
    call    printf

    subq    $16, %rsp        # Reserve stack space for variable
    leaq    -16(%rbp) , %rsi      # Load address of stack variable in rsi
    leaq    result(%rip) , %rdi         # load first argument of scanf
    movq    $0 , %rax       # no vector registers for scanf
    call    scanf
    movq    -16(%rbp), %rbx #storing user input for base number in rbx
# exponenet
    movq    $0 , %rax       # no vector registers in use for printf
    leaq    exponentnum(%rip) , %rdi   # load address of a string
    call    printf

    subq    $16, %rsp        # Reserve stack space for variable
    leaq    -16(%rbp) , %rsi      # Load address of stack variable in rsi
    leaq    result(%rip) , %rdi         # load first argument of scanf
    movq    $0 , %rax       # no vector registers for scanf
    call    scanf
    movq    -16(%rbp), %rcx #storing user input for exponent in rcx

    call my_pow

    movq    %rbp , %rsp     # clear variables from stack.
    popq    %rbp    # Restore base pointer
    ret

my_pow:

    pushq   %rbp    #push the base pointer.
    movq    %rsp , %rbp     #and copy stack pointer to RBP.


    movq    $1, %rax    #we initialize the value in rax to 1
    cmpq    $0, %rcx    #we compare the exponent value to 0
    je      excep   #if equal to 0, then it jumps to the excep case.

    loop:
        mulq    %rbx #we multiply the value in register
        decq    %rcx    #then we decrement the exponent value
        cmpq     $0, %rcx   #then we compare if the exponent value is 0
        je     end
        jmp     loop    #if the exponent value is not 0, the loop repeats

    excep:
        movq $1, %rax   #exception for when the user input for exponent is 0, the answer will always be 1

    end:
        movq    %rax, %rsi
        movq    $0, %rax    #no vector argument in use for printf
        leaq    text(%rip), %rdi #load address of text to rdi
        call    printf
        
        movq    $0, %rdi    #exit code
        call    exit
            


      
   








    
