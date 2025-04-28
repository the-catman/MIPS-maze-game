# MIPS-maze-game

Maze game made in MIPS assembly.

## What's the rwdt file?

It's just a file format for the raw pixel data. It contains nothing but pixels.

## Note

Base address for Bitmap Display needs to be set to 0x1004000! THE GAME WILL NOT WORK IF THE BASE ADDRESS IS AT 0x10010000.

The display height/width need to both be set to 512.

The .rwdt files are the necessary image files, and they are read from MIPS using a syscall. Please do not alter/modify them.