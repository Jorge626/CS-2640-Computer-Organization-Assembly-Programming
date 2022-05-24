# Author CS2640	
# Date 4/13/2021
# Description: Simple for while loop
# The code will read an integer and print this integer
# The code will exit only if the integer is -1

.data
welcome: .asciiz "\n Welcome to add program. This code will add two integers. To exit type -1"
mesg0: .asciiz "\n The result of addition is:  "
mesg1: .asciiz "\n Please enter your first number: "
mesg2: .asciiz "\n Please enter your second number: "
mesg3: .asciiz "\n Please enter -1 if you want to exit.\n"
Good_bye: .asciiz "\nThank you for using our code"

.text
main:
	start_loop:
		# Display the message to enter the integer i
		li $v0, 4		
		la $a0, welcome
		syscall

		# Display the choice prompt
		li $v0, 4		
		la $a0, mesg3
		syscall

		# Read the integer i
		li $v0, 5
		syscall
		move $s0, $v0		# The integer value is in $s0
	 
		beq $s0, -1, exit_loop	# Loop conidition if the choice is -1 the loop will no be executed
		# Print the prompt to get the first number
		li $v0, 4
		la $a0, mesg1
		syscall
		
		# Read the first number and print it in $t0
		li $v0, 5
		syscall				
		move $t0, $v0		# The first number is in $t0
		
		# Print the prompt to get the second number
		li $v0, 4
		la $a0, mesg2
		syscall
		
		# Read the second number and put it in $t1
		li $v0, 5
		syscall				
		move $t1, $v0		# The first number is in $t0
		
		# Do addition
		add $t2, $t0, $t1	# Addition result saved in $t2
		
		# Print the prompt of the result
		li $v0, 4
		la, $a0, mesg0
		syscall
		
		# Print the result
		li $v0, 1
		move $a0, $t2
		syscall
		j start_loop
		
	exit_loop:
	li $v0, 4
	la $a0, Good_bye
	syscall
	
		
		
