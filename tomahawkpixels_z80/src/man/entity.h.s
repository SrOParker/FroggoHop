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
;;      ENTITY MANAGER FUNCTIONS, DECLARATIONS AND GLOBALS
;;=================================================================
;;=================================================================


;;-----------------------------------------------------------------
;;  Entities
;;  Declaration of entity structure
;;
.globl vidas_rana
.globl nivel

max_entities = 18

;;entity positions
e_cmps      = 0     ;; 1 byte , is a byte
e_type      = 1
e_x         = 2     ;; 1 byte , is a byte
e_y         = 3     ;; 1 byte , is a byte
e_w         = 4     ;; 1 byte , is a byte
e_h         = 5     ;; 1 byte , is a byte
e_vx        = 6     ;; 1 byte , is a byte
e_vy        = 7     ;; 1 byte , is a byte           
e_color     = 8     ;; 1 byte , is a byte        
e_sprite    = 9     ;; 2 bytes, is a pointer
e_prev_ptr  = 11    ;; 2 bytes, is a pointer
e_col_func  = 13    ;; 2 bytes, is a pointer
e_prev_spr  = 15    ;; 2 bytes, is a pointer
e_prev_ptr2 = 17    ;; 2 bytes, is a pointer
e_prev_spr2 = 19    ;; 2 bytes, is a pointer

sizeof_e    = 21    ;; entity size

;;-----------------------------------------------------------------
;;  Entities
;;  Declaration entity components
;;
;; BitField                              ;;--EJEMPLOS---------;;
e_cmps_default       = 0xFF              ;;1110 0000 --> 0xE0 ;;
e_cmps_invalid       = 0x00              ;;1100 0000 --> 0xC0 ;;    
e_cmps_alive         = 0x80              ;;8421 8421----------;;
e_cmps_render        = 0x40
e_cmps_physics       = 0x20
e_cmps_collider      = 0x10
e_cmps_collisionable = 0x08
e_cmps_platform      = 0x04
e_cmps_enemy         = 0x02
e_cmps_platform_up   = 0x01
;;-----------------------------------------------------------------
;;  Entities
;;  Declaration entity types
;;
;; BitField        
e_type_frog         = 0x80
e_type_mortal       = 0x40
e_type_solid        = 0x20
e_type_enemy_bee    = 0x10
e_type_enemy_floor  = 0x08
e_type_none         = 0x04
e_type_invalid      = 0x00           


;;-----------------------------------------------------------------
;;  Entity MACROS
;;  Macro definitions -- creation of entities
;;
.macro DefineEntityAnnonimous _cmps, _type, _x, _y, _vx, _vy, _w, _h, _color, _ent_sprite, _prev_ptr, _col_func, _prev_spr, _prev_ptr2, _prev_spr2
   .db _cmps
   .db _type
   .db _x
   .db _y
   .db _w
   .db _h
   .db _vx
   .db _vy
   .db _color
   .dw _ent_sprite
   .dw _prev_ptr
   .dw _col_func
   .dw _prev_spr
   .dw _prev_ptr2
   .dw _prev_spr2
.endm

;; example of use --> DefineEntity player, 0x40, 40, 80, 1, 1, 2, 8, 0xF0, 0xC000
.macro DefineEntity _name, _cmps, _type, _x, _y, _vx, _vy, _w, _h, _color,_ent_sprite, _prev_ptr, _col_func, _prev_spr, _prev_ptr2, _prev_spr2
   _name::
    DefineEntityAnnonimous _cmps, _type, _x, _y, _vx, _vy, _w, _h, _color, _ent_sprite, _prev_ptr, _col_func, _prev_spr, _prev_ptr2, _prev_spr2
.endm

.macro DefineEntityArray _name, _N
    _name::
    .rept _N
    DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAA
    .endm 
.endm

;;-----------------------------------------------------------------
;;  Global functions
;;
.globl man_entity_init
.globl man_entity_create
.globl man_entity_destroy
.globl man_entity_forall
.globl man_entity_forall_matching
.globl man_entity_forall_matching_iy
.globl man_entity_forall_matching_type
.globl man_entity_get_from_idx
.globl man_entity_get_from_idy
.globl man_entity_set4destruction
.globl man_entity_update
.globl man_entity_jump_control
.globl man_entity_init_jump_control
.globl man_entity_get_frog_jump_A
.globl man_entity_set_frog_jump_A