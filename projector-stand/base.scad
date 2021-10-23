// Base for the projector stand

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This is fixed to the base to anchor the stand.

// Useful constants
include <constants.scad>

// Screws
include <screw-hole.scad>

// Flat base
module flange () {
     intersection () {
	  minkowski () {
	       cylinder (r = BASE_R - OUTER_ROUND_R,
			 h = EPS,
			 center = true, $fn = 120);
	       sphere (r = OUTER_ROUND_R, $fn = 24);
	       }
	  translate (v = [0, 0, BASE_R / 2.0])
	       cube (size = [BASE_R * 4, BASE_R * 4, BASE_R], center = true);
     }
}

module base_block () {
     flange ();
     cylinder (r = TUBE_R + BASE_W, h = BASE_H * 2, center = false, $fn = 120);
}

difference () {
     base_block ();
     cylinder (r = TUBE_R, h = BASE_H * 10, center = true, $fn = 120);
     rotate (a = [0, 0, 0])
	  translate (v = [(TUBE_R + BASE_W + BASE_R - OUTER_ROUND_R) / 2.0,
			  0.0, OUTER_ROUND_R + EPS])
	       screw_hole (4.0, true);
     rotate (a = [0, 0, 120])
	  translate (v = [(TUBE_R + BASE_W + BASE_R - OUTER_ROUND_R) / 2.0,
			  0.0, OUTER_ROUND_R + EPS])
	       screw_hole (4.0, true);
     rotate (a = [0, 0, 240])
	  translate (v = [(TUBE_R + BASE_W + BASE_R - OUTER_ROUND_R) / 2.0,
			  0.0, OUTER_ROUND_R + EPS])
	       screw_hole (4.0, true);
}
