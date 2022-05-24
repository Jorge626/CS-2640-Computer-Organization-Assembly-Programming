# Author CS2640	
# Date 4/22/2021
# Description: Compute the average
# int avg(int x, int y) {
# 	int result = 0;
#	result = (x+y)/2;
# return result; }

.data
x: .word 10
y: .word 4

.text
main:
	lw $a0, x		# assign $a0 to x
	lw $a1, y		# assign $a1 to y
	# Call the procedure average
	jal average
	
exit: 
	li $v0, 10
	syscall 
	
average:
	# Push the used registers into the stack
	addi $sp, $sp, -4
	sw $s0, ($sp)		# push $s0
	
	# The body of the procedure
	add $t0, $a0, $a1		# $t0 = x + y
	srl $s0, $t0, 1			# $s0 = (x + y) / 2
	
	# Return result
	move $v0, $s0
	
	# Pop the saved values from the stack
	lw $s0, ($sp)
	addi $sp, $sp, 4
	
	# Jump to return address
	jr $ra
	