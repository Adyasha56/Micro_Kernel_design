# Microkernel Design

This project is an attempt to design a basic microkernel as a learning experience in operating system development. The kernel is written in **C** and **Assembly**, using a bootloader to load it into memory. The goal was to understand low-level concepts like memory segmentation, BIOS interrupts, and video memory manipulation.

## Project Structure

- **boot.s**: A simple bootloader written in assembly to load the kernel from the disk.
- **kernel.c**: The main kernel file, which sets up video mode and displays a message.
- **Makefile**: Automates the build process to assemble, compile, link, and create a bootable ISO image.

## Features

1. **Bootloader**: Loads the kernel from disk into memory.
2. **Simple Kernel**: Displays a message ("Hello from the kernel!") on the screen using video memory.

## Current Challenges

While building the project, the following issues were encountered:

- **Toolchain Issues**:
  - `i686-elf-gcc` and `i686-elf-ld` setup required significant effort on **MSYS2**.
  - Compatibility issues with linker flags like `-melf_i386` were resolved by adjusting tools and paths.
  
- **Infinite Loop Issue**: The kernel loops indefinitely (`hlt` and `jmp`) to ensure the system doesn't crash after the initial task is done.
  
- **BIOS Video Mode**: Setting the video mode works but doesn't match the memory access address `0xB8000` (used for text mode).

## How to Build and Run

### Prerequisites
- **NASM**: Assembler for the bootloader.
- **i686-elf-gcc**: Cross-compiler for the kernel.
- **QEMU**: Emulator to test the kernel.

### Build Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/Adyasha56/microkernel-design.git
   cd microkernel-design
   ```
2. Build the bootloader and kernel:
   ```bash
   make
   ```
3. Run the kernel using QEMU:
   ```bash
   make run
   ```

### Cleanup
To clean generated files:
```bash
make clean
```

## Known Issues
- **Unsupported Video Mode**: The kernel attempts to use video mode `0x13` (320x200, 256 colors) but reads video memory at `0xB8000` (text mode memory). This mismatch causes display issues.
- **Tool Compatibility**: The project relies on a specific GCC and LD configuration. Adapting it for other environments might require modifications.

## Next Steps
- Debug video memory access for proper display.
- Migrate to a more advanced bootloader to load larger kernel binaries.
- Explore basic multitasking and process management.

