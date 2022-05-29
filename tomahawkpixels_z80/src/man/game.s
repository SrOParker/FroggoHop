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
.include "man/initialize_entities.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTITY DEFINITIONS 
;;_name, _cmps, _type, _x, _y, _vx, _vy, _w, _h, _color,_ent_sprite, _prev_ptr, _col_func, _prev_spr, _prev_ptr2, _prev_spr2
DefineEntity player, #(e_cmps_alive|e_cmps_render|e_cmps_physics|e_cmps_collider), #(e_type_frog), 2, 148, 0, 0, 8, 32, 0xF0,  _spr_frog_static, p_8000position, sys_collision_frog, _spr_frog_static, c000position, _spr_frog_static
;DefineEntity invisible_wall, #(e_cmps_alive|e_cmps_collisionable), #(e_type_solid), 0, 80, 0, 0, 2, 80, 0xF0, 0x4000, nullptr, nullptr, nullptr, nullptr
DefineEntity p_enemy1,#(e_cmps_alive|e_cmps_render|e_cmps_physics|e_cmps_collisionable|e_cmps_enemy), #(e_type_solid|e_type_mortal|e_type_enemy_bee), 70, 60, -1, 0, 4, 16, 0xF0,  _spr_bee_move_0, p_8000position, nullptr, _spr_bee_move_0, c000position, _spr_bee_move_0
DefineEntity p_enemy2,#(e_cmps_alive|e_cmps_render|e_cmps_physics|e_cmps_collisionable|e_cmps_enemy), #(e_type_solid|e_type_mortal|e_type_enemy_floor), 70, 168, -2, 0, 8, 16, 0xF0,  _spr_oruga_left_0, p_8000position, nullptr, _spr_oruga_left_0, c000position, _spr_oruga_left_0
DefineEntity invisible_floor, #(e_cmps_alive|e_cmps_collisionable), #(e_type_solid), 0, 180, 0, 0, 80, 56, 0xF0, 0x4000, p_8000position, nullptr, 0x4000, c000position, 0x4000
DefineEntity platform_type_1, #(e_cmps_alive|e_cmps_render|e_cmps_collisionable), #(e_type_solid), 30, 130, 0, 0, 16, 16, 0xF0,  _spr_plat1, p_8000position, nullptr, _spr_plat1, c000position, _spr_plat1
DefineEntity platform_type_1_2, #(e_cmps_alive|e_cmps_physics|e_cmps_render|e_cmps_collisionable|e_cmps_platform), #(e_type_solid), 50, 100, 0, 0, 8, 16, 0xF0,  _spr_plat1_2, p_8000position, nullptr, _spr_plat1_2, c000position, _spr_plat1_2

DefineEntity platform_type_1_3, #(e_cmps_alive|e_cmps_render|e_cmps_collisionable), #(e_type_solid), 0, 128, 0, 0, 8, 16, 0xF0,  _spr_plat1_2, p_8000position, nullptr, _spr_plat1_2, c000position, _spr_plat1_2
DefineEntity platform_type_2, #(e_cmps_alive|e_cmps_render|e_cmps_collisionable), #(e_type_solid|e_type_mortal), 30, 172, 0, 0, 8, 16, 0xF0, _spr_plat_mortal, p_8000position, nullptr, _spr_plat_mortal, c000position, _spr_plat_mortal
DefineEntity platform_type_2_down, #(e_cmps_alive|e_cmps_render|e_cmps_collisionable), #(e_type_solid|e_type_mortal), 59, 20, 0, 0, 8, 16, 0xF0, _spr_plat_mortal_down, p_8000position, nullptr, _spr_plat_mortal_down, c000position, _spr_plat_mortal_down
DefineEntity platform_2_all, #(e_cmps_alive|e_cmps_render|e_cmps_collisionable), #(e_type_solid|e_type_mortal), 18, 108, 0, 0, 8, 16, 0xF0, _spr_plat_mortal_all, p_8000position, nullptr, _spr_plat_mortal_all, c000position, _spr_plat_mortal_all

