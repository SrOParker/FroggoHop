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



.module Render_System

.include "render.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"
.include "cpct_globals.h.s"


;;====================================================================
;;====================================================================
;;                        PRIVATE FUNCTIONS
;;====================================================================
;;====================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates one entity first render loop
;;  Input:
;;      IX: Pointer to entity having render component
;;  Modifies:
;;      AF, BC, DE, HL
;;

sys_first_render_one_entity::


    ;;Calculate new mem location
    ;back_buffer = .+2
    ;;Save for erasing on next frame

    ;;Draw entity
    ;ld       e, e_prev_ptr+0(ix)
    ;ld       d, e_prev_ptr+1(ix)
    ;ld       l, e_sprite+0(ix)
    ;ld       h, e_sprite+1(ix)
    ;ld       c, e_h(ix)                 ;;hight
    ;ld       b, e_w(ix)                 ;;width
  ;
    ;call cpct_drawSpriteBlended_asm
    ld      de, #0x8000
    ld       b, e_y(ix)                 ;;y  
    ld       c, e_x(ix)                 ;;x
    call    cpct_getScreenPtr_asm
    ex      de,hl
    ;;Save for erasing on next frame

    ;;Draw entity
    ;;ld       e, e_prev_ptr+0(ix)
    ;;ld       d, e_prev_ptr+1(ix)
    ;;ld       l, e_sprite+0(ix)
    ;;ld       h, e_sprite+1(ix)
    ;;ld       c, e_h(ix)                 ;;hight
    ;;ld       b, e_w(ix)                 ;;width
  
    ;call cpct_drawSpriteBlended_asm
    ld e_prev_spr+0(ix), l
    ld e_prev_spr+1(ix), h
    ld e_prev_ptr+1(ix), d
    ld e_prev_ptr+0(ix), e
    ld e_prev_spr2+0(ix), l
    ld e_prev_spr2+1(ix), h
    ld e_prev_ptr2+1(ix), d
    ld e_prev_ptr2+0(ix), e
ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates one entity render component
;;  Input:
;;      IX: Pointer to entity having render component
;;  Modifies:
;;      AF, BC, DE, HL
;;

sys_render_one_entity::

    ld a, e_type(ix)
    and #e_type_enemy_bee
    cp #e_type_enemy_bee
    jr z, call_bee_change
    
    ld a, e_type(ix)
    and #e_type_enemy_floor
    cp #e_type_enemy_floor
    jr z, oruge

    jr nz, first_step_render

    call_bee_change:
    call change_bee_move
    jr first_step_render
    
    oruge:
    ld a, e_x(ix)
    cp #22
    jr z, change_dir_oR
    cp a, #70
    jr z, change_dir_oL
    jr call_oruge_change 
    change_dir_oL:
    xor a
    dec a
    ld (animation_oruge_dir), a
    jr call_oruge_change 
    change_dir_oR:
    xor a
    ld (animation_oruge_dir), a
    call_oruge_change:
    call change_oruge_move

    first_step_render:
    ;;Erase sys_render_one_entity
    ld e, e_prev_ptr2+0(ix)
    ld d, e_prev_ptr2+1(ix)
    ;xor a
    ld l, e_prev_spr2+0(ix) ;;entity with last sprite
    ld h, e_prev_spr2+1(ix)
    ld c, e_h(ix)
    ld b, e_w(ix)
    call cpct_drawSpriteBlended_asm
    
    ;call cpct_drawSolidBox_asm

    ;;Calculate new mem location
    back_buffer = .+2
    ld      de, #0x8000
    ld       b, e_y(ix)                 ;;y  
    ld       c, e_x(ix)                 ;;x
    call    cpct_getScreenPtr_asm
    ex      de,hl
;;
    ;;change pointers to erase in double buffer

    ld a, e_prev_ptr(ix)
    ld e_prev_ptr2(ix), a
    ld a, e_prev_ptr+1(ix)
    ld e_prev_ptr2+1(ix), a

    ld a, e_prev_spr(ix)
    ld e_prev_spr2(ix), a
    ld a, e_prev_spr+1(ix)
    ld e_prev_spr2+1(ix), a
    
    ;;Save for erasing on next frame
    ld e_prev_ptr+0(ix), e
    ld e_prev_ptr+1(ix), d
    ;;Draw entity
    ld       e, e_prev_ptr+0(ix)
    ld       d, e_prev_ptr+1(ix)
    ld       l, e_sprite+0(ix)
    ld       h, e_sprite+1(ix)
    ld       c, e_h(ix)                 ;;hight
    ld       b, e_w(ix)                 ;;width

    ld e_prev_spr+0(ix), l
    ld e_prev_spr+1(ix), h
    call cpct_drawSpriteBlended_asm
    ;;;call    cpct_drawSprite_asm
