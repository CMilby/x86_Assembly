
section .data  
	
section .text

extern absolute_value
extern is_negative
extern print_integer
extern print_string
extern safe_exit
extern string_length

global start

start:
	mov r15, 245
	call absolute_value
	call print_integer
	call safe_exit