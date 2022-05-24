# Author CS2640	
# Date 4/27/2021
# Description: Factorial example, Recursion
# int fact(int n) {
#	if (n < 1) 
#		return f; # f=1 (0! = 1)
# 	else 
#		return n * fact(n-1); }
# n is saved in $a0
.data
promptn: .asciiz "Please, enter n: "
promptfunct: .asciiz " The factorial is: "

.text
main:
	# Print prompt n
	la $a0, promptn
	li $v0, 4
	syscall
	
	# Read n
	li $v0, 5
	syscall
	move $a0, $v0
	
	jal fact
	move $s0, $v0		# Save the return value in $s0 to avoid $v0 overwrite
	# Output the result
	la $a0, promptfunct
	li $v0, 4
	syscall
	
	# Print the factorial value
	move $a0, $s0
	li $v0, 1
	syscall
	
exit:
	li $v0, 10
	syscall

fact:
	# Push the needed values to stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, ($sp)
	
	# Body of function
	slti $t0, $a0, 1		# Set $t0 = 1 if $a0 < 1
	beq $t0, $0, L1			# Go to L1 if $t0 = 0
	
	addi $v0, $0, 1			# Return 1 as factorial
	addi $sp, $sp, 8
	jr $ra
	L1:
		addi $a0, $a0, -1		# n = n - 1
		jal fact			# fact(n-1)
	lw $a0, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	mul $v0, $a0, $v0			# %v0 = n * fact(n-1)
	jr $ra
	
