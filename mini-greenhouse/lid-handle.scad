// Stops for props

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
T1 = 7.5;
T2 = 6.0;
H1 = 30.0;
H2 = 10.0;
W = 20.0;
D = 4.0;		// Can be overridden from command line.

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

module outline() {
     polygon(points = [[ 0.00,  0.0],
		       [ 5.00,  0.0],
		       [ 5.01,  1.0],
		       [ 5.05,  2.0],
		       [ 5.11,  3.0],
		       [ 5.20,  4.0],
		       [ 5.31,  5.0],
		       [ 5.44,  6.0],
		       [ 5.60,  7.0],
		       [ 5.79,  8.0],
		       [ 6.00,  9.0],
		       [ 6.23, 10.0],
		       [ 6.49, 11.0],
		       [ 6.78, 12.0],
		       [ 7.09, 13.0],
		       [ 7.43, 14.0],
		       [ 7.79, 15.0],
		       [ 8.18, 16.0],
		       [ 8.59, 17.0],
		       [ 9.04, 18.0],
		       [ 9.50, 19.0],
		       [10.00, 20.0],
		       [10.00, 25.0],
		       [ 0.00, 25.0]],
	     convexity = 10);
}

module raw_handle() {
     translate(v = [0, 0, 25.0])
	  rotate(a=[180, 0, 0])
	       rotate_extrude(convexity = 10, $fn = 180)
	            outline();
}

module handle() {
     difference() {
	  raw_handle();
	  transrot_screwhole(d = D, ax = 180);
     }
}

handle();

