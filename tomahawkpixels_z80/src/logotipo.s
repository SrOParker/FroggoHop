.module Logo

.include "cpct_globals.h.s"
.include "logotipo.h.s"
.include "cpctelera.h.s"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;PRINT LOGO
;;
;;MODIFIES
;; ALL
logotipo::
   cpctm_setBorder_asm HW_CYAN

   ld hl, #_logo0_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo1_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo2_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo3_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo4_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo5_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo6_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   ld hl, #_logo7_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
   
   ld a, #50
   waits:
   cp a, #0
   jr nz, halts
   ret
   halts:
   halt 
   halt
   halt
   halt
   halt
   halt
   halt
   halt
   halt   
   halt 
   halt
   halt
   dec a
   jr waits
ret