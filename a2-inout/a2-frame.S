# ***************************
# * Program name: inout                                                           *
# * Description :                                                                 *
# ***************************

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
    mystring :
          .asciz "Assignment 2: inout\n"
    formatstr :
            .asciz "%ld"
    input:
            .asciz "Enter a number: "
    output:
            .asciz "The incremented number is: %ld \n"

.global my_main                         # make my_main accessible globally
.global my_increment                    # make my_increment accessible globally

my_main:
        # set up the stack frame
        pushq   %rbp # Prologue : push the base pointer.
        movq    %rsp , %rbp # and copy stack pointer to RBP.

        movq    $0 , %rax       # no vector registers in use for printf
        leaq    mystring(%rip) , %rdi       # load address of a string
        call    printf      # Call the printf routine

        call    inout   # clear the stack and return

        mov     $0,%rdi  # set exit code to 0
        call    exit        # exiting program

inout:
        # read input and increment it using my_increment
        movq    $0 , %rax       # no vector registers in use for printf
        leaq    input(%rip) , %rdi       # load address of a string
        call    printf      # Call the printf routine

        subq    $16, %rsp        # Reserve stack space for variable
        leaq    -16(%rbp) , %rsi      # Load address of stack var in rsi
        leaq    formatstr(%rip) , %rdi         # load first argument of scanf
        movq    $0 , %rax       # no vector registers for scanf
        call    scanf       # Call scanf
        movq    %rdi,%rax

        call    my_increment        # call my_increment

        movq    %rbp , %rsp     # Epilogue : clear local variables from stack.
        popq    %rbp    # Restore caller ’s base pointer.

        ret     # return from subroutine.
          
my_increment:
    #inc %rsi
    #movq $output, %rdi
    #call printf
    #ret# IMPLEMENT ME
