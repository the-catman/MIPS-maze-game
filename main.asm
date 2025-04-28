.data

mazeFile: .asciiz "maze.rwdt"

obstacle: .asciiz "obstacle.rwdt"
floor: .asciiz "floor.rwdt"
player: .asciiz "player.rwdt"
portal: .asciiz "portal.rwdt"
coin: .asciiz "coin.rwdt"
finish: .asciiz "finish.rwdt"

zero: .asciiz "0.rwdt"
one: .asciiz "1.rwdt"
two: .asciiz "2.rwdt"
three: .asciiz "3.rwdt"
four: .asciiz "4.rwdt"
five: .asciiz "5.rwdt"
six: .asciiz "6.rwdt"
seven: .asciiz "7.rwdt"
eight: .asciiz "8.rwdt"
nine: .asciiz "9.rwdt"

score: .asciiz "score.rwdt"
moves: .asciiz "moves.rwdt"
gameover: .asciiz "gameover.rwdt"
youwin: .asciiz "youwin.rwdt"

tiles: .word 0:6
numbers: .word 0:10
board: .word 0

scoreNumber: .byte 0
moveNumber: .byte 99

.text

# Draw the word "Score"
la $a0, score
li $a1, 69200
jal readImage

move $a0, $v0
li $a1, 173
li $a2, 100
li $a3, 210944 # 512 * (512 - 100)
jal draw

# Draw the word "moves"
la $a0, moves
li $a1, 69200
jal readImage

move $a0, $v0
li $a1, 173
li $a2, 100
li $a3, 211200 # 512 * (512 - 100) + 256
jal draw

# Load board
la $a0, mazeFile # File name
li $a1, 1024 # File size
li $a2, 0
la $a3, board
jal loadImageToMemory

# Load tiles
la $a0, obstacle
li $a1, 256
li $a2, 0
la $a3, tiles
jal loadImageToMemory

la $a0, floor
li $a1, 256
li $a2, 1
la $a3, tiles
jal loadImageToMemory

la $a0, player
li $a1, 256
li $a2, 2
la $a3, tiles
jal loadImageToMemory

la $a0, portal
li $a1, 256
li $a2, 3
la $a3, tiles
jal loadImageToMemory

la $a0, coin
li $a1, 256
li $a2, 4
la $a3, tiles
jal loadImageToMemory

la $a0, finish
li $a1, 256
li $a2, 5
la $a3, tiles
jal loadImageToMemory

# Load numbers
la $a0, zero
li $a1, 7600
li $a2, 0
la $a3, numbers
jal loadImageToMemory

la $a0, one
li $a1, 7600
li $a2, 1
la $a3, numbers
jal loadImageToMemory

la $a0, two
li $a1, 7600
li $a2, 2
la $a3, numbers
jal loadImageToMemory

la $a0, three
li $a1, 7600
li $a2, 3
la $a3, numbers
jal loadImageToMemory

la $a0, four
li $a1, 7600
li $a2, 4
la $a3, numbers
jal loadImageToMemory

la $a0, five
li $a1, 7600
li $a2, 5
la $a3, numbers
jal loadImageToMemory

la $a0, six
li $a1, 7600
li $a2, 6
la $a3, numbers
jal loadImageToMemory

la $a0, seven
li $a1, 7600
li $a2, 7
la $a3, numbers
jal loadImageToMemory

la $a0, eight
li $a1, 7600
li $a2, 8
la $a3, numbers
jal loadImageToMemory

la $a0, nine
li $a1, 7600
li $a2, 9
la $a3, numbers
jal loadImageToMemory

jal start_game_sound
jal renderScoreAndMoves
jal renderBoard

# Player initial position is (16, 1), first portal is (9, 3), second is (25, 23)
li $s0, 16
li $s1, 1

li $s2, 9
li $s3, 3

li $s4, 25
li $s5, 23

loop:

li $v0, 12
syscall

move $s6, $s0 # Save player position (in case we move to an invalid tile)
move $s7, $s1

