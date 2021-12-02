###### Fibonacci series generator ########

.data
	ln_brk:		.asciiz "\n"		# newline character to help with stdout formatting.
	limit:		.word 10			# number of fibonacci values to calculate.

.text
	main:
		li		$t0, 0				# set first initial value 0 to register 8.
		li		$t1, 1				# set second initial value 1 to register 9.
		lw		$s0, limit			# load the number of fib values (10 in this case) to calculate into register 16.
		li		$s1, 0				# initialise a loop counter to 0.
		add		$t2, $t0, $t1		# add the last two values of the fib values to get the next value and save in register 10.
		jal		stdout				# call the stdout function which prints the current fib value to the screen.
		
	while: 
		beq		$s1, $s0, exit		# breaks loop if loop counter equals to number of fib values required.
		move	$t0, $t1			# shift the last but one value of the fib series to register 8.
		move	$t1, $t2 			# shift last value ie the current fib value to register 9.
		add		$t2, $t2, $t0		# add the last two values in the fib series to get the next value.
		addi	$s1, $s1, 1			# increment the counter by one.
		jal		stdout				# call the stdout function which prints the current fib value to the screen.
		j		while				# restart the loop.
		
	exit: 
		li	$v0, 10					# load the exit instruction.
		syscall						# trigger exit program. 
		
	stdout:
		li 	$v0, 1					# load print integer instruction.
		addi 	$a0, $t2, 0			# register the current fib value as function argument.
		syscall						# call the print integer instruction with the fib value argument.
		
		# print a line break to prettify the stdout.
		li 	$v0, 4
		la 	$a0, ln_brk
		syscall
		
		jr	$ra						# return to the caller stack.
		