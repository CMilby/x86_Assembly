
section .data  
	
section .text

extern absolute_value
extern clamp 
extern factorial
extern min 
extern max
extern to_power

extern is_negative
extern is_prime

extern print_integer
extern print_string

extern safe_exit

global start

start:
	; -- Absolute Value -- 
	mov r15, -124
	call absolute_value
	mov r10, 'Abs: '
	push r10 
	mov rsi, rsp
	mov rdx, 6
	call print_string
	call print_integer

	; -- Clamp --
	mov r13, 100
	mov r14, 150
	mov r15, 128
	call clamp
	mov r10, 'Clamp: '
	push r10 
	mov rsi, rsp
	mov rdx, 7
	call print_string
	call print_integer

	; -- Factorial --
	mov r15, 5
	call factorial
	mov r10, '5! = '
	push r10 
	mov rsi, rsp
	mov rdx, 5
	call print_string
	call print_integer

	; -- Min --
	mov r14, 1025
	mov r15, 2192
	call min
	mov r10, 'Min: '
	push r10 
	mov rsi, rsp
	mov rdx, 5
	call print_string
	call print_integer

	; -- Max -- 
	mov r14, 1025
	mov r15, 2192
	call max
	mov r10, 'Max: '
	push r10 
	mov rsi, rsp
	mov rdx, 5
	call print_string
	call print_integer

	; -- To Power --
	mov r14, 10
	mov r15, 2
	call to_power
	mov r10, '2^10 = '
	push r10 
	mov rsi, rsp
	mov rdx, 7
	call print_string
	call print_integer

	; -- Is Negative --
	mov r15, 219
	call is_negative
	mov r10, 'Neg: '
	push r10 
	mov rsi, rsp
	mov rdx, 5
	call print_string
	call print_integer

	; -- Is Prime -- 
	mov r15, 193
	call is_prime
	mov r10, 'Prime: '
	push r10 
	mov rsi, rsp
	mov rdx, 7
	call print_string
	call print_integer

	call safe_exit