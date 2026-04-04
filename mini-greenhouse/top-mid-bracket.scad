// Frame top mid bracket

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

VFRAME_W = 17.0;
FRAME_T = 10.0;
CORNER_HYP = 96.0;
CORNER_SIDE = CORNER_HYP / RT2;

BRACE_T = 17.0;
BRACE_W = 34.0;
BRACE_L = 0;
WALL_T = 5.0;

// Translate and rotate a screwhole
module transrot_screwhole(x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0,
			  head_clear = 0) {
     translate(v=[x, y, z])
	  rotate(a = [ax, ay, az])
	       screw_hole(4.0, head_clear = head_clear);
}

// Generic right-angle triangular prism.  Specify the two short sides and the
// height.
module rh_triangle(s1, s2, h, center = false) {
     linear_extrude(height = h, convexity = 10, center = center)
	  polygon(points = [[0, 0], [0, s1], [s2, 0]], convexity = 10);
}

module tri_support() {
     let (h = CORNER_SIDE - VFRAME_W,
	  s = h * RT2) {
	  translate(v = [0, h, -FRAME_T])
	       rotate(a = [0, 0, -135])
	            rh_triangle(s, s, FRAME_T);
     }
}

module brace_support() {
     let (w = BRACE_W + WALL_T * 2.0,
	  h = BRACE_T + WALL_T,
	  l = CORNER_SIDE - VFRAME_W - w / 2) {
	  difference() {
	       translate(v = [-w / 2, 0, -h])
		    cube(size = [w, l, h], center = false);
	       translate(v = [-BRACE_W / 2, -INF / 2, EPS - BRACE_T])
		    cube(size = [BRACE_W, INF, BRACE_T], center = false);
	  }
     }
}

module brace() {
     let (w = BRACE_W + WALL_T * 2.0,
	  h = BRACE_T + WALL_T) {
	  union() {
	       difference() {
		    tri_support();
		    translate(v = [-w / 2, -INF /2, EPS - h])
			 cube(size = [w, INF, h]);
	       }
	       brace_support();
	  }
     }
}

module screwholes() {
     let (x_off = BRACE_W / 2.0 + WALL_T,
	  x_gap = CORNER_HYP / 2.0 - x_off,
	  l = CORNER_SIDE - VFRAME_W - x_off) {
	  echo (x_off, x_gap);
	  transrot_screwhole(x = -x_off - x_gap / 2, y = l / 2 - 2,
			     z = -FRAME_T / 2, ax = -90, head_clear = INF);
	  transrot_screwhole(x = -x_off - 4, y = 4.5,
			      z = -FRAME_T - EPS, ax = 180);
	  transrot_screwhole(x = x_off + x_gap / 2, y = l /2 - 2,
			     z = -FRAME_T / 2, ax = -90, head_clear = INF);
	  transrot_screwhole(x = x_off + 4, y = 4.5,
			      z = -FRAME_T - EPS, ax = 180);
     }
}

module screwed_brace() {
     difference() {
	  brace();
	  screwholes();
     }
}

module printable_screwed_brace() {
     rotate(a = [90, 0, 0])
	  screwed_brace();
}

printable_screwed_brace();
