draw: # $a0: The image's base address, $a1: the image's width (x axis), $a2: the image's height (y axis), $a3: offset
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0x10040000 # Base address for display

	sll $a3, $a3, 2
	add $t0, $a3, $t0 # $t0 += offset

	li $t2, 0 # i = 0
	drawLoop1: # for(int i = 0; i < height; i++)
		li $t1, 0 # j = 0
		drawLoop2: # for(int j = 0; j < width; j++)

			sll $t3, $t2, 9 # $t3 = $t2 * 512
			add $t3, $t3, $t1
			sll $t3, $t3, 2
			add $t3, $t3, $t0

			mul $t4, $t2, $a1
			add $t4, $t4, $t1
			sll $t4, $t4, 2
			add $t4, $t4, $a0

			# In short, we're doing:
			# store[(i * 512 + j) * 4 + displayBase] = load[(i * height + j) * 4 + imageBase]

			lw $t5, 0($t4)
			sw $t5, 0($t3)

			addi $t1, $t1, 1
			blt $t1, $a1, drawLoop2
		addi $t2, $t2, 1
		blt $t2, $a2, drawLoop1

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
