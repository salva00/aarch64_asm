/*
===============================
Assembly example 1: Hello World
===============================


This is a simple example of a program that prints "Hello World!" to the console.
The program uses the Unix system call interface to write the string to the console.

X0-X2 - parameters to Unix system calls
X16 - Mach System Call function number

Unlike generic AArch64 assembly, the Silicon processors:
- Do not use the X18 register. It is reserved for the kernel.
- X16 is used to specify the system call number. (X8 in linux)
- Frame Pointer register (FP, X29) must always address a valid frame record.
- The call for interrupt is 0x80 (svc #0x80) instead of 0x0 (svc #0x0) in linux.
- X0 is used to specify the return code for the system call.

*/

.global _start			// Provide program starting address to linker
.align 4				// Make sure everything is aligned properly, it is done to silence the linker warning

/*
In order to print "Hello World!" to the console, we need to:
	1. Setup the parameters to print "Hello World!".
	2. Call the kernel to print the string.
	3. Setup the parameters to exit the program.
	4. Call the kernel to exit the program.

The Assembler marks the statement containing "_start" as the program entry point; then the linker can find it
because it has been defined as a global variable. A program can consist of multiple .s files, but only one file can contain _start.
*/
_start:
	mov	X0, #1			// Move the immediate #1 into register X0 to specify the file descriptor for stdout
	adr	X1, helloworld 	// Load the address of the string into register X1
	mov	X2, #13	    	// Move the immediate #13 into register X2 to specify the length of the string
	mov	X16, #4			// System call number 4 writes the string to the console, always see syscalls.master in Silicon directory.
	svc	#0x80			// Call kernel to write the string to the console

	mov     X0, #0		// Move the immediate #0 into register X0 to specify the return code
	mov     X16, #1		// System call number 1 exits the program
	svc     #0x80		// Call kernel to terminate the program

// data section
// The .ascii statement tells the Assembler just to put our string in the data section
helloworld:      .ascii  "Hello World!\n"

