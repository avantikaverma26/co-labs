# *********************************************************************************
# * Program name: factorial                                                       *
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
      .asciz "Assignment 4: factorial\n"
num:
        .asciz "Enter a number:\n"
text:
        .asciz "The factorial is: %ld \n"
result:
        .asciz "%ld"

.global my_main
.global factorial


my_main:
    pushq   %rbp #push the base pointer.
    movq    %rsp , %rbp # and copy stack pointer to RBP.
   
    movq    $0 , %rax       # no vector registers in use for printf
    leaq    num(%rip) , %rdi   # load address of a string
    call    printf

    subq    $16, %rsp        # Reserve stack space for variable
    leaq    -16(%rbp) , %rsi      # Load address of stack variable in rsi
    leaq    result(%rip) , %rdi         # load first argument of scanf
    movq    $0 , %rax       # no vector registers for scanf
    call    scanf #scanning the user input
    movq    -16(%rbp), %rcx #the user input is then stored in rcx

    movq    $1, %rax    #initializing rax with 1
    
    call    factorial #calling the function

    movq    %rbp , %rsp     # clear variables from stack.
    popq    %rbp    # Restore base pointer
    ret

factorial:
    pushq   %rbp    #push the base pointer.
    movq    %rsp , %rbp   #and copy stack pointer to RBP.
  
    cmpq    $0, %rcx #we check if the user input is 0
    je      end #if the value is 0 , the function then jumps to the end
    mulq    %rcx    #the rcx value is multiplied
    decq    %rcx    # the value is then decremented
    call    factorial #the function is called again (recurssion)

end:
    movq    %rax, %rsi #load second argument
    movq    $0, %rax    #no vector argument in use for printf
    leaq    text(%rip), %rdi #load address of text to rdi
    call    printf

    mov     $0, %rdi    #call program exit code
    call    exit    #exit the program