ret

animation_bee_step: .db 0
change_bee_move:
    ld a, (animation_bee_step)
    
    cp a, #0
    jr z, is0

    cp a, #1
    jr z, is1
    
    cp a, #2
    jr z, is2

    cp a, #3
    jr z, is3
    ret
    is0:
    ld      hl, #_spr_bee_move_0
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_bee_step), a
    ret
    is1:
    ld      hl, #_spr_bee_move_1
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_bee_step), a
    ret
    is2:
    ld      hl, #_spr_bee_move_2
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_bee_step), a
    ret
    is3:
    ld      hl, #_spr_bee_move_3
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    xor a
    ld (animation_bee_step), a
ret


animation_oruge_step: .db 0
animation_oruge_dir: .db -1
frame_stop: .db 0
change_oruge_move:

    ld a,(frame_stop)
    cp #0
    jr z, framenext

    xor a
    ld (frame_stop), a
    ret
    framenext:
    xor a
    inc a
    ld (frame_stop), a 

    ld a, (animation_oruge_dir)
    cp #-1
    jr z, animationL_oruge
    
    ld a, (animation_oruge_step)
    
    cp a, #0
    jr z, Lis00

    cp a, #1
    jr z, Lis11
    
    cp a, #2
    jr z, Lis22

    cp a, #3
    jr z, Lis33
    ret
    Lis00:
    ld      hl, #_spr_oruga_right_0
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_oruge_step), a
    ret
    Lis11:
    ld      hl, #_spr_oruga_right_1
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_oruge_step), a
    ret
    Lis22:
    ld      hl, #_spr_oruga_right_2
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_oruge_step), a
    ret
    Lis33:
    ld      hl, #_spr_oruga_right_3
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    xor a
    ld (animation_oruge_step), a


    ret
    animationL_oruge:
    ld a, (animation_oruge_step)
    
    cp a, #0
    jr z, Ris0

    cp a, #1
    jr z, Ris1
    
    cp a, #2
    jr z, Ris2

    cp a, #3
    jr z, Ris3
    ret
    Ris0:
    ld      hl, #_spr_oruga_left_0
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_oruge_step), a
    ret
    Ris1:
    ld      hl, #_spr_oruga_left_1
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_oruge_step), a
    ret
    Ris2:
    ld      hl, #_spr_oruga_left_2
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    inc a
    ld (animation_oruge_step), a
    ret
    Ris3:
    ld      hl, #_spr_oruga_left_3
    ld       e_sprite+0(ix), l
    ld       e_sprite+1(ix), h
    xor a
    ld (animation_oruge_step), a
ret
;;====================================================================
;;====================================================================
;;                        PUBLIC FUNCTIONS
;;====================================================================
;;====================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  UPDATE
;;      Initializes the render system
;;  Modifies:
;;      AF, BC, DE, HL
;;
sys_render_init::
    call change_screen_to_C000
    ld      c, #0               ;;MODE 0 
    call    cpct_setVideoMode_asm

    cpctm_setBorder_asm HW_WHITE

    ld      hl, #_g_palette         ;;SET palette
    ld      de, #16
    call    cpct_setPalette_asm

ret



sys_render_init_bonus::
    call change_screen_to_C000
    ld      c, #0               ;;MODE 0 
    call    cpct_setVideoMode_asm

    cpctm_setBorder_asm HW_WHITE

    ld      hl, #_g_palette_bonus         ;;SET palette
    ld      de, #16
    call    cpct_setPalette_asm
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  UPDATE LEVEL START
;;      Draw floor
;;  Modifies:
;;      AF, BC, DE, HL, IX
;;

sys_render_level_start::
    ;;cpctm_screenPtrSym_asm floor_ptr1, 0xC000,  0, 180
    ;;cpctm_screenPtrSym_asm floor_ptr2, 0xC000, 40, 180
;;
    ;;ld  de, #floor_ptr1
    ;;ld   a, #0xFF
    ;;ld  bc, #0x1428
    ;;call cpct_drawSolidBox_asm
