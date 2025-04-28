renderScoreAndMoves:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	la $t0, scoreNumber
	lb $t0, 0($t0) # Load scoreNumber from memory
	
	# Render the score (score is less than 10 anyways)
	sll $t0, $t0, 2
	la $t1, numbers
	add $t0, $t0, $t1
	
	lw $a0, 0($t0)
	li $a1, 38
	li $a2, 50
	li $a3, 223934 # 512 * (512 - 75) + 190 
	jal draw
	
	la $t0, moveNumber
	lb $t0, 0($t0)
	
	li $t1, 10
	div $t0, $t1
	mflo $t0 # Quotient
	mfhi $s0 # Remainder
	
	# Render the ten's digit in moveNumber
	sll $t0, $t0, 2
	la $t1, numbers
	add $t0, $t0, $t1
	
	lw $a0, 0($t0)
	li $a1, 38
	li $a2, 50
	li $a3, 224150 # 512 * (512 - 75) + 150 + 256 
	jal draw
	
	# Render the one's digit in moveNumber
	sll $t0, $s0, 2
	la $t1, numbers
	add $t0, $t0, $t1
	
	lw $a0, 0($t0)
	li $a1, 38
	li $a2, 50
	li $a3, 224190 # 512 * (512 - 75) + 190 + 256 
	jal draw
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 8

	jr $ra