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
D = 3.5;		// Can be overridden from command line.

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

module stop() {
     let() {
	  difference () {
	       union () {
		    cube(size = [W, H1, T1], center = false);
		    cube(size = [W, H2, T1 + T2]);
	       }
	       transrot_screwhole(d = D, x = W / 4, y = H1 - W / 4,
				  z = T1 + EPS);
	       transrot_screwhole(d = D, x = W * 3 / 4, y = H2 + W / 4,
				  z = T1 + EPS);
	  }
     }
}


stop();
