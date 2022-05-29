#include "bee_enemy.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_bee_move_0: 8x16 pixels, 4x16 bytes.
const u8 spr_bee_move_0[4 * 16] = {
	0x00, 0x00, 0x30, 0x30,
	0x00, 0x00, 0x30, 0x30,
	0x00, 0x20, 0x31, 0x20,
	0x00, 0x20, 0x31, 0x20,
	0x00, 0x22, 0x30, 0x00,
	0x00, 0x22, 0x30, 0x00,
	0x31, 0x32, 0x12, 0x02,
	0x31, 0x32, 0x12, 0x02,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00
};

// Tile spr_bee_move_1: 8x16 pixels, 4x16 bytes.
const u8 spr_bee_move_1[4 * 16] = {
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x20, 0x10, 0x30,
	0x00, 0x20, 0x10, 0x30,
	0x00, 0x22, 0x31, 0x00,
	0x00, 0x22, 0x31, 0x00,
	0x31, 0x32, 0x12, 0x02,
	0x31, 0x32, 0x12, 0x02,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00
};

// Tile spr_bee_move_2: 8x16 pixels, 4x16 bytes.
const u8 spr_bee_move_2[4 * 16] = {
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x20, 0x00, 0x00,
	0x00, 0x20, 0x00, 0x00,
	0x00, 0x22, 0x30, 0x30,
	0x00, 0x22, 0x30, 0x30,
	0x31, 0x32, 0x13, 0x02,
	0x31, 0x32, 0x13, 0x02,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00
};

// Tile spr_bee_move_3: 8x16 pixels, 4x16 bytes.
const u8 spr_bee_move_3[4 * 16] = {
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x20, 0x10, 0x30,
	0x00, 0x20, 0x10, 0x30,
	0x00, 0x22, 0x31, 0x00,
	0x00, 0x22, 0x31, 0x00,
	0x31, 0x32, 0x12, 0x02,
	0x31, 0x32, 0x12, 0x02,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x30, 0x12, 0x12,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x01, 0x21, 0x20,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00
};
