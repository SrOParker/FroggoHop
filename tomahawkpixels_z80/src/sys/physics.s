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


.module Physic_System

.include "physics.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
;;====================================================================
;;====================================================================
;;                        PRIVATE FUNCTIONS
;;====================================================================
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gravity when the frog is in the air
;;  Modifies:
;;      AF
;;
sys_physics_update_gravity:
    call man_entity_get_from_idx
    ld a, e_y(ix)
    cp #148 ;; mmm
    jr nz, not_in_floor
    ret
    not_in_floor:
    inc a
    inc a
    inc a 
    inc a 
    ld e_y(ix), a
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates one entity having movement component
;;  Input:
;;      IX: Pointer to entity having movement component
;;  Modifies:
;;      AF
;;
cmps_bee = (e_type_enemy_bee)
cmps_en_floor = (e_type_enemy_floor)
sys_physics_update_one_entity:

    ld a, e_type(ix)
    and #cmps_bee
    cp #cmps_bee
    jr z, bee_movement
    
    ld a, e_type(ix)
    and #cmps_en_floor
    cp #cmps_en_floor
    jr z, movement_enemy_floor
    
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a 
    
    ld a, e_y(ix)
    add e_vy(ix)
    ld e_y(ix), a


    ret 
    movement_enemy_floor:
    
    ld a , e_x(ix)
    cp #22
    jr z, move_c_direction

    cp a, #70
    jr z, c_direction
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a 
    ret
    bee_movement:
    ld a, e_x(ix)
    cp #3
    jr z, move_end
    
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a 

    ret
    move_c_direction:
    ld e_vx(ix), #2
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a 
    ret
    c_direction:
    ld e_vx(ix), #-2
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a 
    ret
    move_end:
    ld e_x(ix), #70

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates platform having physics component
;;  Input:
;;      IX: Pointer to entity having movement component
;;  Modifies:
;;      AF
;;
mov_counter: .db 0 
dir: .db 0
sys_platform1_2_physics:

    ld a, (mov_counter)
    inc a
    ld (mov_counter), a
    cp a, #0
    jr z, right_m

    cp a, #10
    jr z, left_m
    ld a, (dir)
    add e_x(ix)
    ld e_x(ix), a
    ret
    left_m:
    ld a, e_x(ix)
    dec a
    ld e_x(ix), a
    ld a, #-10
    ld (mov_counter), a
    xor a
    dec a
    ld (dir), a

    ret
    right_m:

    ld a, e_x(ix)
    inc a
    ld e_x(ix), a
    xor a
    inc a
    ld (dir), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates the platforms
;;  Modifies:
;;      AF, HL, IX
;;
sys_physics_platform_update:

    ld a, (yes_or_not_ejecutable)
    cp #0
    jr z, ejecutable
    dec a
    ld (yes_or_not_ejecutable), a
    ret
    ejecutable:
    ld  hl, #sys_platform1_2_physics
    ld   a, #cmps_physics_p_1_2

    call    man_entity_forall_matching
    ld a, #3
    ld (yes_or_not_ejecutable), a
ret 
;;====================================================================
;;====================================================================
;;                        PUBLIC FUNCTIONS
;;====================================================================
;;====================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates the physics system
;;  Modifies:
;;      AF, HL, IX
;;
yes_or_not_ejecutable: .db 0
cmps_physics_p_1_2 = (e_cmps_alive | e_cmps_physics | e_cmps_collisionable | e_cmps_platform)
cmps_physics = (e_cmps_alive | e_cmps_physics)
sys_physics_update::
    call    sys_physics_update_gravity
    ld  hl, #sys_physics_update_one_entity
    ld   a, #cmps_physics

    call    man_entity_forall_matching

    ;; platform with movement update
    call sys_physics_platform_update

ret
