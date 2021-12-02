###### Calculate the average value of an array of numbers ########

.data										# this .data section is where you can simulate stored data in random access memory 

	array:		.word 1, 0, 0, 2, 9			# you can write any label which ends in a colon such as 'array:'
	length:		.word 5						# number of elements in array label array above
	
	
.text										# this section is where you write your main script

	main:
		la		$t0, array					# la is load address base address  <---- loads the base ADDRESS of the array into $t0
		li		$t1, 0						# load immediate ie load constant 0 to register $t1 
		lw		$t2, length					# store length 5 into $t2
		li		$t3, 0 						# sum = 0
			
	while:
		beq		$t1, $t2, calc_avg			# break loop if index value of array equals length of array by jumping to the calc_avg procedure.
		sll		$t4, $t1, 2					# multiply the index value of the array by 4 to get the byte size.
		lw		$t5, array($t4)				# load the value at the byte position within the array into temp register 13.
		add		$t3, $t3, $t5				# add the current value of the array to the sum
		addi	$t1, $t1, 1					# increment the index value by 1
		j		while						# start the loop again
		
	
	calc_avg:
		div		$t6, $t3, $t1				# divide the sum by the length of the array and store in register 14.
		li		$v0, 1						# add print instruction to stack
		addi	$a0, $t6, 0					# load the average value to function argument register 4.
		syscall								# invoke the syscall function

		li $v0 10							# THIS IS A GOOD WAY TO END THE PROGRAM BY PUTTING THE VALUE 10 INTO $v0 AND USING SYSCALL
		syscall
