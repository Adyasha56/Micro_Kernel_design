; boot/boot.s - Bootloader

section .text
    global _start     ; Entry point for the bootloader

_start:
    cli               ; Disable interrupts
    mov ax, 0x07C0    ; Set up stack segment
    mov ss, ax
    mov sp, 0x7BFF    ; Stack pointer

    ; Load kernel
    mov bx, 0x1000    ; Address where kernel will be loaded
    mov dh, 1         ; Number of sectors to load
    mov dl, 0         ; Drive number (0 for floppy, 80h for hard drive)
    mov ah, 0x02      ; BIOS interrupt for disk read
    int 0x13          ; Call BIOS interrupt

    ; Check if the disk read was successful
    jc disk_error     ; Jump if carry flag is set (error occurred)

    ; Jump to the kernel
    jmp 0x1000        ; Jump to the loaded kernel

disk_error:
    ; Display an error message (e.g., via BIOS video)
    mov ah, 0x0E      ; BIOS teletype function
    mov al, 'E'       ; Print 'E'
    int 0x10
    mov al, 'R'       ; Print 'R'
    int 0x10
    mov al, 'R'       ; Print 'R'
    int 0x10
    mov al, 'O'       ; Print 'O'
    int 0x10
    mov al, 'R'       ; Print 'R'
    int 0x10

hang:
    hlt               ; Halt the CPU
    jmp hang          ; Infinite loop to halt the CPU
