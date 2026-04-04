// template for top corner lip

// Copyright(C) 2024 Embecosm Limited(www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Designed to hold the corners together and provide a projection to locate
// the top.

include <../lib/screw-hole.scad>

EPS = 0.01;
EPS2 = EPS * 2;
INF = 500;
RT2 = sqrt(2.0);

SHORT_L = 55.0;
H = 5.0;
W = 20.0;
A = 22.5;

// Translate and rotate a screwhole
module transrot_screwhole(d = 4, x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(d, head_clear = head_clear);
}

// Compute the coordinates of the incircle given three points
function incircle(p1, p2, p3) =
     let(a = W, b = W / cos(A), c = W, s = a + b + c)
          [(a * p1[0] + b * p2[0] + c * p3[0]) / s,
	   (a * p1[1] + b * p2[1] + c * p3[1]) / s];

module basic_block() {
     difference() {
	  translate(v = [-SHORT_L * 2, 0, 0])
	       cube(size = [SHORT_L * 4, W, H], center = false);
	  rotate(a = [0, 0, A])
	       translate(v = [-INF / 2, 0, 0])
	            cube(size = [INF, INF, INF], center = true);
	  translate(v = [SHORT_L, 0, 0])
	       rotate(a = [0, 0, -A])
	            translate(v = [INF / 2, 0, 0])
	                 cube(size = [INF, INF, INF], center = true);
     }
}

module block() {
     let(off = W / cos(A),
	 p1 = [-off, W],
	 p2 = [W, W],
	 p3 = [0, 0],
	 ic1 = incircle(p1, p2, p3),
	 p4 = [SHORT_L + off, W],
	 p5 = [SHORT_L - W, W],
	 p6 = [SHORT_L, 0],
	 ic2 = incircle(p4, p5, p6)) {
	  difference() {
	       basic_block();
	       transrot_screwhole(x = ic1[0], y = ic1[1], z = H + EPS);
	       transrot_screwhole(x = ic2[0], y = ic2[1], z = H + EPS);
	  }
     }
}

block();
