// kernel/kernel.c - Simple kernel

void _start() {
    // Set video mode to 0x13 (320x200, 256 colors)
    asm volatile (
        "mov $0x13, %%ax\n\t"  // Set video mode
        "int $0x10\n\t"        // BIOS interrupt for video services
        :
        :
        : "ax"                 // Clobber register ax
    );

    // Print a simple message on screen
    char *video_memory = (char *)0xB8000;  // Video memory address for text mode
    char *message = "Hello from the kernel!";

    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i * 2] = message[i];   // Character
        video_memory[i * 2 + 1] = 0x07;    // Attribute (white on black)
    }

    // Hang the system - proper infinite loop using inline assembly
    asm volatile (
        "1: hlt\n\t"         // Halt the CPU
        "jmp 1b\n\t"         // Jump back to the "1" label (infinite loop)
        :
        :
        : "memory"           // Inform the compiler that we are modifying memory
    );
}
