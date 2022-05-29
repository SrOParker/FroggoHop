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
;;                  RENDER FUNCTIONS
;;=================================================================
;;=================================================================
;;basic functions
.globl sys_render_init
.globl sys_render_init_bonus
.globl sys_render_one_entity
.globl sys_first_render_one_entity
.globl sys_render_update
.globl sys_render_level_start
;;animation functions
.globl sys_render_change_walk_step_right
.globl sys_render_change_walk_step_left
.globl sys_render_change_jump
.globl sys_render_changue_static

.globl change_screen_to_8000
.globl change_screen_to_C000
.globl sys_render_change_render_status
;;-----------------------------------------------------------------
;;palette
;;
.globl _g_palette
.globl _g_palette_bonus
;;-----------------------------------------------------------------
;;Sprites
;;
;;frog static sprites
.globl _spr_frog_static
.globl _spr_frog_static_left

;;frog movement sprites
.globl _spr_frog_walk_0
.globl _spr_frog_walk_1
.globl _spr_frog_walk_left_0
.globl _spr_frog_walk_left_1


;;bee move sprites
.globl _spr_bee_move_0
.globl _spr_bee_move_1
.globl _spr_bee_move_2
.globl _spr_bee_move_3
.globl _spr_bee_move_right_0
.globl _spr_bee_move_right_1
.globl _spr_bee_move_right_2
.globl _spr_bee_move_right_3
.globl _spr_oruga_left_0
.globl _spr_oruga_left_1
.globl _spr_oruga_left_2
.globl _spr_oruga_left_3
.globl _spr_oruga_right_0
.globl _spr_oruga_right_1
.globl _spr_oruga_right_2
.globl _spr_oruga_right_3


;;objects sprites
.globl _spr_plat1
.globl _spr_plat1_2
.globl _spr_plat_mortal
.globl _spr_plat_mortal_down
.globl _spr_plat_mortal_all
.globl _spr_espina_up

;;maps 

;;lifes
.globl _spr_lifes1
.globl _spr_lifes2
.globl _spr_lifes3