;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of Tomahawk Pixels 
;;  Copyright (C) 2021 Laureano Cantó Berna, Alicia Aurecchia Vidal, Alejandro Gómez López
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------


;;=================================================================
;;=================================================================
;;                  CPCTELERA FUNCTIONS
;;=================================================================
;;=================================================================

;;Music
.globl _song_menu1
.globl niveles
.globl cpct_akp_musicPlay_asm 
.globl cpct_akp_musicInit_asm
.globl cpct_akp_stop_asm

;; backgrounds
;.globl _bgfroggo

;;cpct video
.globl cpct_setVideoMemoryPage_asm
.globl cpct_drawSpriteBlended_asm
.globl cpct_disableFirmware_asm
.globl cpct_waitVSYNC_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_drawSolidBox_asm

;;input cpct
.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
.globl waitKeyPressed
.globl waitKeyPressed1

;;string cpct
.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm

.globl cpct_zx7b_decrunch_s_asm




;;OTHER GLOBALS
nullptr == 0x0000
.globl nullptr

c000position == 0xC000
.globl c000position

p_8000position == 0x8000
.globl p_8000position