;;
    ;;ld  de, #floor_ptr2
    ;;ld   a, #0xFF
    ;;ld  bc, #0x1428
    ;;call cpct_drawSolidBox_asm
ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ANIMATION CHANGUE
;;      Draw one static sprite for each direction 
;;  Parametres:
;;      ix: player
;;  Modifies:
;;      AF, hl
;;

sys_render_changue_static::

    cp a, #1    ;;input 1 right -1 left
    jr z, right_s
    cp a, #0
    jr z, right_s
    
    ld hl, #_spr_frog_static_left
    ld e_sprite+0(ix), l
    ld e_sprite+1(ix), h
    ret
    right_s:
    ld hl, #_spr_frog_static
    ld e_sprite+0(ix), l
    ld e_sprite+1(ix), h
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ANIMATION CHANGUE
;;      Draw one jump sprite for each loop of time
;;  Parametres:
;;      ix: player
;;  Modifies:
;;      AF
;;

sys_render_change_jump::
    ;ld a, #12
    ;ld e_w(ix), a
    ;ld a, #38
    ;ld e_h(ix), a
    ;ld hl, #_spr_frog_jump
    ;ld e_sprite+0(ix), l
    ;ld e_sprite+1(ix), h

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ANIMATION CHANGUE RIGHT
;;      Draw one walk sprite for each loop of time
;;  Parametres:
;;      ix: player
;;  Modifies:
;;      AF
;;

step_walk: .db 0
sys_render_change_walk_step_right::
    ld a, (step_walk)
    cp #0
    jr z, draw_walk_0
    cp a, #8
    jr z, draw_walk_1
    inc a
    ld (step_walk), a
    ret
    draw_walk_0:
    ld hl, #_spr_frog_walk_0
    ld e_sprite+0(ix), l
    ld e_sprite+1(ix), h
    inc a
    ld (step_walk), a
    ret 
    draw_walk_1:
    ld hl, #_spr_frog_walk_1
    ld e_sprite+0(ix), l
    ld e_sprite+1(ix), h
    dec a
    ld (step_walk), a
    ld a, #-8
    ld (step_walk), a
    ret

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ANIMATION CHANGUE LEFT
;;      Draw one walk sprite for each loop of time
;;  Parametres:
;;      ix: player
;;  Modifies:
;;      AF
;;
step_walk_left: .db 0
sys_render_change_walk_step_left::
    ld a, (step_walk_left)
    cp #0
    jr z, draw_walk_0L
    cp a, #8
    jr z, draw_walk_1L
    inc a
    ld (step_walk_left), a
    ret
    draw_walk_0L:
    ld hl, #_spr_frog_walk_left_0
    ld e_sprite+0(ix), l
    ld e_sprite+1(ix), h
    inc a
    ld (step_walk_left), a
    ret 
    draw_walk_1L:
    ld hl, #_spr_frog_walk_left_1
    ld e_sprite+0(ix), l
    ld e_sprite+1(ix), h
    dec a
    ld (step_walk_left), a
    ld a, #-8
    ld (step_walk_left), a
    ret

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  DOUBLE BUFFER
;;      Updates the render system
;;  Modifies:
;;      AF, BC, DE, HL, IX
;;
change_screen:
f_change_screen =: .+1
    jp change_screen_to_8000

change_screen_to_8000::

    ld l, #0x20
    call cpct_setVideoMemoryPage_asm


    ld a, #0xC0
    ld (back_buffer), a

    ld hl, #change_screen_to_C000
    ld (f_change_screen), hl
    
ret 

change_screen_to_C000::

    ld l, #0x30
    call cpct_setVideoMemoryPage_asm

    ld a, #0x80
    ld (back_buffer), a
    
    ld hl, #change_screen_to_8000
    ld (f_change_screen), hl
ret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  UPDATE
;;      Updates the render system
;;  Modifies:
;;      AF, BC, DE, HL, IX
;;
time_render_status: .db 0
render_cmps = (e_cmps_alive | e_cmps_render)
sys_render_update::
    ld a, (time_render_status)
    cp #0
    jr z, first_t
    ld      hl, #sys_render_one_entity
    ld       a, #render_cmps                    
    call    man_entity_forall_matching
    call    change_screen
    
    ret 

    first_t:
    
    inc a  
    ld (time_render_status), a

    ld      hl, #sys_first_render_one_entity
    ld       a, #render_cmps               
    call    man_entity_forall_matching


    ret


sys_render_change_render_status::
    ld (time_render_status), a
ret