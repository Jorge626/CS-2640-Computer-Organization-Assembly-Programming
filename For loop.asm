# Author: CS2640
# Date: 4/15/2021
# Description : Implement the below code for "for loop"

# n = prompt ("Enter the value to calculate the sum up to: ")
# total = 0;		# Initial the total for sum
# for (i = 0; i < n; i++) {
#	total = total + i;
# }
# print("Total = " + total);

.data
input_prompt: .asciiz "Enter the value to calculate the sum up to: "
output_prompt: .asciiz "\nThe total is: "
msg1: .asciiz "To exit enter -1\nTo continue enter another integer: "
 
.text
main: 
	first_loop:
		#Print the choice message:
		li $v0, 4
		la $a0, msg1
		syscall
	
		# Read the value of choice and put in $s0
		li $v0, 5
		syscall
		move $s0, $v0
		
		beq $s0, -1, exit_loop1
		
		# Print the input prompt
		li $v0, 4
		la $a0, input_prompt
		syscall
	
		# Read the value and put in $t0
		li $v0, 5
		syscall
		move $t0, $v0
	
		li $t1, 0		# Assign $t1 to total variable and initialize total = 0
		li $t2, 0		# Assign $t2 to i variable, i = 0
	
		for_loop:
			add $t1, $t1, $t2		# total = total + i
			addi $t2, $t2, 1		# i++
			blt $t2, $t0, for_loop		# if i < n go to for loop
		
		exit_loop:
			# print the output message
			li $v0, 4
			la $a0, output_prompt
			syscall
		
			# print the total value
			li $v0, 1
			move $a0, $t1
			syscall
			j first_loop
			
		exit_loop1:
			#syscall to exit the code
			li $v0, 10
			syscall
