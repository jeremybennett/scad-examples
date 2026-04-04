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
BOARD_H = 17.0;
BOARD_T = 10.0;
LIP_H = 20.0;

PROP_T = 6.0;
WASHER_T = 7.5;
BOARD_W = 34.0;

STOP_L = 20.0;

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

module basic_midstop() {
     let(tot_x = BOARD_W + WASHER_T * 2 + PROP_T * 2,
	 tot_z = BOARD_H + BOARD_T) {
	  difference () {
	       cube(size = [tot_x, STOP_L, tot_z], center = false);
	       translate(v = [PROP_T - INF, -INF / 2, tot_z - LIP_H])
		    cube(size = [INF, INF, INF], center = false);
	       translate(v = [tot_x - PROP_T, -INF / 2, tot_z - LIP_H])
		    cube(size = [INF, INF, INF], center = false);
	       translate(v = [PROP_T + WASHER_T, -INF / 2, BOARD_T])
		    cube(size = [BOARD_W, INF, INF], center = false);
	  }
     }
}

module midstop() {
     let(tot_x = BOARD_W + WASHER_T * 2 + PROP_T * 2,
	 tot_z = BOARD_H + BOARD_T) {
	  difference() {
	       basic_midstop();
	       transrot_screwhole(d = D, x = tot_x / 2, y = STOP_L / 2,
				  ax = 180);
	       transrot_screwhole(d = D, x = PROP_T - EPS, y = STOP_L / 2,
				  z = tot_z - LIP_H / 2, ay = -90);
	       transrot_screwhole(d = D, x = tot_x - PROP_T + EPS,
				  y = STOP_L / 2, z = tot_z - LIP_H / 2,
				  ay = 90);
	  }
     }
}

midstop();
