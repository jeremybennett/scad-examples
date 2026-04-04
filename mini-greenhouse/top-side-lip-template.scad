// template for top side lip

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

L = 55.0;
H = 5.0;
W = 20.0;
LIP_H = H * 2;
LIP_W = 3.0;

// Translate and rotate a screwhole
module transrot_screwhole(d = 4, x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(d, head_clear = head_clear);
}

module basic_block() {
     union() {
	  cube(size = [L, W, H], center = false);
	  translate(v = [0, W - EPS, -H])
	       cube(size = [L, LIP_W, LIP_H], center = false);
     }
}

module block() {
     rotate(a = [180, 0, 0])
	  difference() {
	       basic_block();
	       transrot_screwhole(x = W / 2, y = W / 2, z = H + EPS);
	       transrot_screwhole(x = L - W / 2, y = W / 2, z = H + EPS);
	  }
}

block();
