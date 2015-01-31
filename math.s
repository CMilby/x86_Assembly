
section .data
	msg db "Call", 0x0a

section .text

extern print_call

global absolute_value
global factorial
global is_negative
global is_prime
global print_integer
global to_power

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
is_negative:					; Assume value in r15
	cmp r15, 0 					; Check number compared to 0
	jl is_negative_is			; If number less than, it's negative
	je is_negative_zero			; If zero, return 0
	mov r15, 1 					; Else it's positive, return 1
	ret 						; Return

is_negative_is:
	mov r15, -1					; If negative, return -1
	ret 						; Return

is_negative_zero:			
	mov r15, 0 					; If 0, return 0
	ret 						; Return

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
factorial:						; Assume number in r15
	mov r14, r15				; Move r15 to r14

factorial_loop:
	dec r15						; Subtract 1 from r15
	mov rax, r15				; Move r15 to rax
	mov rdx, r14				; Move total to rdx
	mul rdx						; rax * rdx
	mov r14, rax				; Move total to r14
	cmp r15, 1 					; Compare counter to 1
	jne factorial_loop			; If not equal, loop
	mov r15, r14
	ret

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
absolute_value: 				; Assume number in r15
	push r15
	call is_negative 			; Check if negative 
	cmp r15, -1 				; Compare return value to -1 
	je absolute_value_negative 
	pop r15
	ret

absolute_value_negative:
	pop rax
	mov rdx, -1
	imul rdx
	mov r15, rax
	ret 

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
to_power:						; Assume power in r14, value in r15
	mov r13, r15				; Move value into r13 (total)

to_power_loop:
	mov rax, r13				; Move r13 to rax for multiplication
	mov rdx, r15				; Move r15 to rdx for multiplication
	imul rdx						
	mov r13, rax				; Move product to r13
	dec r14						; Decrement counter
	cmp r14, 1					; Compare counter, check if should loop
	jg to_power_loop			; Loop
	mov r15, r13				; Move total to r15
	ret 						; Return

; - - - - - - - - - - — - - - - - - - - - - - - - - - - - - - - - - - - - 
is_prime:						; Assume integer in r15
	mov rax, r15				; Move r15 to rax for divison
	xor rdx, rdx				; Avoids error
	mov rcx, 2			
	div rcx						; rax = rdx:rax / rcx|rdx = rdx:rax % rcx
	cmp rdx, 0					; If remainder is 0, not prime
	je is_prime_not_exit		; Not prime, exit
	mov r14, 3

is_prime_loop:					; Loop to check for primes
	mov rax, r15				; Move r15 to rax for division
	xor rdx, rdx				; Clear for division
	mov rcx, r14				; Move counter to quotient
	div rcx						; Divide
	cmp rdx, 0					; Compare remainder to 0
	je is_prime_not_exit		; If 0, not prime, exit
			
	mov rax, r14				; Counter in register
	mov rdx, r14				; Same value in both registers
	mul rdx						; Multiply together
	add r14, 2					; Increment counter
	cmp rax, r15				; Compare values
	jle is_prime_is_exit		; Is prime!
	call is_prime_loop			; Jump else	

is_prime_is_exit:
	mov r15, 1					; Move 1 if prime
	ret							; Return

is_prime_not_exit:
	mov r15, 0					; Move 0 if not prime
	ret							; Return 

; - - - - - - - - - - — - - - - - - - - - - - - - - - - - - - - - - - 
print_integer:					; Assume integers is in r15
	push 0x0a					; Push an endline character
	mov r13, 0x00 				; Save empty character in case of ngative
	mov r14, 2					; Setup counter
	push r15					; Push number to stack to save 
	call is_negative 			; Check if number is negative
	cmp r15, -1 					; If 0, it's negative
	je print_integer_negative	; Check for negative
	pop r15						; Pop new number off stack

print_integer_stack_loop:
	mov rax, r15				; Move r15 to rax for divison
	xor rdx, rdx				; Avoids error
	mov rcx, 10					; Divisor because base 10
	idiv rcx					; rax = rdx:rax / rcx|rdx = rdx:rax % rcx
	add rdx, '0'				; Convert 0-9 to ‘0’-‘9’
							
	push rdx					; Push remainder to stack
	mov r15, rax				; Move quotient to r15 register		
	inc r14						; Counter + 1	

	cmp r15, 0					; Compare quotient to 0
	jne print_integer_stack_loop; If not zero, loop
	push r13

print_integer_print_loop:		; Characters are now on stack in reverse order
	mov rsi, rsp				; Put remainder in rsi
	mov rdx, 1					; Print 1 char (length)
	mov rax, 0x2000004			; System call write
	mov rdi, 1					; Standard output, number of bytes
	syscall						; Invoke kernal
		
	dec r14						; Counter - 1
	pop r15						; Remove off top of stack
	cmp r14, 0 					; Compare counter to 0
	jne print_integer_print_loop; Loop 
	ret							; Return

print_integer_negative:			; Called when integer is negative
	inc r14						; Incriment counter for negative sign
	pop rax						; Pop the number off the stack into rax
	mov rbx, -1 				; -1 in rbx to flip sign
	imul rbx					; Multiply so new number is positive
	mov r15, rax				; Move number to r15 for division
	mov r13, '-'				; r13 is gonna save the negative sign
	call print_integer_stack_loop
