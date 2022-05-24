# Author CS2640	
# Date 4/13/2021
# Description: Simple for while loop
# Midterm 2: Transalte C Code into MIPS
# int fib(int n)
# {
#    // Stop condition
#
#   if (n == 0)
#      return 0;
#    // Stop condition
#    if (n == 1 || n == 2)
#        return 1;
#    // Recursion function
#    else
#        return (fib(n - 1) + fib(n - 2));
#}
#main()
#{
#    // get n from user.
#    cout<<"Please enter n: ";
#    cin>> n;
#    // Output is series of Fibonacci
#    cout<<"Fibonacci series of 5 numbers is: ";
#    // for loop to print the fiboancci series.
#    for (int i = 0; i < n; i++)
#    {
#        cout<<fib(i)<<" ";
#    }
#}

.data
promptn: .asciiz "Please, enter n: "
promptfibonacci: .asciiz "Fibonacci series of n numbers is: "
spacing: .asciiz " "

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
	la $s0, ($a0)
	
	
	jal fib
	move $s1, $v0		# Save the return value in $s0 to avoid $v0 overwrite
	
	# Output the result statements
	la $a0, promptfibonacci
	li $v0, 4
	syscall
	
	li $t2, 0		# Assign $t2 to i variable, i = 0
	for_loop:
		lw $a0, ($sp)
		li $v0, 4
		syscall 
		addi $sp, $sp, 4
		
		# Print spacing
		la $a0, spacing
		li $v0, 4
		syscall
		addi $t2, $t2, 1		# i++
		blt $t2, $s0, for_loop		# if i < n go to for loop
	
exit:
	li $v0, 10
	syscall
	
fib:
	# Push the needed values to stack
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, ($sp)
	
	# Body of function
	slti $t0, $a0, 0		# Set $t0 = 0 if $a0 < 1
	beq $t0, $0, if0		# Go to if if $t0 = 0
	beq $t0, 1, ifOr		# Go to ifOr if n==1
	beq $t0, 2, ifOr		# Go to ifOr if n==2
	
	if0:
		addi $v0, $0, 0			# Return 0 if n == 0
		jr $ra
	ifOr:
		addi $v0, $0, 1 		# Return 1 if n==1
		jr $ra
	
	# else statement
	addi $a0, $a0, -1		# n = n - 1
	jal fib				# fib(n-1)	
	sw $a0, ($s2) 			# Save contents of fib(n-1) in $s2
	addi $a0, $a0, -1		# n = n - 2
	jal fib				# fib(n-2)
	sw $a0, ($s3)			# Save contents of fib(n-2) in $s3
	add $a0, $s2, $s3		# add fib(n-1) and fib(n-2) into $a0
	jr $ra				# Return (fib(n-1) + fib(n-2))