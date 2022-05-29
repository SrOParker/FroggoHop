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
##                 Automatic image conversion file                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate image conversion from JPG, ##
## PNG, GIF, etc. into C-arrays.                                          ##
############################################################################

##
## NEW MACROS
##

## 16 colours palette
#PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
#$(eval $(call IMG2SP, SET_MODE        , 0                  ))  { 0, 1, 2 }
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
#$(eval $(call IMG2SP, SET_FOLDER      , src/               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))

##
## OLD MACROS (For compatibility)
##

## Example firmware palette definition as variable in cpct_img2tileset format

# PALETTE={0 1 3 4 7 9 10 12 13 16 19 20 21 24 25 26}

## AUTOMATED IMAGE CONVERSION EXAMPLE (Uncomment EVAL line to use)
##
##    This example would convert img/example.png into src/example.{c|h} files.
##    A C-array called pre_example[24*12*2] would be generated with the definition
##    of the image example.png in mode 0 screen pixel format, with interlaced mask.
##    The palette used for conversion is given through the PALETTE variable and
##    a pre_palette[16] array will be generated with the 16 palette colours as 
##	  hardware colour values.

#$(eval $(call IMG2SPRITES,img/example.png,0,pre,24,12,$(PALETTE),mask,src/,hwpalette))



############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macro used for conversion is IMG2SPRITES, which has up to 9 parameters:##
##  (1): Image file to be converted into C sprite (PNG, JPG, GIF, etc)    ##
##  (2): Graphics mode (0,1,2) for the generated C sprite                 ##
##  (3): Prefix to add to all C-identifiers generated                     ##
##  (4): Width in pixels of each sprite/tile/etc that will be generated   ##
##  (5): Height in pixels of each sprite/tile/etc that will be generated  ##
##  (6): Firmware palette used to convert the image file into C values    ##
##  (7): (mask / tileset / zgtiles)                                       ##
##     - "mask":    generate interlaced mask for all sprites converted    ##
##     - "tileset": generate a tileset array with pointers to all sprites ##
##     - "zgtiles": generate tiles/sprites in Zig-Zag pixel order and     ##
##                  Gray Code row order                                   ##
##  (8): Output subfolder for generated .C/.H files (in project folder)   ##
##  (9): (hwpalette)                                                      ##
##     - "hwpalette": output palette array with hardware colour values    ##
## (10): Aditional options (you can use this to pass aditional modifiers  ##
##       to cpct_img2tileset)                                             ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call IMG2SPRITES,(1),(2),(3),(4),(5),(6),(7),(8),(9), (10))) ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##                                                                        ##
##  * You can omit parameters but leaving them empty. Therefore, if you   ##
##  wanted to specify an output folder but do not want your sprites to    ##
##  have mask and/or tileset, you may omit parameter (7) leaving it empty ##
##     $(eval $(call IMG2SPRITES,imgs/1.png,0,g,4,8,$(PAL),,src/))        ##
############################################################################


## 16 colours palette
##PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26
PALETTE=22 9 12 10 0 0 0 0 16 16 16 16 26 26 26 26

PALETTE_BONUS=23 6 24 14 0 0 0 0 16 16 16 16 26 26 26 26
##PALETTE = 0 
## Default values
$(eval $(call IMG2SP, SET_MODE        , 0                  ))  
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
$(eval $(call IMG2SP, SET_FOLDER      , src/assets/sprites))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)))
$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette))

$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE_BONUS), g_palette_bonus))


$(eval $(call IMG2SP, SET_IMG_FORMAT         , sprites))
#$(eval $(call IMG2SP, CONVERT         , assets/frog_walk.png , 20, 20, spr_frog_walk))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))
$(eval $(call IMG2SP, CONVERT         , assets/frog_static.png , 16, 32, spr_frog_static))
$(eval $(call IMG2SP, CONVERT         , assets/frog_static_left.png , 16, 32, spr_frog_static_left))
$(eval $(call IMG2SP, CONVERT         , assets/frog_walk.png , 16, 32, spr_frog_walk))
$(eval $(call IMG2SP, CONVERT         , assets/frog_walk_left.png , 16, 32, spr_frog_walk_left))

$(eval $(call IMG2SP, CONVERT         , assets/platform1.png , 32, 16, spr_plat1))
$(eval $(call IMG2SP, CONVERT         , assets/platform1_2.png , 16, 16, spr_plat1_2))
$(eval $(call IMG2SP, CONVERT         , assets/platform_mortal.png , 16, 16, spr_plat_mortal))
$(eval $(call IMG2SP, CONVERT         , assets/platform_mortal_down.png , 16, 16, spr_plat_mortal_down))
$(eval $(call IMG2SP, CONVERT         , assets/platform_mortal_all.png , 16, 16, spr_plat_mortal_all))
$(eval $(call IMG2SP, CONVERT         , assets/espina_up.png , 8, 64, spr_espina_up))


$(eval $(call IMG2SP, CONVERT         , assets/bee_enemy.png , 8, 16, spr_bee_move))
$(eval $(call IMG2SP, CONVERT         , assets/bee_enemy_right.png , 8, 16, spr_bee_move_right))
$(eval $(call IMG2SP, CONVERT         , assets/oruga_left.png , 16, 16, spr_oruga_left))
$(eval $(call IMG2SP, CONVERT         , assets/oruga_right.png , 16, 16, spr_oruga_right))

$(eval $(call IMG2SP, CONVERT         , assets/vidas1.png , 32, 8, spr_lifes1))
$(eval $(call IMG2SP, CONVERT         , assets/vidas2.png , 32, 8, spr_lifes2))
$(eval $(call IMG2SP, CONVERT         , assets/vidas3.png , 32, 8, spr_lifes3))


$(eval $(call IMG2SP, SET_FOLDER      , src/assets/background))


$(eval $(call IMG2SP, SET_IMG_FORMAT         , screen))
$(eval $(call IMG2SP, SET_OUTPUT         , bin))

$(eval $(call IMG2SP, CONVERT         , assets/background.png , 160, 200, bgfroggo))
$(eval $(call IMG2SP, CONVERT         , assets/controls.png , 160, 200, bgcontrols))
$(eval $(call IMG2SP, CONVERT         , assets/fondo_inicial.png , 160, 200, fondo_inicial))
$(eval $(call IMG2SP, CONVERT         , assets/nivel1.png , 160, 200, nivel1))
$(eval $(call IMG2SP, CONVERT         , assets/nivel2.png , 160, 200, nivel2))
$(eval $(call IMG2SP, CONVERT         , assets/nivel3.png , 160, 200, nivel3))
$(eval $(call IMG2SP, CONVERT         , assets/nivel4.png , 160, 200, nivel4))
$(eval $(call IMG2SP, CONVERT         , assets/nivel5.png , 160, 200, nivel5))
$(eval $(call IMG2SP, CONVERT         , assets/nivel6.png , 160, 200, nivel6))
$(eval $(call IMG2SP, CONVERT         , assets/gameover.png , 160, 200, gameover))

$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE_BONUS)))
$(eval $(call IMG2SP, CONVERT         , assets/fondo_bonus.png , 160, 200, fondo_bonus))


$(eval $(call IMG2SP, SET_FOLDER      , src/assets/logo))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo7.png , 160, 200, logo7))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo0.png , 160, 200, logo0))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo1.png , 160, 200, logo1))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo2.png , 160, 200, logo2))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo3.png , 160, 200, logo3))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo4.png , 160, 200, logo4))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo5.png , 160, 200, logo5))
$(eval $(call IMG2SP, CONVERT         , assets/logo/logo6.png , 160, 200, logo6))
