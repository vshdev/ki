org 0x7c00
bits 32

cli                ; Disable interrupts
xor ax, ax         ; Clear AX
mov ss, ax         ; Set stack segment to 0x0000
mov sp, 0x7C00     ; Set stack pointer just below bootloader
sti                ; Enable interrupts

mov ax, 0x1000     ; ES: Segment to load kernel (0x1000:0000)
mov es, ax         ; Set ES to 0x1000
xor bx, bx         ; Start writing at offset 0x0000
mov ah, 0x02       ; Function: Read sectors
mov al, 16         ; Number of sectors to read (adjust for your kernel size)
mov ch, 0x00       ; Cylinder 0
mov cl, 0x02       ; Sector 2 (kernel starts here)
mov dh, 0x00       ; Head 0
mov dl, 0x00       ; Drive 0 (floppy disk)
int 0x13           ; BIOS interrupt to read sectors
jc disk_error      ; Jump if carry flag is set (read failed)

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