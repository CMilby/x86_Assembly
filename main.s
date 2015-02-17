
section .data  
	
section .text

extern min 
extern max
extern clamp 
extern absolute_value
extern is_negative
extern print_integer
extern print_string
extern random_number
extern safe_exit
extern string_length

global start

start:
	mov r13, 100 
	mov r14, 200
	mov r15, 120
	call clamp
	call print_integer
	call safe_exit