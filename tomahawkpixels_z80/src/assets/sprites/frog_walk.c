#include "frog_walk.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_frog_walk_0: 16x32 pixels, 8x32 bytes.
const u8 spr_frog_walk_0[8 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x31, 0x22, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x31, 0x22, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x21, 0x13, 0x31, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x21, 0x13, 0x31, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x03, 0x13, 0x21, 0x20,
	0x00, 0x00, 0x00, 0x10, 0x03, 0x13, 0x21, 0x20,
	0x00, 0x00, 0x10, 0x21, 0x13, 0x03, 0x03, 0x12,
	0x00, 0x00, 0x10, 0x21, 0x13, 0x03, 0x03, 0x12,
	0x00, 0x00, 0x21, 0x03, 0x03, 0x30, 0x03, 0x12,
	0x00, 0x00, 0x21, 0x03, 0x03, 0x30, 0x03, 0x12,
	0x00, 0x30, 0x21, 0x03, 0x03, 0x30, 0x33, 0x30,
	0x00, 0x30, 0x21, 0x03, 0x03, 0x30, 0x33, 0x30,
	0x10, 0x03, 0x03, 0x03, 0x03, 0x33, 0x32, 0x00,
	0x10, 0x03, 0x03, 0x03, 0x03, 0x33, 0x32, 0x00,
	0x10, 0x23, 0x03, 0x21, 0x13, 0x33, 0x20, 0x00,
	0x10, 0x23, 0x03, 0x21, 0x13, 0x33, 0x20, 0x00,
	0x10, 0x23, 0x03, 0x21, 0x33, 0x32, 0x00, 0x00,
	0x10, 0x23, 0x03, 0x21, 0x33, 0x32, 0x00, 0x00,
	0x31, 0x23, 0x03, 0x21, 0x23, 0x12, 0x00, 0x00,
	0x31, 0x23, 0x03, 0x21, 0x23, 0x12, 0x00, 0x00,
	0x21, 0x03, 0x30, 0x12, 0x30, 0x03, 0x30, 0x20,
	0x21, 0x03, 0x30, 0x12, 0x30, 0x03, 0x30, 0x20,
	0x21, 0x12, 0x30, 0x20, 0x00, 0x21, 0x13, 0x32,
	0x21, 0x12, 0x30, 0x20, 0x00, 0x21, 0x13, 0x32,
	0x21, 0x03, 0x33, 0x32, 0x00, 0x10, 0x33, 0x20,
	0x21, 0x03, 0x33, 0x32, 0x00, 0x10, 0x33, 0x20,
	0x10, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x00,
	0x10, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x00
};

// Tile spr_frog_walk_1: 16x32 pixels, 8x32 bytes.
const u8 spr_frog_walk_1[8 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x31, 0x22, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x31, 0x22, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x21, 0x13, 0x31, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x21, 0x13, 0x31, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x03, 0x13, 0x21, 0x20,
	0x00, 0x00, 0x00, 0x10, 0x03, 0x13, 0x21, 0x20,
	0x00, 0x00, 0x10, 0x21, 0x13, 0x03, 0x03, 0x12,
	0x00, 0x00, 0x10, 0x21, 0x13, 0x03, 0x03, 0x12,
	0x00, 0x00, 0x21, 0x03, 0x03, 0x30, 0x03, 0x12,
	0x00, 0x00, 0x21, 0x03, 0x03, 0x30, 0x03, 0x12,
	0x10, 0x30, 0x03, 0x03, 0x03, 0x30, 0x33, 0x30,
	0x10, 0x30, 0x03, 0x03, 0x03, 0x30, 0x33, 0x30,
	0x21, 0x03, 0x21, 0x03, 0x03, 0x33, 0x32, 0x00,
	0x21, 0x03, 0x21, 0x03, 0x03, 0x33, 0x32, 0x00,
	0x21, 0x03, 0x12, 0x03, 0x13, 0x33, 0x20, 0x00,
	0x21, 0x03, 0x12, 0x03, 0x13, 0x33, 0x20, 0x00,
	0x21, 0x03, 0x12, 0x03, 0x33, 0x32, 0x00, 0x00,
	0x21, 0x03, 0x12, 0x03, 0x33, 0x32, 0x00, 0x00,
	0x21, 0x23, 0x12, 0x03, 0x23, 0x12, 0x00, 0x00,
	0x21, 0x23, 0x12, 0x03, 0x23, 0x12, 0x00, 0x00,
	0x10, 0x13, 0x03, 0x21, 0x03, 0x12, 0x00, 0x00,
	0x10, 0x13, 0x03, 0x21, 0x03, 0x12, 0x00, 0x00,
	0x10, 0x03, 0x33, 0x30, 0x32, 0x12, 0x20, 0x00,
	0x10, 0x03, 0x33, 0x30, 0x32, 0x12, 0x20, 0x00,
	0x10, 0x23, 0x03, 0x13, 0x20, 0x31, 0x32, 0x00,
	0x10, 0x23, 0x03, 0x13, 0x20, 0x31, 0x32, 0x00,
	0x00, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x00,
	0x00, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x00
};