DefineEntity p_climber_plant, #(e_cmps_alive|e_cmps_render|e_cmps_collisionable), #(e_type_solid|e_type_mortal), 23, 18, 0, 0, 2, 64, 0xF0, _spr_espina_up, p_8000position, nullptr, _spr_espina_up, c000position, _spr_espina_up

DefineEntity lifes_entity, #(e_cmps_alive|e_cmps_render), #(e_type_none), 2, 185, 0, 0, 16, 8, 0xF0,  _spr_lifes3, p_8000position, nullptr, _spr_lifes3, c000position, _spr_lifes3

DefineEntity invalid_entity, #(e_cmps_invalid), #(e_type_invalid), 0, 0, 0, 0, 0, 0, 0x00, 0x0000, nullptr, nullptr, nullptr, nullptr, 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STRINGS DEFINITIONS FOR MENU
;;

; HL -> KEY


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CREATOR
;;      This function call create for each entity
;;  Modifies:
;;      AF, HL, BC, DE
;;
lvl_0_creator::

   ld hl, #player
   call man_entity_create

   ld hl,#invisible_floor
   call man_entity_create

   ld hl,#lifes_entity
   call man_entity_create
   
   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret

lvl_1_creator::
   ld hl, #player
   call man_entity_create
   
   ld hl,#invisible_floor
   call man_entity_create
   ld hl,#invisible_floor
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #0
   ld e_h(ix), #8
   ld hl, #platform_type_1_3
   call man_entity_create

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #20
   ld e_y(ix), #85

   ld hl, #platform_type_1_2
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #85
   ld e_x(ix), #45

   ld hl, #platform_type_1
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #64
   ld e_y(ix), #85

   ld hl,#lifes_entity
   call man_entity_create

   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret
lvl_2_creator::
   ld hl, #player
   call man_entity_create
   
   ld hl,#invisible_floor
   call man_entity_create

   ld hl,#invisible_floor
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #0
   ld e_h(ix), #8
   
   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #10
   
   ld hl,#platform_type_1_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #25
   
   ld hl,#platform_type_1_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #50
   ld e_y(ix), #85
   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #70
   ld e_y(ix), #100

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #35

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #43

   ld hl,#lifes_entity
   call man_entity_create
   call sys_frog_lifes_sprite

   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret

lvl_3_creator::
   ld hl, #player
   call man_entity_create


   ld hl, #platform_2_all
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #20
   ld e_y(ix), #50

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #27

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #35

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #43

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #55
   ld e_y(ix), #97

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #20
   ld e_y(ix), #130

   ld hl, #platform_type_1_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #45
   ld e_y(ix), #130
   
   ld hl, #platform_type_1
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #30
   ld e_y(ix), #50


   ld hl,#invisible_floor
   call man_entity_create

   ld hl,#lifes_entity
   call man_entity_create
   call sys_frog_lifes_sprite
   
   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret

lvl_4_creator::
   ld hl, #player
   call man_entity_create

   ld hl,#invisible_floor
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #0
   ld e_h(ix), #8

   ld hl, #platform_type_1
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #0
   ld e_y(ix), #80

   ld hl, #platform_type_1
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #53
   ld e_y(ix), #142

   ld hl, #platform_2_all
   call man_entity_create

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #46
   
   ld hl,#invisible_floor
   call man_entity_create
   
   ld hl, #p_enemy1
   call man_entity_create

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #28
   ld e_y(ix), #85   
   
   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #50
   ld e_y(ix), #85

   ld hl,#lifes_entity
   call man_entity_create
   call sys_frog_lifes_sprite

   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret

