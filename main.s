
section .data  
	
section .text

extern absolute_value
extern is_negative
extern print_integer
extern print_string
extern random_number
extern safe_exit
extern string_length

global start

start:
	call random_number
	mov r15, rax
	call print_integer
	call safe_exit