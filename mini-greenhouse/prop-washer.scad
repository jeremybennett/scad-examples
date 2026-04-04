// Washer to space out the prop

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
WASHER_T = 7.7;		// Washer thickness
WASHER_D = 20.0;	// Was
SCREW_D = 4.0;		// Screw hole diameter

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

module washer() {
     difference() {
	  cylinder(d = WASHER_D, h = WASHER_T, $fn = 180, center = false);
	  cylinder(d = loose_diam(SCREW_D), h = INF, $fn = 48, center = true);
     }
}

washer();
