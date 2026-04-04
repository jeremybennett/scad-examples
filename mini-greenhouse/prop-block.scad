// Clips for top of props

// Copyright(C) 2023 Embecosm Limited(www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// For accurate marking out of the prop ends

include <../lib/screw-hole.scad>

EPS = 0.01;
EPS2 = EPS * 2;
INF = 1000;
RT2 = sqrt(2.0);

// Dimensions
SLOT_T = 6.0;		// Slot thickness
SLOT_D = 20.0;		// Slot diameter
WALL_T = 3.0;		// Wall thickness
SCREW_D = 3.0;		// Can be overridden from command line.

// Clearances for holes
CLEARANCE_TIGHT = 0.1;
CLEARANCE_LOOSE = 0.2;

function tight_rad(r) = r + CLEARANCE_TIGHT;
function tight_diam(d) = d + CLEARANCE_TIGHT * 2;
function loose_rad(r) = r + CLEARANCE_LOOSE;
function loose_diam(d) = d + CLEARANCE_LOOSE * 2;

// Map hex head from the width of the hexagon.  The formula is
//   d = 2 * w / sqrt(3)
// Where w is the width of the hexagon and d is the diameter of the
// circumcircle.
function hex_head_diam(hex_w) =
     hex_w * 2.0 / sqrt(3.0);

// Translate and rotate a screwhole
module transrot_screwhole(d = 4, x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(d, head_clear = head_clear);
}

// Basic 90 degree receptacle
module basic_receptacle() {
     let(t = SLOT_T + WALL_T * 2.0,
	 d = SLOT_D + WALL_T * 2.0) {
	  difference() {
	       cylinder(d = d, h = t, $fn = 128, center = false);
	       cylinder(r = SCREW_D, h = INF, $fn = 48, center = true);
	       translate(v = [0, 0, WALL_T])
		    cylinder(d = SLOT_D, h = SLOT_T, $fn = 128, center = false);
	       translate(v = [0, -INF / 2, -INF / 2])
		    cube(size = [INF, INF, INF], center = false);
	  }
     }
}

// Receptable at various angles with base with screwholes
module receptacle(a = 90) {
     let(base_len = SLOT_D + WALL_T * 2.0 + SCREW_D * 6,
	 screw_off = base_len / 2.0 - SCREW_D * 1.5,
	 yoff = SLOT_T / 2 + WALL_T,
	 zoff = SLOT_D / 2 + WALL_T) {
	  difference () {
	       union () {
		    translate(v = [0, yoff, zoff])
			 rotate(a = [90, 0, 0])
	                      rotate(a = [0, 0, 180 - a])
	                           basic_receptacle();
		    translate (v = [-base_len / 2, -yoff, 0])
			 cube(size = [base_len, yoff * 2.0, WALL_T]);
	       }
	       transrot_screwhole(d = SCREW_D, x = screw_off,
				  z = WALL_T + EPS);
	       transrot_screwhole(d = SCREW_D, x = -screw_off,
				  z = WALL_T + EPS);
	  }
     }
}

receptacle(57.44);
