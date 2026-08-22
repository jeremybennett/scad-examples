// Header for the power block stand

// Copyright (C) 2026 Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

include <../lib/screw-hole.scad>

EPS =   0.01;			// Very small value
INF = 500.00;			// Very large value
RT2 = sqrt(2.0);

// Control parameters
DO_GUIDE = false;

// Defining parameters
TOP_W = 150.0;			// Size of the top board
BOARD_W = 64.0;			// Width of the main boards
BOARD_T = 14.5;			// Thickness of the main boards
BOARD_R = 2.5;			// Radius of chamfer
A = 60;				// Angle of the struts
W = BOARD_W / sin(A);
T = 5.0;			// Thickness of lip etc
H = 20.0;
D = 3.0;			// M3 bolts
PAN_D = 6.0;			// Diameter of pan heads
PAN_T = 2.3;			// Thickness of pan heads
HEX_D = 6.0;			// Diameter of M3 nuts
HEX_T = 2.3;			// Thickness of M3 nuts
GAP = 0.2;			// Gap around nuts

BAR_L = (TOP_W + BOARD_W) / 2.0 - T; // Length of the top bars

module angle_cutout() {
     let (w = BOARD_W - BOARD_R * 2.0,
	  t = BOARD_T - BOARD_R * 2.0) {
	  difference() {
	       rotate(a = [0, 90 - A, 0])
		    minkowski() {
	                 cube(size = [w , t, INF], center = true);
			 cylinder(r = BOARD_R, h = INF, $fn = 36,
				  center = true);
	            }
	       translate(v = [0, 0, INF / 2.0])
		    cube (size = [INF, INF, INF], center = true);
	  }
     }
}

module hex_head_hole() {
     union() {
	  cylinder(h = HEX_T + GAP, d = HEX_D + GAP * 2.0, $fn = 6,
		   center = false);
	  cylinder(h = INF, d = D + GAP * 2.0, $fn = 24, center = false);
     }
}

module raw_edge () {
     translate(v = [BOARD_W / 2.0 - BAR_L - T, -T - BOARD_W / 2.0, 0])
	  union() {
	       difference () {
	            cube(size=[BAR_L, T * 2.0, H + T], center = false);
	            translate(v = [-EPS, -EPS, - INF / 2])
		         cube(size=[BAR_L - W - H / tan(A), T, INF],
			      center = false);
	            translate(v = [BAR_L - W / 2.0, T - BOARD_T / 2.0, H])
		         angle_cutout();
	            translate(v = [BAR_L - BOARD_W / 2.0, T * 2.0 + EPS, H / 2])
		         rotate(a = [90, 0, 0])
		              hex_head_hole();
	       }
	       let(l = BAR_L - W - H / tan(A),
		   w = HEX_D * 2.0) {
		    difference () {
			 translate(v = [0, EPS + T - w, H])
			      cube(size = [l, w, T]);
			 translate(v = [l / 2, T - HEX_D, H - EPS])
			      hex_head_hole();
		    }
	       }
     }
}

module vert_holes() {
     let(off = BOARD_W / 2.0 - T * 2.0) {
	  for(x = [-off, off])
	       for(y  = [-off, off])
		    translate(v = [x, y, H - EPS])
			 hex_head_hole();
     }
}


module raw_block() {
     let(w1 = BOARD_W + T * 2.0,
	 w2 = BOARD_W - T * 2.0,
	 w3 = w2 - T * 2.0) {
	  union() {
	       difference() {
		    translate(v = [-BOARD_W / 2.0, - BOARD_W / 2.0, H])
			 cube(size = [BOARD_W, BOARD_W, T], center = false);
		    cylinder(d = BOARD_W - T * 4.0, h = INF, $fn = 120,
			     center = true);
		    vert_holes();
	       }
	       for(rot = [0, 90, 180, 270])
		    rotate(a = [0, 0, rot])
			 raw_edge();
	  }
     }
}


module final_block() {
     rotate(a = [180, 0, 0])
	  raw_block();
}

module guide() {
     rotate(a = [-90, 0, 0])
	  translate(v = [T + BAR_L - BOARD_W / 2, (BOARD_W - T) / 2.0, -H / 2.0])
	       raw_edge ();
}

module final_guide() {
     let(l = BAR_L - W - H / tan(A)) {
	  difference () {
	       guide();
	       translate(v = [l + EPS - INF / 2, 0, 0])
		    cube(size = [INF, INF, INF], center = true);
	  }
     }
}

if (DO_GUIDE) {
     final_guide();
} else {
     final_block();
}
