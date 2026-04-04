// Sideways Label plate

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

// Plate dimensions
W = 30.0;
H = 20.0;
T = 5.0;

// Text dimensions
TEXT_H = 10.0;
TEXT_T = 1.0;
TEXT = "A";			// Default, overridden from the command line.

// Screwhole diamter
D = 3.0;			// Default, overridden from the command line.

// Translate and rotate a screwhole
module transrot_screwhole(d = 4, x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(d, head_clear = head_clear);
}

// Basic block with no text
module basic_block() {
     let (y_off = H / 2.0,
	  x_off1 = (W - TEXT_H) / 4.0,
	  x_off2 = W - x_off1,
	  z_off = T + EPS) {
	       difference() {
		    cube(size = [W, H, T], center = false);
		    transrot_screwhole(d = D, x = x_off1, y = y_off,
				       z = z_off);
		    transrot_screwhole(d = D, x = x_off2, y = y_off,
				       z = z_off);
	       }
     }
}

// Block with text
module block() {
     let (x_off = W / 2.0,
	  y_off = H / 2.0,
	  z_off = T - TEXT_T + EPS) {
	  difference() {
	       basic_block();
	       translate (v = [x_off, y_off, z_off])
		    linear_extrude (height = TEXT_T, slices = 1, center = false)
		         text (TEXT, size = TEXT_H, halign = "center",
			       valign = "center", font = "Arial:style=Bold");
	  }
     }
}

block();
