// Top handles

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
R = 1.0;			// Minkowski radius
H1 = 10.0;
H2 = 23.0;
H3 = 10.0;
W1 = 20.0;
W2 = 10.0;
L = 90.0;
A = atan((H2 - H1 - H3) / W1);

D = 4.0;			// Default screw size

// Translate and rotate a screwhole
module transrot_screwhole(d = 4, x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(d, head_clear = head_clear);
}

module basic_block() {
     let(y1 = W1 + W2 - R,
	 y2 = W1 - R,
	 z1 = H1 - R,
	 z2 = H2 - R * 2.0) {
	  difference() {
	       union() {
		    cube(size = [L, y1, z1], center = false);
		    cube(size = [L, y2, z2], center = false);
	       }
	       translate (v = [-EPS, -EPS, z2])
		    rotate(a = [-A, 0, 0])
		         cube(size = [INF, INF, INF], center = false);
	  }
     }
}

module smoothed_block () {
     difference () {
	  minkowski() {
	       translate (v = [R, R, R])
		    basic_block();
	       sphere(r = R, $fn = 60);
	  }
	  translate(v = [-EPS, W1, H1])
	       cube(size = [INF, INF, INF], center = false);
	  translate(v = [-EPS, W1 + W2, -EPS])
	       cube(size = [INF, INF, INF], center = false);
     }
}

module block() {
     let(gap = L / 7.0,
	 x1 = gap * 0.5,
	 x2 = gap * 1.5,
	 x3 = gap * 2.5,
	 x4 = gap * 4.5,
	 x5 = gap * 5.5,
	 x6 = gap * 6.5,
	 y1 = -EPS,
	 y2 = W1 + W2 / 2.0,
	 z1 = H1 + H3 / 2.0) {
	  difference () {
	       smoothed_block();
	       transrot_screwhole(d = D, x = x1, y = y1, z = z1, ax = 90);
	       transrot_screwhole(d = D, x = x2, y = y2, z = -EPS, ax = 180);
	       transrot_screwhole(d = D, x = x3, y = y1, z = z1, ax = 90);
	       transrot_screwhole(d = D, x = x4, y = y1, z = z1, ax = 90);
	       transrot_screwhole(d = D, x = x5, y = y2, z = -EPS, ax = 180);
	       transrot_screwhole(d = D, x = x6, y = y1, z = z1, ax = 90);
	  }
     }
}

block();
