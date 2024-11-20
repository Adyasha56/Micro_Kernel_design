# Makefile for compiling bootloader and kernel

# Define directories
BOOT_DIR = boot
KERNEL_DIR = kernel

# Define output filenames
BOOTLOADER = bootloader.bin
KERNEL = kernel.bin
KERNEL_OBJ = kernel.o
OS_IMAGE = myos.iso

# Define tools
ASM = nasm
CC = i686-w64-mingw32-gcc
LD = i686-w64-mingw32-ld

# Flags
ASM_FLAGS = -f bin
CC_FLAGS = -ffreestanding -m32 -Wall
LD_FLAGS = -Ttext 0x1000 --oformat binary

# Build bootloader
$(BOOTLOADER): $(BOOT_DIR)/boot.s
	$(ASM) $(ASM_FLAGS) $(BOOT_DIR)/boot.s -o $(BOOTLOADER)

# Build kernel object file
$(KERNEL_OBJ): $(KERNEL_DIR)/kernel.c
	$(CC) $(CC_FLAGS) -c $(KERNEL_DIR)/kernel.c -o $(KERNEL_OBJ)

# Link kernel object file and convert to binary
$(KERNEL): $(KERNEL_OBJ)
	$(LD) $(LD_FLAGS) $(KERNEL_OBJ) -o $(KERNEL)

# Build OS image
$(OS_IMAGE): $(BOOTLOADER) $(KERNEL)
	cat $(BOOTLOADER) $(KERNEL) > $(OS_IMAGE)

# Run OS in QEMU
run: $(OS_IMAGE)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMAGE)

# Clean all generated files
clean:
	rm -f $(BOOTLOADER) $(KERNEL_OBJ) $(KERNEL) $(OS_IMAGE)

.PHONY: clean run
