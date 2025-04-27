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

numbers: .word 0:9

board: .word 0

.text

la $a0, score
li $a1, 69200
jal readImage

move $a0, $v0
li $a1, 173
li $a2, 100
li $a3, 210944 # 512 * (512 - 100)
jal draw # Draw score

la $a0, moves
li $a1, 69200
jal readImage

move $a0, $v0
li $a1, 173
li $a2, 100
li $a3, 211200 # 512 * (512 - 100) + 256
jal draw # Draw moves

la $a0, mazeFile # File name
li $a1, 1024 # File size
li $a2, 0
la $a3, board
jal loadImageToMemory

la $a0, obstacle
li $a1, 256 # File size
li $a2, 0 # Index
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

jal start_game_sound

jal renderBoard

# Termination
exit:
li $v0, 10
syscall

.include "draw.asm" # Import these functions
.include "readImage.asm"
.include "renderBoard.asm"
.include "loadImageToMemory.asm"
.include "sounds.asm"
