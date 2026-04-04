// Prop template

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
PROP_W = 20.0;		// Prop width
GUIDE_T = 1.0;		// Thickness of the guide
LUG_T = 1.0;		// Thickness of the lugs
LUG_H = 2.0;		// Length of the lugs
SCREW_D = 4.0;		// Screw hole diameter

// Controls
SIDES = true;
END = true;

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

module guide() {
     let(d = PROP_W,
	 r = d / 2.0,
	 lug_h = LUG_H + GUIDE_T,
	 lug_off = LUG_T - EPS,
	 end_len = d + 2.0 * LUG_T - EPS2) {
	  difference() {
	       union () {
		    translate(v = [r, r, 0])
			 cylinder(r = r, h = GUIDE_T, $fn = 180,
				  center = false);
		    cube(size=[r, d, GUIDE_T], center = false);
		    if (SIDES) {
			 translate(v = [0, -lug_off, 0])
			      cube(size = [d, LUG_T, lug_h], center = false);
			 translate(v = [0, d - EPS, 0])
			      cube(size = [d, LUG_T, lug_h], center = false);
		    }
		    if (END) {
			 translate(v = [d - EPS, -lug_off, 0])
			      cube(size = [LUG_T, end_len, lug_h],
				   center = false);
		    }
	       }
	       translate(v = [r, r, 0])
		    cylinder(r = SCREW_D / 2.0, h = INF, $fn = 48,
			     center = true);
	  }
     }
}

guide();
