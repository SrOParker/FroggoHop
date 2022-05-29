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

.module Collision_System

.include "collision.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "sys/render.h.s"

;;====================================================================
;;====================================================================
;;                        PRIVATE FUNCTIONS
;;====================================================================
;;====================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CHECK AABB COLLISIONS IX vx IY
;;  Checks collisions between sprite AABB of IX and IY entities
;;  INPUT
;;      IX: Entity Collider
;;      IY: Entity Collisionable
;;  Modifies:
;;      AF, BC
;;  Return:
;;      Carry       -       NO collision
;;      NoCarry     -       Collision
;;
sys_collision_check_aabb_collisions_ix_vx_iy:
;;================================================================
    ;;==    X-AXIS COLLISIONS
    ;;================================================================
    ;;case 1: IY < IX 
    ;; if ((IY.x + iY.w - 1) < IX.x)
    ;; IY.x + IY.w - 1 -IX.x < 0 
    ld  a, e_x(iy)  ;;A = IY.x
    ld  b, a        ;;B = A = IY.x
    add e_w(iy)     ;;A = IY.x + IY.w
    dec a           ;;A = IY.x + IY.w - 1
    ld  c, e_x(ix)  ;;C = IX.x
    sub c           ;;A = IY.x + IY.w - 1 - IX.x
    ret c           ;; if (a < 0) carry = on, no collision, return
    ;;case 2: IX< IY 
    ;; if ((IX.x + IX.w - 1) < IY.x)
    ;; IX.x + IX.w - 1 -IY.x < 0 
    ld  a, c        ;;A = IX.x
    add e_w(ix)     ;;A = IX.x + IX.w
    dec a           ;;A = IX.x + IX.w - 1
    sub b           ;;A = IX.x + IX.w - 1 - IY.x
    ret c           ;; if (a < 0) carry = on, no collision, return
    ;;================================================================
    ;;==    Y-AXIS COLLISIONS
    ;;================================================================
    ;;case 3: IY < IX 
    ;; if ((IY.y + iY.h - 1) < IX.y)
    ;; IY.y + IY.h - 1 -IX.y < 0 
    ld  a, e_y(iy)  ;;A = IY.y
    ld  b, a        ;;B = A = IY.y
    add e_h(iy)     ;;A = IY.y + IY.h
    dec a           ;;A = IY.y + IY.h - 1
    ld  c, e_y(ix)  ;;C = IX.y
    sub c           ;;A = IY.y + IY.h - 1 - IX.y
    ret c           ;; if (a < 0) carry = on, no collision, return
    ;;case 4: IX< IY 
    ;; if ((IX.y + IX.h - 1) < IY.y)
    ;; IX.y + IX.h - 1 -IY.y < 0 
    ld  a, c        ;;A = IX.y
    add e_h(ix)     ;;A = IX.y + IX.h
    dec a           ;;A = IX.y + IX.h - 1
    sub b           ;;A = IX.y + IX.h - 1 - IY.y
    ;ret c           ;; if (a < 0) carry = on, no collision, return (last ret not necessary)
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  COLLIDER-COLLISIONABLE UPDATE CHECK
;;  Checks collisions between a collider and a collisionable
;;  INPUT
;;      IX: Entity Collider
;;      IY: Entity Collisionable
;;  Modifies:
;;      ??
;;
sys_collision_ix_collider_iy_collisionable:

    call sys_collision_check_aabb_collisions_ix_vx_iy
    ret  c

    ;;A collision ocurred between IX(Collider) and IY (Collisionable)
    ld l, e_col_func+0(ix)
    ld h, e_col_func+1(ix)
    jp (hl)
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  COLLIDER UPDATE
;;  Check if a collider collisions with other collisionables
;;  Modifies:
;;      ??
;;
cmps_collisionable = (e_cmps_alive | e_cmps_collisionable)
sys_collision_collider_update:
    ld  hl, #sys_collision_ix_collider_iy_collisionable
    ld   a, #cmps_collisionable ;;check collisionables
    jp  man_entity_forall_matching_iy
    ;;call    man_entity_forall_matching_iy
    ;;ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  COLLISION FROG WITH SOLID
;;  A collision between Frog and a solid type should be repositioned
;;  INPUT
;;      IX: Frog
;;      IY: Solid collisionable
;;  Modifies:
;;      ??
;;
sys_collision_frog_with_solid:
    ld a, e_y(ix)
    cp #148
    jr z, collision_left_right
    jr vertical_collision
    ;;ld a, e_y(ix)
    ;;add e_h(ix)
    ;;ld b, e_y(iy)
    ;;sub a,b

    ;;jr z, vertical_collision
    ;;;;check if collision is below the entity collisionable
    ;;ld b, e_y(ix)
    ;;ld a, e_y(iy)
    ;;add a,e_h(iy)
    ;;sub a,b

    ;;jr z, vertical_collision
    ;;not collision up and no collision down
    call collision_left_right
    ret

    vertical_collision:
    call collision_up_down

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  COLLISION FROG WITH SOLID LEFT OR RIGHT
;;  A collision between Frog and a solid type should be repositioned on left or right
;;  INPUT
;;      IX: Frog
;;      IY: Solid collisionable
;;  Modifies:
;;      ??
;;
collision_left_right:
    ld  a, e_x(iy)
    sub e_x(ix)
    jr  c, sccws_rightcol
    ;;Left Colission
    ;;reposition of frog to IY.X +IX.w
    sccws_leftcol:
    ld  a, e_x(iy)
    sub e_w(ix)
    jr sccws_continue
    ret
    ;;Right Collision
    ;;reposition of frog to IY.x +IY.w
    sccws_rightcol:
    ld b, e_y(iy)
    ld  a, e_x(iy)
    add e_w(iy)
    sccws_continue:
    ld e_x(ix), a 
