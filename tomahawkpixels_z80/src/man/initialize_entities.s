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
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "sys/collision.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "assets/background/background.h.s"
.include "initialize_entities.h.s"
.include "man/game.h.s"

;.globl _fondo_end
.globl _controls_end
.globl _fondo_inicial_end
.globl _fondo_bonus_end
.globl _nivel1_end
.globl _nivel2_end
.globl _nivel3_end
.globl _nivel4_end
.globl _nivel5_end
.globl _nivel6_end
init_level_0::
   cpctm_clearScreen_asm 0
   call man_entity_destroy
   
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_controls_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_controls_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm

   call lvl_0_creator

ret
init_level_1::
   cpctm_clearScreen_asm 0


   ld a, #1
   ld (nivel), a
   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_nivel1_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_nivel1_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm

   
   xor a
   call sys_render_change_render_status
   call lvl_1_creator
ret

init_level_2::
    cpctm_clearScreen_asm 0


   ld a, #2
   ld (nivel), a
   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_nivel2_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_nivel2_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm

   
   xor a
   call sys_render_change_render_status
   call lvl_2_creator
ret

init_level_3::
   cpctm_clearScreen_asm 0
   ld a, #3
   ld (nivel), a

   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_nivel3_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_nivel3_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm

   xor a
   call sys_render_change_render_status
   call lvl_3_creator
ret

init_level_4::
   cpctm_clearScreen_asm 0
   ld a, #4
   ld (nivel), a
   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_nivel4_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_nivel4_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm
   
   xor a
   call sys_render_change_render_status
   call lvl_4_creator
ret

init_level_5::
   cpctm_clearScreen_asm 0
   ld a, #5
   ld (nivel), a
   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_fondo_inicial_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_fondo_inicial_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm
   
   xor a
   call sys_render_change_render_status
   call lvl_5_creator
ret

init_level_6::
   cpctm_clearScreen_asm 0
   ld a, #6
   ld (nivel), a
   
   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_nivel5_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_nivel5_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm
   
   xor a
   call sys_render_change_render_status
   call lvl_6_creator
ret

init_level_7::
   cpctm_clearScreen_asm 0
   ld a, #7
   ld (nivel), a
   
   call man_entity_destroy
   call man_entity_init
   call sys_render_init
   ;;provisional 
   ld hl, #_nivel6_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_nivel6_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm
   
   xor a
   call sys_render_change_render_status
   call lvl_7_creator
ret

init_level_bonus::
   cpctm_clearScreen_asm 0
   ld a, #8
   ld (nivel), a
   
   call man_entity_destroy
   call man_entity_init
   call sys_render_init_bonus
   ;;provisional 
   ld hl, #_fondo_bonus_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_fondo_bonus_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm

   xor a
   call sys_render_change_render_status
   call lvl_bonus_creator
ret