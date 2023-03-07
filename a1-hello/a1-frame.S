# ***************************
# * Program name: Hello World                                                     *
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
    exit: jmp _exit
#endif
.data
string:
    .asciz "Assignment 1: Avantika Verma ave231 , Madhav Chawla mch241"



.text
.global my_main                   # make my_main accessible globally

my_main:

movq $0, %rax   # checking if the registor is empty
leaq string(%rip), %rdi # copying the string address to rdi
call printf


end:
mov $0, %rdi
call exit