ret

c_sprite_f:
    ld a, e_sprite+0(ix)
    ld e_prev_spr+0(ix), a
    ld e_prev_spr2+0(ix), a
    ld a, e_sprite+1(ix)
    ld e_prev_spr+1(ix), a
    ld e_prev_spr2+1(ix), a

    ld e_sprite+0(ix), e
    ld e_sprite+1(ix), d

ret

sys_frog_lifes_sprite::
    ld a, (vidas_rana)
    cp #3
    jr z, have_3
    cp #2
    jr z, have_2
    cp #1
    jr z, have_1
    ret
    have_1:
    ld de, #_spr_lifes1
    ld hl, #c_sprite_f
    ld  a, #e_type_none
    call man_entity_forall_matching_type
    ret
    have_2:
    ld de, #_spr_lifes2
    ld hl, #c_sprite_f
    ld  a, #e_type_none
    call man_entity_forall_matching_type
    ret
    have_3:
    ld de, #_spr_lifes3
    ld hl, #c_sprite_f
    ld  a, #e_type_none
    call man_entity_forall_matching_type
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DECREMENT HP
;;  Decrement the 3 frog lifes , if 0 -> game over 
;;MODIFIES
;;  AF, IX
value_en: .db 0
cmps_enemy_reset = (e_cmps_physics|e_cmps_enemy)
dechp:
    
    ld a, (vidas_rana)
    dec a
    jp  z, game_over
    ld (vidas_rana), a
    call sys_frog_lifes_sprite

    ld a, #70
    ld (value_en), a
    
    ld hl, #reset_enemy
    ld  a, #cmps_enemy_reset 
    call man_entity_forall_matching_iy

    call man_entity_get_from_idx
    ld e_x(ix), #2
    ld e_y(ix), #148

    ret           
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;RESET POSITION OF ENEMIES
;;  Reset position of all enemies for a new life
reset_enemy::

    ld a, (value_en)
    ld e_x(iy), a
    ld a, #30
    ld (value_en), a
    
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;GAME OVER
;;  End the game and reset 
;;MODIFIES
;;  HL, AF, DE, BC, IX, IY
.globl _gameover_end
game_over::

        
    call change_screen_to_8000 
    cpctm_clearScreen_asm 0
    call change_screen_to_C000 
    cpctm_clearScreen_asm 0
    xor a
    call sys_render_change_render_status 
   cpctm_setBorder_asm HW_BLACK

    ld hl, #_gameover_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   ld hl, #_gameover_end
   ld de, #0xBFFF
   call cpct_zx7b_decrunch_s_asm


    ld hl, #Key_Esc
    call waitKeyPressed1
    call game_menu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  COLLISION FROG WITH SOLID UP OR DOWN, ABOVE OR BELOW
;;  A collision between Frog and a solid type should be repositioned on up or down
;;  INPUT
;;      IX: Frog
;;      IY: Solid collisionable
;;  Modifies:
;;      ??
;;
collision_up_down:
    ;;Check if collision is above or below 
    ;;Right collision if ix.x > iy.x
    
    ld  a, e_y(iy)
    sub e_y(ix)
    jr  c, sccws_up
    ;;Below Colission
    sccws_down:
    ld  a, e_y(iy)
    sub e_h(ix)
    jr  sccws_continuee
    ;;Above Collision
    sccws_up:
    ld  a, e_y(iy)
    add e_h(iy)
    sccws_continuee:
    ld e_y(ix), a 

ret
;;====================================================================
;;====================================================================
;;                        PUBLIC FUNCTIONS
;;====================================================================
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  COLLISION FROG
;;  A collision between Frog and a collisionable (iy) has been detected
;;  INPUT
;;      IX: Frog
;;      IY: Entity Collisionable
;;  Modifies:
;;      ??
;;
cmps_mortal = (e_type_solid|e_type_mortal)
sys_collision_frog::
    ld      a, e_type(iy)
    and     #cmps_mortal
    cp      #cmps_mortal
    jp      z, dechp
    ;; is a solid collisionable?
    ld      a, e_type(iy)
    and     #e_type_solid
    jp      nz, sys_collision_frog_with_solid
    ;jr      . 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates the collision system
;;  Modifies:
;;      AF, HL, IX
;;
cmps_collision = (e_cmps_alive | e_cmps_physics | e_cmps_collider)
sys_collision_update::
    ld  hl, #sys_collision_collider_update
    ld   a, #cmps_collision ;;check collisions
    jp  man_entity_forall_matching
    ;;call    man_entity_forall_matching
    ;;ret

