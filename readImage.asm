readImage: # $a0: file name (string), $a1: file size, returns $v0: memory address
	move $t0, $a0
	move $t1, $a1
	
	move $a0, $a1 # Number of bytes to allocate
	li $v0, 9     # Syscall for allocating memory
	syscall
	
	move $t2, $v0 # Memory address allocated

	move $a0, $t0 # File name
	li $a1, 0     # Open flags (none)
	li $a2, 0     # Open mode (0 = read)
	li $v0, 13    # Syscall for open file
	syscall
	
	move $t0, $v0 # File descriptor/pointer, will be needed to close later on

	move $a0, $t0 # File descriptor/pointer
	move $a1, $t2 # Address of where we're going to write this data into
	move $a2, $t1 # Maximum characters to read (in our case, it's equivalent to the file size)
	li $v0, 14    # Syscall for read from file
	syscall

	move $a0, $t0 # File descriptor/pointer
	li $v0, 16    # Syscall for close file
	syscall
	
	move $v0, $t2

	jr $ra