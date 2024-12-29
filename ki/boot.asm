org 0x7c00
bits 32

cli
xor ax, ax
mov ss, ax
mov sp, 0x7C00
sti

mov ax, 0x1000     ; load to Here
mov es, ax  
xor bx, bx     
mov ah, 0x02       ;Read f()
mov al, 16
mov ch, 0x00       ; cylinder 0
mov cl, 0x02       ; sector 2
mov dh, 0x00       ; head 0
mov dl, 0x00       ; drive 0
int 0x13
jc disk_error

jmp 0x1000:0000

disk_error:
    mov ah, 0x0E
    mov al, 'E'
    int 0x10
    mov al, 'R'
    int 0x10
    int 0x10    ;; double print R
    mov al, 'O'
    int 0x10
    mov al, 'R'
    hlt

times 510 -($-$$) db 0
db 0x55, 0xAA 
