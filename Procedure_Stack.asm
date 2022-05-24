# Author CS2640	
# Date 4/22/2021
# Description: Example of leaf procedure

.data
g: .word 7
h: .word 8
i: .word 5
t: .word 3

.text
main:
	lw $a0, g		# assign g to $a0
	lw $a1, h		# assign h to $a1
	lw $a2, i		# assign i to $a2
	lw $a3, t		# assign j to $a3
	
	jal leaf_example
	
exit:
	li $v0, 10
	syscall
	
leaf_example:
	# Save the value of the registers that will be used in the body of procedure in the stack
	addi $sp, $sp, -12
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	sw $s1, ($sp)
	
	# The body of the procedure
	add $t0, $a0, $a1		# $t0 = g+h
	add $t1, $a2, $a3		# $t1 = i + t
	sub $s0, $t0, $t1		# $s0 = (g + h) - (i + t)
	
	# Return the result
	move $v0, $s0
	
	# Pop the save value from the stack
	lw $s0, ($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	addi $sp, $sp, 12
	
	# Jump to return address
	jr $ra
	

