# *
# * Program name: inout                                                           *
# * Description :                                                                 *
# *

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
# your strings here
    string:
          .asciz "Assignment 2: inout\n"
    inputnum:
            .asciz "Enter a number: "
    text:
            .asciz "The incremented number is: %ld \n"
    num:
            .asciz "%ld"

.global my_main                         # make my_main accessible globally
.global my_increment                    # make my_increment accessible globally

my_main: # set up the stack frame

        pushq   %rbp # push the base pointer.
        movq    %rsp , %rbp # and copy stack pointer to RBP.
        
        movq    $0 , %rax       # no vector registers in use for printf
        leaq    string(%rip) , %rdi       # load address of a string
        call    printf      # Call the printf

        call    inout   # clear the stack and return

        movq     %rbp, %rsp
        popq     %rbp
        ret

inout:
        pushq   %rbp #push the base pointer.
        movq    %rsp , %rbp # and copy stack pointer to RBP.
        
        # input and increment it using my_increment
        movq    $0 , %rax       # no vector registers in use for printf
        leaq    inputnum(%rip) , %rdi       # load address of a string
        call    printf

        subq    $16, %rsp        # Reserve stack space for variable
        leaq    -16(%rbp) , %rsi      # Load address of stack variable in rsi
        leaq    num(%rip) , %rdi         # load first argument of scanf
        movq    $0 , %rax       # no vector registers for scanf
        call    scanf
        movq    -16(%rbp), %rdi #load num into register

        call    my_increment
        
        movq    %rax, %rsi #load second argument
        movq    $0, %rax    #no vector argument in use for printf
        leaq    text(%rip), %rdi #load address of text to rdi
        call    printf

        movq    %rbp , %rsp     # clear variables from stack.
        popq    %rbp    # Restore base pointer
            
        mov     $0, %rdi    #call program exit code
        call    exit    #exit the program


my_increment: # IMPLEMENT ME

        pushq   %rbp    #push the base pointer.
        movq    %rsp , %rbp     #and copy stack pointer to RBP.

        incq    %rdi      # incrementing user input

        movq %rdi, %rax
        
        movq    %rbp , %rsp     # clear variables from stack.
        popq    %rbp    # Restore base pointer

        ret
