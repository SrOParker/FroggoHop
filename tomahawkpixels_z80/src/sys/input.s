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



.module Input_System

.include "input.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "sys/render.h.s"
;;====================================================================
;;====================================================================
;;                        PRIVATE FUNCTIONS
;;====================================================================
;;====================================================================

direction: .db 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  MOVEMENTS
;;
move_right:
    ld a, (direction)
    cp #0
    jr z, change_dir

    ld a, e_x(ix)
    cp #70
    ret z
    ld e_vx(ix), #1
    call sys_render_change_walk_step_right
    change_dir:

    ld a, e_x(ix)
    cp #70
    ret z
    ld e_vx(ix), #1
    xor a
    inc a
    ld (direction), a
    call sys_render_change_walk_step_right

ret 
move_left:
    ld a, (direction)
    cp #0
    jr z, change_dir2

    ld a, e_x(ix)
    cp #2
    ret z
    ld e_vx(ix), #-1
    call sys_render_change_walk_step_left
    change_dir2:

    ld a, e_x(ix)
    cp #2
    ret z
    ld e_vx(ix), #-1
    xor a
    dec a
    ld (direction), a
    call sys_render_change_walk_step_left
ret 
jump:
    ;ld e_vy(ix), #-2
    call man_entity_init_jump_control
    call sys_render_change_jump
ret




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  KEY ACTIONS
;;      Pairs of key values and functions to call
;;
key_actions:
    .dw     Key_P,      move_right
    .dw     Key_O,      move_left
    .dw     Key_Q,      jump
    .dw     0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CHECK KEYBOARD AND UPDATE
;;      This function recives in ix the entitie to move and check the key table 
;;  INPUT
;;      IX: Entity to move and apply the functions
;;  MODIFIES
;;      IY, HL, BC, AF, DE
;;
static_frog: .db 0
sys_input_check_keyboard_and_update_player:
    ;;reset velocity
    ld e_vx(ix), #0
    ;ld e_vy(ix), #2
    ld e_vy(ix), #0
    ;;check keyboard
    call cpct_scanKeyboard_f_asm
    ;;key-action check-call loop
    ld iy, #key_actions-4
    loop_keys:
    ld bc, #4
    add iy, bc

    ld l, 0(iy)
    ld h, 1(iy)
    ;;check if key==null
    ld a, l
    or h
    ret z
    ;;check if key is pressed
    call cpct_isKeyPressed_asm


    jr z, loop_keys
    ld hl, #loop_keys
    push hl
    ld l, 2(iy)
    ld h, 3(iy)
    xor a
    inc a
    ld (static_frog), a 
    jp(hl)



;;====================================================================
;;====================================================================
;;                        PUBLIC FUNCTIONS
;;====================================================================
;;====================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  UPDATE
;;      Updates de physics sistem 
;;  MODIFIES
;;      AF, DE, BC, IX, IY, HL
;;
sys_input_update::
    ;;get entity 0 (player) in ix
    xor a
    call man_entity_get_from_idx
    ;;ld ix, #0x4242
    ;;Update player using keyboard status
    call sys_input_check_keyboard_and_update_player
    call sys_input_check_static
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CHECK STATIC
;;      Updates de sprite static when change direction move
;;  MODIFIES
;;      AF, HL
;;
sys_input_check_static:
    ld a, (static_frog)
    cp #0
    jr z, change_static

    xor a
    ld (static_frog), a
    ret

    change_static:
    ld a, (direction)
    call sys_render_changue_static
ret