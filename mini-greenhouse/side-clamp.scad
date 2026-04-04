// Side clamp

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

// Bolt dimensions
BOLT_D = 5.0;
BOLT_HEAD_W = 8.0;
BOLT_HEAD_T = 3.6;

// Clamp dimensions
C_HEIGHT = 15.0;
C_LENGTH = 30.0;
C_WIDTH = 25.0;

// Clearances for holes
CLEARANCE_TIGHT = 0.1;
CLEARANCE_LOOSE = 0.2;

function tight_rad(r) = r + CLEARANCE_TIGHT;
function tight_diam(d) = d + CLEARANCE_TIGHT * 2;
function loose_rad(r) = r + CLEARANCE_LOOSE;
function loose_diam(d) = d + CLEARANCE_LOOSE * 2;

// Map hex head from the width of the hexagon.  The formula is
//   d = 2.w / sqrt(3)
// Where w is the width of the hexagon and d is the diameter of the
// circumcircle.
function hex_head_diam(hex_w) =
     hex_w * 2.0 / sqrt(3.0);

// Map clearance hole
module raw_bracket() {
     cube(size=[C_LENGTH, C_WIDTH, C_HEIGHT], center = false);
}

// Bolt hole with head socket
module bolt_hole_socketed() {
     rotate(a = [180, 0, 0])
	  union() {
	       translate(v = [0, 0, BOLT_HEAD_T / 2.0])
		    cylinder(r = tight_diam(hex_head_diam(BOLT_HEAD_W)) / 2.0,
			     h = BOLT_HEAD_T, $fn = 6, center = true);
	       translate(v = [0, 0, INF / 2.0])
		    cylinder(r = tight_diam(BOLT_D) / 2.0, h = INF, $fn = 36,
			     center = true);
     }
}

// Bolt hole without head socket
module bolt_hole() {
     rotate(a = [180, 0, 0])
	  translate(v = [0, 0, INF / 2.0])
	       cylinder(r = tight_diam(BOLT_D) / 2.0, h = INF, $fn = 36,
			center = true);
}

// Translate and rotate a screwhole
module transrot_screwhole(x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(4.0);
}

// Bracket with socketed head
module screwed_bracket() {
     difference() {
	  raw_bracket();
	  transrot_screwhole(x = C_LENGTH / 6, y = -EPS, z = C_HEIGHT / 2,
			     ax = 90);
	  transrot_screwhole(x = C_LENGTH * 5 / 6, y = -EPS, z = C_HEIGHT / 2,
			     ax = 90);
     }
}

// Bracket with socketed head
module bracket_socketed() {
     difference() {
	  screwed_bracket();
	  translate(v = [C_LENGTH / 2, C_WIDTH / 2, C_HEIGHT + EPS])
	       bolt_hole_socketed();
     }
}

// Bracket
module bracket() {
     difference() {
	  screwed_bracket();
	  translate(v = [C_LENGTH / 2, C_WIDTH / 2, C_HEIGHT + EPS])
	       bolt_hole();
     }
}

if (DO_SOCKET)
     bracket_socketed();
else
     bracket();