beq $v0, 'w', moveUp
beq $v0, 'a', moveLeft
beq $v0, 's', moveDown
beq $v0, 'd', moveRight
j loop # Invalid character, restart the loop

moveUp:
	addi $s1, $s1, -1
	j endMoveIf
moveLeft:
	addi $s0, $s0, -1
	j endMoveIf
moveDown:
	addi $s1, $s1, 1
	j endMoveIf
moveRight:
	addi $s0, $s0, 1
	j endMoveIf
endMoveIf:

# t1 = newx + newy * 32
sll $t0, $s1, 5
add $t1, $t0, $s0

# t2 = oldx + oldy * 32
sll $t2, $s7, 5
add $t2, $t2, $s6

la $t0, board
lw $t3, 0($t0) # t3 = Base address of our board

add $t0, $t3, $t1
lb $t0, 0($t0) # t0 = Tile number


beq $t0, 0, moveToObstacle
beq $t0, 1, moveToFloor
beq $t0, 3, moveToPortal
beq $t0, 4, moveToCoin
beq $t0, 5, moveToFinish
j endTileIf

moveToObstacle:
	move $s0, $s6
	move $s1, $s7

	j loop
moveToFloor:
	# Set player to the new position
	add $t0, $t3, $t1
	li $t4, 2
	sb $t4, 0($t0)
	
	# Remove player from old position (set it to blank)
	add $t0, $t3, $t2
	li $t4, 1
	sb $t4, 0($t0)

	jal move_sound

	j endTileIf
moveToPortal:
	# Remove player from old position (set it to blank)
	add $t0, $t3, $t2
	li $t4, 1
	sb $t4, 0($t0)
	
	sll $t4, $s3, 5
	add $t4, $s2, $t4 # Position of first portal
	
	beq $t4, $t1, portalJump
	addi $t0, $t3, 104 # 8 + 3 * 32
	
	li $s0, 8 # Set player pos to (8, 3) (hardcoded unfortunately)
	li $s1, 3
	j portalJumpEnd
	portalJump:
		addi $t0, $t3, 729 # 25 + 22 * 32 
		
		li $s0, 25 # Set player pos to (25, 22) (hardcoded)
		li $s1, 22
	portalJumpEnd:
	
	li $t4, 2
	sb $t4, 0($t0)
	
	jal teleport_sound
	
	j endTileIf
moveToCoin:
	# Set player to the new position
	add $t0, $t3, $t1
	li $t4, 2
	sb $t4, 0($t0)
	
	# Remove player from old position (set it to blank)
	add $t0, $t3, $t2
	li $t4, 1
	sb $t4, 0($t0)

	jal coin_pickup_sound
	
	# Increase score by 1
	la $t4, scoreNumber
	lb $t5, 0($t4)
	addi $t5, $t5, 1
	sb $t5, 0($t4)

	j endTileIf
moveToFinish:
	j winScreen
endTileIf:

la $t4, moveNumber
lb $t5, 0($t4)
addi $t5, $t5, -1
sb $t5, 0($t4)

jal renderBoard
jal renderScoreAndMoves

la $t4, moveNumber
lb $t4, 0($t4)

beqz $t4, gameOverScreen

j loop

winScreen:
	# Read you win image
	la $a0, youwin
	li $a1, 65536
	jal readImage

	# Display it
	move $a0, $v0
	li $a1, 128
	li $a2, 128
	li $a3, 98496
	jal draw
	
	jal you_win_sound

	j exit
gameOverScreen:
	# Read gameover image
	la $a0, gameover
	li $a1, 65536
	jal readImage

	# Display it 
	move $a0, $v0
	li $a1, 128
	li $a2, 128
	li $a3, 98496 # 512 * (128 + 64) + 128 + 64 
	jal draw
	
	jal game_over_sound

	j exit
exit:

# Termination
li $v0, 10
syscall

.include "draw.asm" # Import these functions
.include "readImage.asm"
.include "renderBoard.asm"
.include "loadImageToMemory.asm"
.include "sounds.asm"
.include "renderScoreAndMoves.asm"
