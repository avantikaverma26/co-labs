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
        .asciz "Enter a positive base: "
exponentnum:
        .asciz "Enter a positive exponent"
text:
        .asciz "The pow is: %ld \n"
num:
        .asciz "%ld"

# your strings here

.global my_main
.global my_pow


my_main:
        # IMPLEMENT ME
pushq   %rbp # push the base pointer.
movq    %rsp , %rbp # and copy stack pointer to RBP.

movq    $0 , %rax       # no vector registers in use for printf
leaq    string(%rip) , %rdi       # load address of a string
call    printf      # Call the printf

pushq   %rbp #push the base pointer.
movq    %rsp , %rbp # and copy stack pointer to RBP.

# input and increment it using my_increment
movq    $0 , %rax       # no vector registers in use for printf
leaq    basenum(%rip) , %rdi       # load address of a string
call    printf

subq    $16, %rsp        # Reserve stack space for variable
leaq    -16(%rbp) , %rsi      # Load address of stack variable in rsi
leaq    pow(%rip) , %rdi         # load first argument of scanf
movq    $0 , %rax       # no vector registers for scanf
call    scanf
movq    -16(%rbp), %rdi #load num into register


movq     %rbp, %rsp
popq     %rbp

mov     $0, %rdi    #call program exit code
call    exit    #exit the program

#my_pow:
        # IMPLEMENT ME
pushq   %rbp    #push the base pointer.
movq    %rsp , %rbp     #and copy stack pointer to RBP.

movq    $1 , %rax
movq    exponentnum(%rip) , %rcx
movq    basenum(%rip) , %rbx

call again
mul     %rbx

Loop:
again

