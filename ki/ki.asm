; [-------------------]
; [ || //  ||||  //|  ]
; [ |||     ||    ||  ]
; [ || \\  ||||  |||| ]
; [-------------------]

; the KI Kernel
; version a.0

bits 64
org 0x1000:0000

section .text:
    global _start
    global ki_print         ; These can be used as extern voids for C development
    global ki_setpointer

_start:
    call init_VGA
    call init_KBUSB
    call init_fs

    call display_tests
    call main

ki_print:
    ; basically printf
    mov ah, 0x0e
    jmp .printloop
.printloop:
    mov al, [edx]
    int 0x10
    cmp al, 0
    je endf
    inc edx
    jmp .printloop

ki_setpointer:
    ; set the pointer where the 

init_VGA:
    mov ah, 0x00    ;; Set Display Modes
    mov al, 0x07    ;; Mode 7: 80 By 25, Mono Colour
    int 0x10        ;; Call
    jmp endf

init_KBUSB:
    ; Do Later

init_FS:
    ; Do Later

endf:
    ret

display_tests:
    mov edx, ["TEST", 0]
    call ki_print