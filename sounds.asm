coin_pickup_sound:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 31
    li $a0, 100
    li $a1, 1000
    li $a2, 9
    li $a3, 120
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

teleport_sound:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 31
    li $a0, 50
    li $a1, 500
    li $a2, 97
    li $a3, 100
    syscall

	li $v0, 31
	li $a0, 50
	li $a1, 500
	li $a2, 97
	li $a3, 90
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 500
	li $a2, 97
	li $a3, 80
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 500
	li $a2, 97
	li $a3, 70
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 500
	li $a2, 97
	li $a3, 60
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 600
	li $a2, 97
	li $a3, 50
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 600
	li $a2, 97
	li $a3, 40
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 700
	li $a2, 97
	li $a3, 30
	syscall

	li $v0, 31
	li $a0, 50
	li $a1, 1200
	li $a2, 97
	li $a3, 20
	syscall
	
	lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

start_game_sound:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 31
    li $a0, 62
    li $a1, 400
    li $a2, 81
    li $a3, 90
    syscall

    li $v0, 31
    li $a0, 67
    li $a1, 400
    li $a2, 81
    li $a3, 100
    syscall

    li $v0, 31
    li $a0, 72
    li $a1, 600
    li $a2, 95
    li $a3, 90
    syscall

    li $v0, 31
    li $a0, 79
    li $a1, 1900
    li $a2, 96
    li $a3, 80
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

game_over_sound:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 31
    li $a0, 67
    li $a1, 600
    li $a2, 89
    li $a3, 90
    syscall

    li $v0, 31
    li $a0, 64
    li $a1, 600
    li $a2, 89
    li $a3, 80
    syscall

    li $v0, 31
    li $a0, 60
    li $a1, 1500
    li $a2, 89
    li $a3, 700
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

game_win_sound:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 31
    li $a0, 60
    li $a1, 3500
    li $a2, 126
    li $a3, 110
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

move_sound:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 31
    li $a0, 38
    li $a1, 1000
    li $a2, 115
    li $a3, 85
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