lvl_5_creator::
   ld hl, #player
   call man_entity_create

   ld hl,#invisible_floor
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #0
   ld e_h(ix), #8
   

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #20

   ld hl, #platform_type_1_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #36
   ld e_y(ix), #85

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #55
   ld e_y(ix), #85

   ld hl,#invisible_floor
   call man_entity_create
   
   ld hl, #p_enemy1
   call man_entity_create

   ld hl, #p_enemy1
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #110
   ld e_x(ix), #50

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #55

   ld hl, #p_climber_plant
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #65
   ld e_y(ix), #130

   ld hl,#lifes_entity
   call man_entity_create
   call sys_frog_lifes_sprite

   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret

lvl_6_creator::
   ld hl, #player
   call man_entity_create
   
   ld hl,#invisible_floor
   call man_entity_create

   ld hl, #platform_2_all
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #12

   ld hl, #platform_2_all
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #32

   ld hl, #platform_2_all
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #52

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #70
   ld e_y(ix), #128
   
   ld hl, #p_enemy2
   call man_entity_create

   ld hl,#lifes_entity
   call man_entity_create
   call sys_frog_lifes_sprite
   
   ;ld hl, #invalid_entity
   ;call man_entity_create 

   

ret

lvl_7_creator::
   ld hl, #player
   call man_entity_create

   ld hl,#invisible_floor
   call man_entity_create
   
   ld hl,#invisible_floor
   ld__ix_de
   call man_entity_create
   ld e_y(ix), #0
   ld e_h(ix), #12

   ld hl, #p_climber_plant
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #13
   ld e_y(ix), #83

   ld hl, #p_enemy2
   call man_entity_create
   
   ld hl, #p_enemy1
   ld__ix_de
   call man_entity_create
   ld e_y(ix),#40

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #0
   ld e_y(ix), #65

   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #20
   ld e_y(ix), #80
   
   ld hl, #platform_type_1_3
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #70
   ld e_y(ix), #128

   ld hl, #platform_type_1_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #50
   ld e_y(ix), #90

   ld hl, #platform_2_all
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #30
   ld e_y(ix), #85

   ld hl, #platform_type_2
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #10
   ld e_y(ix), #69

   ld hl,#lifes_entity
   call man_entity_create
   call sys_frog_lifes_sprite

   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret

lvl_bonus_creator::
   
   ld hl, #player
   call man_entity_create

   ld hl,#invisible_floor
   call man_entity_create
   
   ld hl, #platform_type_1
   ld__ix_de
   call man_entity_create
   ld e_x(ix), #31
   ;ld hl, #invalid_entity
   ;call man_entity_create 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  WAIT KEY FOR PASS THE MENU
;;  Modifies:
;;      AF, HL, BC, DE
;;

reset::

   ;cpctm_clearScreen_asm 0

   call init_level_0

   ld a, #3
   ld (vidas_rana), a

   ld a, #0
   ld (nivel), a
   ;call lvl_0_creator
   call game_loop
ret


niveles::
   ld a, (nivel)
   
   cp a, #0
   jp z, nivel0
   cp a, #1
   jp z, nivel1
   cp a, #2
   jp z, nivel2
   cp a, #3
   jp z, nivel3
   cp a, #4
   jp z, nivel4
   cp a, #5
   jp z, nivel5
   cp a, #6
   jp z, nivel6
   cp a, #7
   jp z, nivel7
   cp a, #8
   jp z, nivel8
ret
   ;jp nz, game_over ;para que no haya nada infinito, cambiar despues




waitKeyPressed::
    push hl
    call cpct_scanKeyboard_f_asm
    pop hl
    push hl
    call cpct_isKeyPressed_asm
    pop hl
    jr nz, waitKeyPressed

    loop2:
    
    call cpct_waitVSYNC_asm
    call cpct_akp_musicPlay_asm 
         ;Reproduce continuamente siguiente byte si lo hay 
    call cpct_scanKeyboard_f_asm
    ld hl, #Key_Space
    call cpct_isKeyPressed_asm
    jr z, loop2
    ret

    waitKeyPressed1::
    ;push hl
    ;call cpct_scanKeyboard_f_asm
    ;pop hl
    ;push hl
    ;call cpct_isKeyPressed_asm
    ;pop hl
    ;jr nz, waitKeyPressed
   loop3:
      call cpct_scanKeyboard_f_asm
      ld hl, #Key_Esc
      call cpct_isKeyPressed_asm
      jr nz, game_menu

      ld hl, #Key_Space
      call cpct_isKeyPressed_asm
      jp nz, reset

      jr z, loop3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  GAME
