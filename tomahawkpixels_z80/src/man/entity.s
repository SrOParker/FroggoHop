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


.module Entity_Manager

.include "entity.h.s"
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "sys/render.h.s"

num_entities::  .db 0                           ;;entities alive
last_elem_ptr:: .dw entity_array                ;;entities array, last element of the array
;;DefineEntityArray entity_array, max_entities  ;;other form to define entity_array
entity_array::  .ds max_entities * sizeof_e     ;;.ds define ceros (7 in this case) ;; other form to do last line
vidas_rana:: .db 3
nivel:: .db 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  JUMP VARIABLES
;;
frog_jump: .db #-1

jumptable:
    .db #-28, #-20, #-14, #-8, #-4, #-2, #-2
    .db #-1, #00, #00, #00
    .db #01, #02, #02, #04, #08, #14, #20, #28
    .db #0x80




;;====================================================================
;;====================================================================
;;                        PRIVATE FUNCTIONS
;;====================================================================
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  INIT
;;      Initializes the entity manager
;;  Modifies:
;;      AF, HL
;;
man_entity_init::
    
    xor a
    ld (num_entities), a
    ld hl, #entity_array
    ld (last_elem_ptr), hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  GET frog jump status
;;      Catch frog_jump status and returned 
;;  Modifies:
;;      AF
;;

man_entity_get_frog_jump_A::
    ld a, (frog_jump)
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  SET frog_jump status
;;  INput
;;      A = new satus of frog_jump
;;
man_entity_set_frog_jump_A::
    ld (frog_jump), a
ret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  JUMP CONTROL
;;      Check if the entity is jumping and jump
;;  Modifies:
;;      ??
;;

man_entity_jump_control::
    call man_entity_get_from_idx
    ;; is jumping ?
    ld           a, (frog_jump)     ;; A = frog jump status
    cp           #-1                ;; if a == -1 ----- frog is not jumping
    ret          z                  ;; if a == -1 ----- return

    ;;get jump value
    ld          hl, #jumptable       ;;get jumptable
    ld           c, a
    ld           d, #0              ;;add position of the jumptable
    add         hl, bc              ;; hl is the next position of the jumptable
    ;; check if is the end of the jumptable
    ld           a, (hl)
    cp          #0x80
    jr z, end_of_jump
    ;;do movement
    ld           b, a
    ld           a, e_y(ix)
    add          b
   
    ld     e_y(ix), a   
    ;; inc frog_jump
    ld           a, (frog_jump)
    inc          a
    ld (frog_jump), a
    ret
    ;; end of jump, put -1 in frog_jump 
    end_of_jump:
    call sys_render_changue_static
    ld a, #-1
    ld (frog_jump), a
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  START JUMP CONTROL
;;      Change frog_jump -- start the jump process
;;  Modifies:
;;      AF
;;
man_entity_init_jump_control::
    ld a, (frog_jump)
    cp #-1
    ret nz

    ld a, #0
    ld (frog_jump), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  GET
;;      Get the first position of the entity array on iy
;;  Modifies:
;;      IX
;;
man_entity_get_from_idy::
    
    ld iy, #entity_array

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  GET
;;      Get the first position of the entity array on ix
;;  Modifies:
;;      IX
;;
man_entity_get_from_idx::
    
    ld ix, #entity_array

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CREATE
;;      Create a new entity
;;  Modifies:
;;      AF, HL, BC, DE
;;
man_entity_create::
    ld      de, (last_elem_ptr)
    ld      bc, #sizeof_e
    ldir

    ld       a, (num_entities)
    inc      a
    ld      (num_entities), a

    ld      hl, (last_elem_ptr)
    ld      bc, #sizeof_e
    add     hl, bc

    ld      (last_elem_ptr), hl

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  DESTROY
;;      ??
;;  Modifies:
;;      ??
;;
man_entity_destroy::
    ld hl, #man_entity_set4destruction
    call man_entity_forall
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  SET FOR DESTRUCTION
;;      Change first entity byte to invalid
;;  INPUT:
;;      IX: variable to set deleted
;;
man_entity_set4destruction::
    ;;cpctm_clearScreen_asm 0
    ld e_cmps(ix), #e_cmps_invalid
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  FORALL
;;      loop the entity array and execute the function FORALL entities
;;  INPUT
;;      HL: function to call
;;  Modifies:
;;      AF, DE, IX, BC
;;

man_entity_forall::
    ld      (functocall), hl         ;; set function to be called
    ld      ix, #entity_array               ;; IX points to first entitie

    ;;check if entity is valid
    ;; if this first byte = 0, its not a valid entity
nexte:
    ld      a, e_type(ix)                   ;;/
    or      #e_type_invalid                 ;; Check invalid entities, if is invalid return and end the loop
    ret     z                               ;;\

    functocall = .+1                 ;;/
    call    functocall  
