# Author: Jorge Aranda
# Date: 3/25/2021
# Description: My first MIPS Code
# This code will do g + h

.data
g: .word 5
h: .word 3
f: .word 0

.text
main: 
	li $t0, 15
	la $t1, g 		# put the address of g in t1
	la $t2, h 		# put the address of h in t2
	lw $t3, 0($t1) 		# t3 holds the value of g
	lw $t4, 0($t2) 		# t4 holds the value of h
	add $t5, $t3, $t4 	# t5 = g + h
	
	sw $t5, f		# store value of t5 in memory location f
	move $t6, $t5
	li $t1, 5
	add $t2, $t1, $t0
	