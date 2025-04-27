.data

mazeFile: .asciiz "maze.rwdt"

obstacle: .asciiz "obstacle.rwdt"
floor: .asciiz "floor.rwdt"
player: .asciiz "player.rwdt"
portal: .asciiz "portal.rwdt"
coin: .asciiz "coin.rwdt"
finish: .asciiz "finish.rwdt"

images: .word 0:6

boardAddress: .space 4

.text

la $a0, mazeFile # File name
li $a1, 1024 # File size
jal readImage # Read our board

la $t0, boardAddress
sw $v0, 0($t0)

la $a0, obstacle
li $a1, 256 # File size
li $a2, 0 # Index
jal loadImageToMemory

la $a0, floor
li $a1, 256
li $a2, 1
jal loadImageToMemory

la $a0, player
li $a1, 256
li $a2, 2
jal loadImageToMemory

la $a0, portal
li $a1, 256
li $a2, 3
jal loadImageToMemory

la $a0, coin
li $a1, 256
li $a2, 4
jal loadImageToMemory

la $a0, finish
li $a1, 256
li $a2, 5
jal loadImageToMemory

jal start_game_sound

jal renderBoard

# Termination
li $v0, 10
syscall

.include "draw.asm" # Import these functions
.include "readImage.asm"
.include "renderBoard.asm"
.include "loadImageToMemory.asm"
.include "sounds.asm"