addnext:
    ;;Entity is not valid, point to next entity and repeat
    ld      bc, #sizeof_e
    add     ix, bc
    jr     nexte

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  FORALL MATCHING
;;      loop the entity array looking for entities with first bit like a and execute de function hl
;;  INPUT
;;      HL: function to call
;;      A : value to check
;;  Modifies:
;;      AF, DE, IX, BC
;;

type_match:: .db 0                          ;;This position save the value to check forall entities, ld (type_match), a 
man_entity_forall_matching::
    ld      (type_match), a
    ld      (update_call_match), hl         ;; set function to be called

    ld      ix, #entity_array               ;; IX points to first entitie

    ;;check if entity is valid
    ;; if this first byte = 0, its not a valid entity
next_entity_match:
    ld      a, e_cmps(ix)                   ;;/
    or      #e_cmps_invalid                 ;; Check invalid entities, if is invalid return and end the loop
    ret     z                               ;;\

    ld      a, (type_match)                 ;;/
    ld      b, a                            ;; Check if a is like e_cmps(ix)
    ld      a, e_cmps(ix)                   ;; and b, e_cmps(ix) ;; only the bytes with 1 in both functions remain
    and     b                               ;;\
    cp      b;;#(type_match)                ;; check the and result with b, if is the same number z is 0
    call    z, function_call                ;; Call the function if z is 0

    ;;Entity is not valid, point to next entity and repeat
next_one:
    ld      bc, #sizeof_e
    add     ix, bc
    jr     next_entity_match
function_call:              
    update_call_match = .+1                 ;;/
    call    update_call_match               ;;  Call function
    ret                                     ;;\

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  FORALL MATCHING IY
;;      Same function of forall_matching but using iy (not use ix)
;;  INPUT
;;      HL: function to call
;;      A : value to check
;;  Modifies:
;;      AF, DE, IY, BC
;;
type_matchh:: .db 0                          ;;This position save the value to check forall entities, ld (type_matchh), a 
man_entity_forall_matching_iy:
    ld      (type_matchh), a
    ld      (update_call_matchh), hl         ;; set function to be called

    ld      iy, #entity_array               ;; IX points to first entitie

    ;;check if entity is valid
    ;; if this first byte = 0, its not a valid entity
next_entity_matchh:
    ld      a, e_cmps(iy)                   ;;/
    or      #e_cmps_invalid                 ;; Check invalid entities, if is invalid return and end the loop
    ret     z                               ;;\

    ld      a, (type_matchh)                 ;;/
    ld      b, a                            ;; Check if a is like e_cmps(iy)
    ld      a, e_cmps(iy)                   ;; and b, e_cmps(iy) ;; only the bytes with 1 in both functions remain
    and     b                               ;;\
    cp      b;;#(type_match)                ;; check the and result with b, if is the same number z is 0
    call    z, function_calll                ;; Call the function if z is 0

    ;;Entity is not valid, point to next entity and repeat
    ld      bc, #sizeof_e
    add     iy, bc
    jr     next_entity_matchh
function_calll:              
    update_call_matchh = .+1                 ;;/
    call    update_call_matchh               ;;  Call function
    ret             









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  FORALL MATCHING TYPE
;;      loop the entity array looking for entities with SECOND bit like a and execute de function hl
;;  INPUT
;;      HL: function to call
;;      A : value to check
;;  Modifies:
;;      AF, DE, IX, BC
;;

tyype_match:: .db 0                          ;;This position save the value to check forall entities, ld (type_match), a 
man_entity_forall_matching_type::
    ld      (tyype_match), a
    ld      (updatee_call_match), hl         ;; set function to be called

    ld      ix, #entity_array               ;; IX points to first entitie

    ;;check if entity is valid
    ;; if this first byte = 0, its not a valid entity
next_entity__match:
    ld      a, e_cmps(ix)                   ;;/
    or      #e_cmps_invalid                 ;; Check invalid entities, if is invalid return and end the loop
    ret     z                               ;;\

    ld      a, (tyype_match)                 ;;/
    ld      b, a                            ;; Check if a is like e_cmps(ix)
    ld      a, e_type(ix)                   ;; and b, e_cmps(ix) ;; only the bytes with 1 in both functions remain
    and     b                               ;;\
    cp      b;;#(type_match)                ;; check the and result with b, if is the same number z is 0
    call    z, funcction_call                ;; Call the function if z is 0

    ;;Entity is not valid, point to next entity and repeat
next_onet:
    ld      bc, #sizeof_e
    add     ix, bc
    jr     next_entity__match
funcction_call:              
    updatee_call_match = .+1                 ;;/
    call    updatee_call_match               ;;  Call function
    ret                                     ;;\


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  MAN ENTITY UPDATE
;;      Update the array removing dead entities 
;;  Modifies:
;;      ??
;;
man_entity_update::
    ;call man_entity_update_w_h_when_change
    ;;other things
ret