;;      This function call game init and game loop
;;  Modifies:
;;      All
;;    

game_loop::
   ;call cpct_akp_stop     ;cuando se termine el bucle

;;==============MAIN LOOP===================
   loop:
   ld a, (nivel)
   cp #8
   jr nz, no_bonus
   cpctm_setBorder_asm HW_PASTEL_BLUE
   jr game
   no_bonus:
   cpctm_setBorder_asm HW_GREEN

      game:
      call sys_collision_update
      ;cpctm_setBorder_asm HW_RED
      call sys_render_update
      ;cpctm_setBorder_asm HW_YELLOW
      call sys_input_update
      call man_entity_jump_control ;;frog jump
      ;cpctm_setBorder_asm HW_WHITE
      call sys_physics_update
      
      ;cpctm_setBorder_asm HW_CYAN
      ;call man_entity_update

   call cpct_waitVSYNC_asm

   
   call man_entity_get_from_idx
   ;ld a, e_x(ix)
   ;ld a, e_y(ix)
   call niveles
jp loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  MENU
;;      This function call MENU
;;  Modifies:
;;      AF, HL, BC, DE
;;


.globl _background_end
game_menu::
   cpctm_clearScreen_asm 0
   call sys_render_init
   cpctm_setBorder_asm HW_GREEN
   ;ld hl, #_bgfroggo
   ;ld de, #0xC000
   ;ld bc, #0x3E0F
   ;ldir

   ;llamada descompresor
   
   ld hl, #_background_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm


   ld    de, #_song_menu1          ; Nombre de cancion declarado en conversion
   call cpct_akp_musicInit_asm

   ld hl, #Key_Space
   call waitKeyPressed

   call cpct_akp_stop_asm
   xor a
   ld (nivel), a
   ld a, #3
   ld (vidas_rana), a
   cpctm_clearScreen_asm 0

call init_level_0
call game_loop


nivel0:

   ld a, e_x(ix)
   cp #70
   jp z, init_level_1

ret
nivel1:
   ld a, e_x(ix)
   cp #70
   jp z, check_y
   ret
   check_y:
   ld a, e_y(ix)
   cp #57
   jp z, init_level_2

ret
nivel2:
   ld a, e_x(ix)
   cp #70
   jp z, check_yy
   ret
   check_yy:
   ld a, e_y(ix)
   cp #72
   jp z, init_level_3
ret
nivel3:
   ld a, e_x(ix)
   cp #36
   jp z, check_yyy
   ret
   check_yyy:
   ld a, e_y(ix)
   cp #22
   jp z, init_level_4
ret
nivel4:
   ld a, e_x(ix)
   cp #4
   jp z, check_yyyy
   ret
   check_yyyy:
   ld a, e_y(ix)
   cp #52
   jp z, init_level_5
ret
nivel5:
   ld a, e_x(ix)
   cp #70
   jp z, check_yyyyy
   ret
   check_yyyyy:
   ld a, e_y(ix)
   cp #148
   jp z, init_level_6
ret
nivel6:
   ld a, e_x(ix)
   cp #70
   jp z, check_yyyyyy
   ret
   check_yyyyyy:
   ld a, e_y(ix)
   cp #100
   jp z, init_level_7
ret
nivel7:
   ld a, e_x(ix)
   cp #2
   jp z, check_yyyyyyy
   ret
   check_yyyyyyy:
   ld a, e_y(ix)
   cp #37
   jp z, init_level_bonus
ret

nivel8:
   ld a, e_x(ix)
   cp #70
   jp z, game_menu
ret