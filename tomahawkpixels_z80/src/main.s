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


.module Main
;;============================================================;;
;;============================================================;;
;;                         MAIN                               ;;
;;============================================================;;
;;============================================================;;


;;AREA SECTION
.area _DATA
.area _CODE
;;END AREA SECTION

 
;;INCLUDE SECTION
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "sys/collision.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "man/game.h.s"
.include "logotipo.h.s"
;;END INCLUDE SECTION

;;GLOBL SECTION
;;END GLOBL SECTION



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN APLICATION 
;;           

_main::
   ld sp, #0x7FFF ;;cambia la pila a la 8000 7FFF
   call cpct_disableFirmware_asm
   
   call sys_render_init
   call logotipo
   call game_menu
   




  
 


