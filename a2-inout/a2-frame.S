# *********
# * Program name: inout                                                           *
# * Description :                                                                 *
# *********

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
    string :
          .asciz "Assignment 2: inout\n"
    formatstr :
            .asciz "%ld"
    input:
            .asciz "Enter a number: "
    output:
            .asciz "The incremented number is: %ld \n"

.global my_main                         # make my_main accessible globally
.global my_increment                    # make my_increment accessible globally

my_main: # set up the stack frame

        pushq   %rbp # Prologue : push the base pointer.
        movq    %rsp , %rbp # and copy stack pointer to RBP.
        
        movq    $0 , %rax       # no vector registers in use for printf
        leaq    string(%rip) , %rdi       # load address of a string
        call    printf      # Call the printf routine

        call    inout   # clear the stack and return

        movq     %rbp, %rsp
        popq     %rbp
        ret

inout:
        pushq   %rbp # Prologue : push the base pointer.
        movq    %rsp , %rbp # and copy stack pointer to RBP.
        
        # input and increment it using my_increment
        movq    $0 , %rax       # no vector registers in use for printf
        leaq    input(%rip) , %rdi       # load address of a string
        call    printf      # Call the printf routine

        subq    $16, %rsp        # Reserve stack space for variable
        leaq    -16(%rbp) , %rsi      # Load address of stack var in rsi
        leaq    formatstr(%rip) , %rdi         # load first argument of scanf
        movq    $0 , %rax       # no vector registers for scanf
        call    scanf       # Call scanf
        movq    -16(%rbp), %r8
          

call  my_increment

        movq    %rbp , %rsp     # Epilogue : clear local variables from stack.
        popq    %rbp    # Restore caller ’s base pointer
            
        mov     $0, %rdi
        call exit





my_increment: # IMPLEMENT ME
        push %rbp
        movq %rsp, %rbp

        movq    %r8, %rax
        incq    %rax      # incrementing user input
        movq    %rax, %r8 #call printf


        movq  %r8, %rsi
        movq  $0, %rax
        leaq output(%rip), %rdi
        call printf

    
        movq    %rbp , %rsp     # Epilogue : clear local variables from stack.
        popq    %rbp    # Restore caller ’s base pointer.
        
        ret
