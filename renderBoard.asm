renderBoard: # $s0: Board address
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	li $s0, 0 # i = 0
	renderLoop1: # # for(int i = 0; i < 32; i++)
		li $s1, 0 # j = 0
		renderLoop2:
		
			sll $t0, $s0, 5
			add $t0, $t0, $s1
			# $t0 = j + i * 32
			
			sll $t1, $s0, 12
			sll $t2, $s1, 3
			add $a3, $t1, $t2
			addi $a3, $a3, 65664
			# $a3 = j * 8 + i * 512 + 65664
			
			la $t2, tiles

			la $t4, board
			lw $t4, 0($t4)
			add $t3, $t0, $t4
			lb $t3, 0($t3)

			sll $t3, $t3, 2
			add $t2, $t3, $t2
			
			lw $a0, 0($t2)
			
			li $a1, 8
			li $a2, 8
			jal draw

			addi $s1, $s1, 1
			blt $s1, 32, renderLoop2
		addi $s0, $s0, 1
		blt $s0, 32, renderLoop1
	
	lw   $ra, 0($sp)
	lw   $s0, 4($sp)
	lw   $s1, 8($sp)
	addi $sp, $sp, 12

	jr   $ra
	
