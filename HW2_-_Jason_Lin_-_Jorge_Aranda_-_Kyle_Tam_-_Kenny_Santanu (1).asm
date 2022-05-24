# Author: Group 4
# Group 4 members: Jason Lin, Jorge Aranda, Kyle Tam, Kenny Santanu
# Date: 04/22/21
#
# Description HW #2:
# Write MIPS code to sort the data in the table above from highest to lowest.
# Save the sorted table in memory where the highest value in the smallest memory location.
# Use a minimum number of MIPS instructions.
# 
# int array ={2,5,1, 9, 30, 4, 25, 10, 40, 56, 23, 17, 8, 3, 6}

.data
Array: .word 2 5 1 9 30 4 25 10 40 56 23 17 8 3 6
opening_msg: .asciiz "Hello, this is our code for HW #2. \nThis program sorts an array from highest value to lowest value.\n"
display_array: .asciiz "Original array: 2, 5, 1, 9, 30, 4, 25, 10, 40, 56, 23, 17, 8, 3, 6.\n"
sorted_array_prompt: .asciiz "The sorted array is: "
spacing: .asciiz ", "

.text
main:
	# Print opening message.
	li $v0, 4
	la $a0, opening_msg
	syscall
	
	# Print the original array.
	li $v0, 4
	la $a0, display_array
	syscall
	
	# Load the array and provide 60 bytes of space.
	la $t0, Array
	add $t0, $t0, 56
	
	# sort loop in the memory
	outer_loop:
		add $t1, $0, $0               # $t1 is the flag to signify if the list is sorted or not.
		la $s0, Array                 # Load the array into $s0.
	inner_loop:
		lw $t2, 0($s0)                # Set $t2 to the current element of the array.
		lw $t3, 4($s0)                # Set $t3 to the next element of the array.
		
		slt $t5, $t2, $t3             # Checks if $t2 is less than $t3; if yes, $t5 = 1
		beq $t5, $0, continue_loop    # If $t5 = 0, skip the swap and check to see if the loop should continue.
		add $t1, $0, 1                # Set $t1 to 1 to indicate that the list needs to be checked again for swaps.
		
		sw $t2, 4($s0)                # Store the greater numbers in the higher element of the array.
		sw $t3, 0($s0)                # Store the lower numbers in the lower element of the array.
	continue_loop:
		addi $s0, $s0, 4              # Increment to change starting position of array on next iteration.
		bne $s0, $t0, inner_loop      # If $s0 != $t0 (the end of the array), jump back to inner_loop.
		bne $t1, $0, outer_loop       # If $t1 = 1, jump back to outer_loop to check for swaps.
		
	# Print prompt for the sorted array.
	li $v0, 4
	la $a0, sorted_array_prompt
	syscall
		
	# Clear $t0 to 0 to be used as index
	addi $t0, $zero, 0
	
	# print out the sorted array from index 0 to 14
	while:
		beq $t0, 60, exit		# Checks to see if the index is out of range for Array
		lw $t6, Array($t0)		# Loads value at index into $t6
		addi $t0, $t0, 4		# Increments our index ($t0) 4 bytes to iterate to next value
		
		# Prints current number
		li $v0, 1			# Loads value at index
		move $a0, $t6			# Moves value to $a0
		syscall				# Prints value
			
		# Prints a comma and adds space
		li $v0, 4
		la $a0, spacing
		syscall
			
		j while
		
	exit:
		# Ends Program
		li $v0, 10
		syscall
