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
    global ki_scan
    global ki_setTextBackground
    global ki_setTextForeground

_start:
    call init_VGA
    ;call init_KBUSB
    ;call init_fs
    call main

;
;
;   GLOBAL FUNCTIONS
;
;

ki_print:
    ; basically printf
    ki_print:
    ; RDI = Pointer to string
    mov rsi, 0xB8000           ; VGA text buffer start
.printloop:
    mov al, [rdi]              ; Get character from string
    test al, al                ; Check for null terminator
    je endf
    mov [rsi], al              ; Write character to buffer
    inc rsi
    mov byte [rsi], 0x07       ; Attribute: white on black
    inc rsi                    ; Move to next position
    inc rdi
    jmp .printloop

ki_setpointer:
    ; set the Display Writing Pointer
    ;; Do Later

ki_setTextForeground:
    ;; Do Later

ki_setTextBackground:
    ;; Do later


ki_readf:
    push rbx
    xor rbx, rbx

.read_loop:
    call getchar
    cmp al, 0x0A
    je .done_input
    cmp al, 0x08
    je .handle_backspace
    cmp rbx, rsi
    jae .read_loop
    mov [rdi + rbx], al
    inc rbx
    call putchar
    jmp .read_loop

.handle_backspace:
    cmp rbx, 0
    je .read_loop
    dec rbx
    mov byte [rdi + rbx], 0
    call putchar_backspace
    jmp .read_loop

.done_input:
    mov byte [rdi + rbx], 0
    pop rbx
    ret
getchar:
    push rdx
.wait_key:
    in al, 0x64
    test al, 1
    jz .wait_key
    in al, 0x60
    call scancode_to_ascii
    pop rdx
    ret

scancode_to_ascii:
    cmp al, 0x1C
    je .return_newline
    cmp al, 0x0E             
    je .return_backspace

    sub al, 0x10              
    ret

.return_newline:
    mov al, 0x0A
    ret

.return_backspace:
    mov al, 0x08
    ret
putchar:
    ret
putchar_backspace:
    ret

;;
;;
;;  DRIVERS AND INTIALIZATIONS
;;
;;

init_VGA:
    mov ah, 0x00    ;; Set Display Modes
    mov al, 0x07    ;; Mode 7: 80 By 25, Mono Colour
    int 0x10        ;; Call
    jmp endf

init_KBUSB:
    ; Do Later

init_FS:
    ; Do Later

init_idt:
    ;;Do Later
    
;
;
; GLOBAL RETURN FUNCTION
;
;
endf:
    ret

;
;
; mainloop
;
;
main:
    ; this is basically just a Shell Environment



    mov edx, ["shell $", 0]
    call ki_print
    
    
    ; Looping
    jmp main

section .bss
    input_buf resb 256

section .data
idt_ptr:
    dw 256 * 16 - 1
    wq idt_table
idt_table:
    times 256 dq 0
