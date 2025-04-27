loadImageToMemory: # $a0: file name, $a1: image size, $a2: index to be stored, $a3: memory location
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	sll $t3, $a2, 2
	add $t3, $t3, $a3

	jal readImage # reads the image, and stores the pointer in $v0

	sw $v0, 0($t3) # stores v0 in the array of images at index $a2
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
