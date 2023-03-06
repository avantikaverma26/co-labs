# ***************************
# * Program name: Hello World                                                     *
# * Description :  this is a simple display text to terminal function                                                               *
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

.text
mystring: .asciz "Madhav mch241 - Avantika avanz”

.global my_main                        

my_main:
 movq $0 , %rax
 leaq mystring (% rip ) , %rdi  
 call printf    

 end:   
    mov $0, %rdi    
    call exit
