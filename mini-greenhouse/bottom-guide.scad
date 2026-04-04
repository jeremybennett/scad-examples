// Bottom guide

// Copyright(C) 2023 Embecosm Limited(www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Designed to guide the frame on top of the base

include <../lib/screw-hole.scad>

EPS = 0.01;
EPS2 = EPS * 2;
INF = 1000;
RT2 = sqrt(2.0);

// Dimensions
T1 = 7.5;
T2 = 7.5;
T3 = 15.0;
W1 = 10.0;
W2 = 10.0;			// Change this to allow for different spacings.
W3 = 5.0;
L = 50.0;

D = 4.0;			// Default screw size

TEXT_H = 10.0;
TEXT_T = 1.0;

// Translate and rotate a screwhole
module transrot_screwhole(d = 4, x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(d, head_clear = head_clear);
}

module basic_block() {
     let(z1 = W3,
	 z2 = W2 + W3,
	 z3 = W1 + W2 + W3,
	 y1 = T1 + T2 + T3,
	 y2 = T1 + T2) {
	  union() {
	       cube(size = [L, y1, z1], center = false);
	       translate(v = [0, T3, 0])
		    cube(size = [L, y2, z2], center = false);
	       translate(v = [0, T3, 0])
		    cube(size = [L, T1, z3], center = false);
	  }
     }
}

module block() {
     let(x1 = L / 4 - D / 2,
	 x2 = L - x1,
	 x3 = L / 4 + D / 2,
	 x4 = L - x3,
	 x5 = L / 2,
	 y1 = T3 / 2,
	 y2 = T1 + T2 + T3 + EPS,
	 y3 = T3 + TEXT_T - EPS,
	 z1 = W3 + W2 / 2.0,
	 z2 = (W1 + W2) / 2.0 + W3) {
	  difference () {
	       basic_block();
	       transrot_screwhole(d = D, x = x1, y = y1, z = -EPS, ax = 180);
	       transrot_screwhole(d = D, x = x2, y = y1, z = -EPS, ax = 180);
	       transrot_screwhole(d = D, x = x3, y = y2, z = z1, ax = -90);
	       transrot_screwhole(d = D, x = x4, y = y2, z = z1, ax = -90);
	       translate (v = [x5, y3, z2])
		    rotate(a = [90, 0, 0])
			  linear_extrude (height = TEXT_T, slices = 1,
					  center = false)
			       text (str(W2), size = TEXT_H, halign = "center",
				     valign = "center",
				     font = "Arial:style=Bold");
	  }
     }
}

block();
