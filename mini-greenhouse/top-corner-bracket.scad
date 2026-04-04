// Frame top corner bracket

// Copyright(C) 2024 Embecosm Limited(www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Designed to hold the corners together and provide a projection to locate
// the top.

include <../lib/screw-hole.scad>

EPS = 0.01;
EPS2 = EPS * 2;
INF = 500;
RT2 = sqrt(2.0);

VFRAME_W = 17.0;
HFRAME_W = 46.5;
HFRAME_T = 11.5;
OVERLAP_W = HFRAME_W - VFRAME_W;

// Make the bracket thick enough that the screw tip won't pop out.
SCREW_L = 20.0;
BRACKET_T = SCREW_L + 0.5;

ANGLE_SHORT_LEN = 80;
ANGLE_LONG_LEN = ANGLE_SHORT_LEN + OVERLAP_W * 2;


// Translate and rotate a screwhole
module transrot_screwhole(x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(4.0);
}

// Screw hols for the raw block
module screwholes() {
     let(overlap = HFRAME_W - VFRAME_W,
	  xbase = OVERLAP_W / RT2,
	  yoff1 = OVERLAP_W / 3,
	  yoff2 = yoff1 * 2,
	  xoff1 = xbase + yoff1,
	  xoff2 = xbase + yoff2,
	  xoff3 = ANGLE_LONG_LEN - xoff1,
	  xoff4 = ANGLE_LONG_LEN - xoff2) {
	  transrot_screwhole(x = xoff1, y = yoff1, z = -EPS, ax = 180);
	  transrot_screwhole(x = xoff2, y = yoff2, z = -EPS, ax = 180);
	  transrot_screwhole(x = xoff3, y = yoff1, z = -EPS, ax = 180);
	  transrot_screwhole(x = xoff4, y = yoff2, z = -EPS, ax = 180);
     }
}

// The raw block
module angle_block() {
     difference() {
	  cube(size = [ANGLE_LONG_LEN, OVERLAP_W, BRACKET_T], center = false);
	  translate(v = [0, -EPS, -EPS])
	       rotate(a = [0, 0, 45])
	            cube([INF, INF, INF], center = false);
	  translate(v = [ANGLE_LONG_LEN, -EPS, -EPS])
	       rotate(a = [0, 0, 45])
	            cube([INF, INF, INF], center = false);
	  screwholes();
     }
}

// The block positioned so its ends touch the X and Y axes
module rotated_angle_block() {
     let(overlap = HFRAME_W - VFRAME_W,
	 off = ANGLE_SHORT_LEN / 2 / RT2){
	  translate(v = [off, -off , 0])
	       // Rotate to be corner on the origin
	       rotate(a = [0, 0, 45])
		    translate(v = [-ANGLE_LONG_LEN / 2.0, -OVERLAP_W, 0])
	                 angle_block();
     }
}

// The frame
module horiz_frame() {
     union() {
	  translate(v=[-EPS, EPS - OVERLAP_W, BRACKET_T - HFRAME_T + EPS])
	       cube(size = [INF, OVERLAP_W, INF], center = false);
	  translate(v=[-EPS, EPS - INF, BRACKET_T - HFRAME_T + EPS])
	       cube(size = [OVERLAP_W, INF, INF], center = false);
     }
}

module frame_cutout() {
     difference() {
	  rotated_angle_block();
	  horiz_frame();
     }
}

frame_cutout();
