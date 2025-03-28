.data

helloWorldFile: .asciiz "out.rwdt"

.text

la $a0, helloWorldFile # File name
li $a1, 4096 # File size (equal to image width * height * 4)
jal readImage

move $a0, $v0 # Address of allocated memory
li $a1, 32 # Image width
li $a2, 32 # Image height
li $a3, 100000 # Offset (in pixels)
jal draw

# Termination
li $v0, 10
syscall

.include "draw.asm" # Import draw.asm
.include "readImage.asm"
