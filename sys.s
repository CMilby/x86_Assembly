
section .data
	msg db "Call", 0x0a

section .text

global print_call
global print_string
global safe_exit
global string_length

print_call:					; For debugging purposes to see if the code is reached
	mov rsi, msg			; Just sets up the call constant
	mov rdx, 5				; Call length
	call print_string		; Print the string
	ret 					; Return

print_string:				; String in rsi, length in rdx
	mov rax, 0x2000004		; System call write
	mov rdi, 1				; Standard output
	syscall					; Invoke kernal
	ret						; Return

safe_exit:
	mov rax, 0x2000001		; Exit call
	mov rdi, 0				; Exit	
	syscall					; Invoke kernal
	
string_length:				; Assume string in r15
	xor al, al
	lea rdi, [r15]
	xor rcx, rcx
	dec rcx
	rep scasb
	inc rcx
	not rcx
	mov r15, rdi
	ret