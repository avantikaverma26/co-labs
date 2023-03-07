# *********************************************************************************
# * Program name: inout                                                           *
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
    .asciz "Assignment 2"
string1:
    .asciz "Enter a number:"
# your strings here

.global my_main                         # make my_main accessible globally
.global my_increment                    # make my_increment accessible globally

my_main:              # set up the stack frame

call inout
formatstr : .asciz ”%ld” ...
subq $8, %rsp                    #Reserve stack space for variable leaq −8(%rbp) , %rsi # Load address of stack var in rsi
leaq formatstr(%rip ) , %rdi     # load first argument of scanf
movq $0 , %rax                   # no vector registers for scanf
call scanf                       # Call scanf


mov $0, %rdi
call exit # clear the stack and return

inout:

        # read input and increment it using my_increment

        call    my_increment

        # output incremented number

my_increment:
inc %rsi
    movq $mystring, %rdi
    call printf
    ret# IMPLEMENT ME
    
