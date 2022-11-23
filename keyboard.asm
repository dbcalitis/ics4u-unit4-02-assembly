; ---------------------------------------------------------------
; Read a 2 digit decimal number and then print it to the console.
; Runs on 64-bit x86 Linux only.
; Date: 2022-11-23, Author: Daria Bernice Calitis
; ---------------------------------------------------------------

section .bss
    variable: RESD 1               ; 4 bytes 

section .data
     newline db 10                  ; UNICODE 10 is new line character 
     inputDemand: db "Enter a 2 digit number: "
     inputDemandLen: equ $-inputDemand
     outputText: db "The number is: "
     outputTextLen: equ $-outputText
     doneText: db 10, "Done.", 10
     doneTextLen: equ $-doneText


section .text
    global _start                  ; entry point for linker

    _start:                        ; start here
        mov rax, 1
        mov rdi, 1
        mov rsi, inputDemand
        mov rdx, inputDemandLen
        syscall

        ; read 2 bytes from stdin 
        mov rax, 3                 ; 3 is recognized by the system as meaning "read"
        mov rdx, 0                 ; read from standard input
        mov rcx, variable          ; address of number to input
        mov rdx, 2                 ; number of bytes
        int 0x80                   ; call the kernel
        
        ; print a new line
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall

        ; print "The number is: "
        mov rax, 1                 ; system call for write
        mov rbx, 1                 ; file handle 1 is stdout
        mov rsi, outputText        ; address of string to output
        mov rdx, outputTextLen     ; number of bytes
        syscall                    ; invoke operating system to do the write

        ; print a byte to stdout
        mov rax, 4                 ; the system interprets 4 as "write"
        mov rbx, 1                 ; standard output (print to terminal)
        mov rcx, variable          ; pointer to the value being passed
        mov rdx, 2                 ; length of output (in bytes)
        int 0x80                   ; call the kernel

        ; print a new line
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall

        ; print "Done."
        mov rax, 1
        mov rdi, 1
        mov rsi, doneText
        mov rdx, doneTextLen
        syscall

        mov rax, 60                ; system call for exit 
        mov rdi, 0                 ; exit code 0 
        syscall                    ; invoke operating system to exit 
