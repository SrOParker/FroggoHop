##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine 
##  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------
############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic compression utilities                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate the generation of          ##
## compressed files and their inclusion in users' projects.               ##
############################################################################

## COMPRESSION EXAMPLE (Uncomment lines to use)
##

## First 3 calls to ADD2PACK add enemy, hero and background
## graphics (previously converted to binary data) into the 
## compressed group 'mygraphics'. After that, call to PACKZX7B
## compresses all the data and generates an array with the result
## that is placed in src/mygraphics.c & src/mygraphics.h, ready
## to be included and used by other modules.
##
#$(eval $(call ADD2PACK,mygraphics,gfx/enemy.bin))
#$(eval $(call ADD2PACK,mygraphics,gfx/hero.bin))
#$(eval $(call ADD2PACK,mygraphics,gfx/background.bin))
#$(eval $(call PACKZX7B,mygraphics,src/))




############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macros used for compression are ADD2PACK and PACKZX7B:                 ##
##                                                                        ##
##	ADD2PACK: Adds files to packed (compressed) groups. Each call to this ##
##  		  macro will add a file to a named compressed group.          ##
##  PACKZX7B: Compresses all files in a group into a single binary and    ##
##            generates a C-array and a header to comfortably use it from ##
##            inside your code.                                           ##
##                                                                        ##
##------------------------------------------------------------------------##
##                                                                        ##
##  $(eval $(call ADD2PACK,<packname>,<file>))                            ##
##                                                                        ##
##		Sequentially adds <file> to compressed group <packname>. Each     ##
## call to this macro adds a new <file> after the latest one added.       ##
## packname could be any valid C identifier.                              ##
##                                                                        ##
##  Parameters:                                                           ##
##  (packname): Name of the compressed group where the file will be added ##
##  (file)    : File to be added at the end of the compressed group       ##
##                                                                        ##
##------------------------------------------------------------------------##
##                                                                        ##
##  $(eval $(call PACKZX7B,<packname>,<dest_path>))                       ##
##                                                                        ##
##		Compresses all files in the <packname> group using ZX7B algorithm ##
## and generates 2 files: <packname>.c and <packname>.h that contain a    ##
## C-array with the compressed data and a header file for declarations.   ##
## Generated files are moved to the folder <dest_path>.                   ##
##                                                                        ##
##  Parameters:                                                           ##
##  (packname) : Name of the compressed group to use for packing          ##
##  (dest_path): Destination path for generated output files              ##
##                                                                        ##
############################################################################
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##  * You can omit parameters by leaving them empty.                      ##
##  * Parameters (4) and (5) are optional and generally not required.     ##
############################################################################


$(eval $(call ADD2PACK,background,src/assets/background/background.bin))
$(eval $(call PACKZX7B,background,src/assets/background/))

##$(eval $(call ADD2PACK,fondo,src/assets/background/fondo.bin))
##$(eval $(call PACKZX7B,fondo,src/assets/background/))

$(eval $(call ADD2PACK,controls,src/assets/background/controls.bin))
$(eval $(call PACKZX7B,controls,src/assets/background/))

$(eval $(call ADD2PACK,fondo_inicial,src/assets/background/fondo_inicial.bin))
$(eval $(call PACKZX7B,fondo_inicial,src/assets/background/))

$(eval $(call ADD2PACK,nivel1,src/assets/background/nivel1.bin))
$(eval $(call PACKZX7B,nivel1,src/assets/background/))
$(eval $(call ADD2PACK,nivel2,src/assets/background/nivel2.bin))
$(eval $(call PACKZX7B,nivel2,src/assets/background/))
$(eval $(call ADD2PACK,nivel3,src/assets/background/nivel3.bin))
$(eval $(call PACKZX7B,nivel3,src/assets/background/))
$(eval $(call ADD2PACK,nivel4,src/assets/background/nivel4.bin))
$(eval $(call PACKZX7B,nivel4,src/assets/background/))
$(eval $(call ADD2PACK,nivel5,src/assets/background/nivel5.bin))
$(eval $(call PACKZX7B,nivel5,src/assets/background/))
$(eval $(call ADD2PACK,nivel6,src/assets/background/nivel6.bin))
$(eval $(call PACKZX7B,nivel6,src/assets/background/))

$(eval $(call ADD2PACK,gameover,src/assets/background/gameover.bin))
$(eval $(call PACKZX7B,gameover,src/assets/background/))

$(eval $(call ADD2PACK,fondo_bonus,src/assets/background/fondo_bonus.bin))
$(eval $(call PACKZX7B,fondo_bonus,src/assets/background/))

$(eval $(call ADD2PACK,logo0,src/assets/logo/logo0.bin))
$(eval $(call PACKZX7B,logo0,src/assets/logo/))
$(eval $(call ADD2PACK,logo1,src/assets/logo/logo1.bin))
$(eval $(call PACKZX7B,logo1,src/assets/logo/))
$(eval $(call ADD2PACK,logo2,src/assets/logo/logo2.bin))
$(eval $(call PACKZX7B,logo2,src/assets/logo/))
$(eval $(call ADD2PACK,logo3,src/assets/logo/logo3.bin))
$(eval $(call PACKZX7B,logo3,src/assets/logo/))
$(eval $(call ADD2PACK,logo4,src/assets/logo/logo4.bin))
$(eval $(call PACKZX7B,logo4,src/assets/logo/))
$(eval $(call ADD2PACK,logo5,src/assets/logo/logo5.bin))
$(eval $(call PACKZX7B,logo5,src/assets/logo/))
$(eval $(call ADD2PACK,logo6,src/assets/logo/logo6.bin))
$(eval $(call PACKZX7B,logo6,src/assets/logo/))
$(eval $(call ADD2PACK,logo7,src/assets/logo/logo7.bin))
$(eval $(call PACKZX7B,logo7,src/assets/logo/))

