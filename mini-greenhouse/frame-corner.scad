// Frame corner bracket

// Copyright(C) 2023 Embecosm Limited(www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Designed to hold the corners together and provide a projection to locate
// the top.

include <../lib/screw-hole.scad>

EPS = 0.01;
EPS2 = EPS * 2;
INF = 1000;
RT2 = sqrt(2.0);

// Dimensions of horizontal and vertical pieces
H_HEIGHT = 30;
H_THICK = 18;
H_OFFSET = 0;
H_WIDTH = 100;

V_HEIGHT = 100;
V_THICK = 15;
V_EDGE = 40;
V_WIDTH = V_EDGE + 18 * RT2;

// Dimensions of bracket
B_HEIGHT = 30;
B_THICK = 11;
B_LENGTH = 40;
B_OFFSET_L = B_THICK * RT2;
B_OFFSET_R = H_THICK * RT2;

module raw_vert_panel() {
     difference() {
	  cube(size = [V_WIDTH, V_THICK, V_HEIGHT + EPS2], center = false);
	  translate(v = [V_EDGE, -EPS, -EPS])
	       rotate(a = [0, 45, 0])
	            cube(size = [INF, INF, INF], center = false);
     }
}

// Vertical panel. Corner is at the origin, it sits at 45 degrees
module vert_panel() {
     rotate(a = [0, 0, -45])
	  translate(v = [-V_EDGE, -V_THICK, 0])
	       raw_vert_panel();
}

// Horizontal panel. Corner is at the origin.
module horiz_panel() {
     difference () {
	  translate(v = [0, -H_THICK, -EPS])
	       cube(size = [H_WIDTH, H_THICK, H_HEIGHT + EPS2]);
	  rotate (a = [0, 0, -45])
	       translate (v = [-INF / 2, -INF, -INF / 2])
	            cube (size = [INF, INF, INF], center = false);
     }
}

// Complete joint
module joint() {
     difference () {
	  translate (v = [0, H_THICK, 0])
	       union() {
	            horiz_panel();
		    vert_panel();
               }
	  translate (v = [-INF / 2, -INF, -INF/2])
	       cube (size = [INF, INF, INF], center = false);
     }
}

// Translate and rotate a screwhole
module transrot_screwhole (x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0) {
     translate (v=[x, y, z])
	  rotate (a = [ax, ay, az])
	       screw_hole(4.0);
}

// left bracket panel with screw holes
module left_bracket () {
     let (tot_l = B_LENGTH + B_OFFSET_L,
	  off_x = B_LENGTH / 4,
	  off3_x = 3 * B_LENGTH / 4,
	  off_z = B_HEIGHT / 3,
	  off2_z = off_z * 2) {
	  difference () {
	       cube(size = [tot_l, B_THICK, B_HEIGHT], center = false);
	       transrot_screwhole(x = off_x,  y = -EPS, z = off_z,  ax = 90);
	       transrot_screwhole(x = off3_x, y = -EPS, z = off_z,  ax = 90);
	       transrot_screwhole(x = off_x,  y = -EPS, z = off2_z, ax = 90);
	       transrot_screwhole(x = off3_x, y = -EPS, z = off2_z, ax = 90);
	  }
     }
}

// right bracket panel with screw holes
module right_bracket () {
     let (tot_l = B_LENGTH + B_OFFSET_R,
	  off_x = tot_l - B_LENGTH / 4,
	  off3_x = tot_l - 3 * B_LENGTH / 4,
	  off_z = B_HEIGHT / 3,
	  off2_z = off_z * 2) {
	  difference () {
	       cube(size = [tot_l, B_THICK, B_HEIGHT], center = false);
	       transrot_screwhole(x = off_x,  y = -EPS, z = off_z,  ax = 90);
	       transrot_screwhole(x = off3_x, y = -EPS, z = off_z,  ax = 90);
	       transrot_screwhole(x = off_x,  y = -EPS, z = off2_z, ax = 90);
	       transrot_screwhole(x = off3_x, y = -EPS, z = off2_z, ax = 90);
	  }
     }
}

// Raw bracket
module raw_bracket() {
     translate (v = [-B_THICK * (RT2 - 1), -B_THICK, 0]) {
	  rotate(a = [0, 0, -45])
	       translate(v = [-B_LENGTH - B_OFFSET_L, 0, 0])
	            left_bracket ();
	  translate(v = [0, 0, 0])
	       right_bracket ();
     }
     rotate (a = [0, 0, -45])
	  translate (v = [-B_LENGTH - EPS, -EPS, 0])
	       cube (size = [B_LENGTH, H_THICK / RT2, B_HEIGHT],
		     center = false);
     translate (v = [-EPS, EPS, 0])
	  cube (size = [B_LENGTH, H_THICK / RT2, B_HEIGHT], center = false);
}

// Full backet
module bracket () {
     difference () {
	  raw_bracket ();
	  joint () ;
     }
}

// Slopy edge on left if MIRROR = 0 or right if MIRROR = 1
mirror ([MIRROR,0,0])
     bracket();
