// Generic clamp for the projector stand

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This fits inside the square to ensure a snug fit on the alumnium tube. This
// is the generic design, with variants for the upper and lower clamp.

// Useful constants
EPS = 0.1;			// Small distance
TUBE_R = 52.2 / 2.0;		// Radius of alumninium tube measured 51.6
SQUARE_L = 53.7;		// Dimensions of the square (nominal 54.0)
SQUARE_W = 53.7;
SQUARE_H = 30.0;
OUTER_ROUND_R = 5.0;		// Curvature of outer edge
INNER_ROUND_R = 2.0;		// Curvature of inner corners
BOLT_OFF = SQUARE_W / 2.0 - 10.0;
HEAD_R = 9.6 / 2.0;		// Screw head face-to-face (nominal 8.0 diameter)
GRUB_R = 3.0 / 2.0;		// Space for grub screw tip

// The basic block with rounded edges from which we cut out everything else.
module big_block () {
     minkowski () {
	  cube (size = [SQUARE_L, SQUARE_W, SQUARE_H], center = true);
	  sphere (r = OUTER_ROUND_R, $fn = 24);
     }
}

// The inner block with rounded corners used to trim the big block
module hollow_block () {
     difference () {
	  translate (v = [0, 0, SQUARE_H / 2])
	       cube (size = [SQUARE_L * 2, SQUARE_W * 2, SQUARE_H * 2],
		     center = true);
	  minkowski () {
	       cube (size = [SQUARE_L - INNER_ROUND_R * 2,
			     SQUARE_W - INNER_ROUND_R * 2, EPS],
		     center = true);
	       cylinder (h = SQUARE_H, r = INNER_ROUND_R, center = true,
			 $fn = 24);
	  }
     }
}

// Cut out the edges and the central hole
module raw_clamp () {
     difference () {
	  big_block ();
	  hollow_block ();
	  cylinder (r = TUBE_R, h = SQUARE_H + OUTER_ROUND_R * 2, center = true,
		    $fn = 120);
     }
}

// The hole in which the nut will fit.
module nut_hole () {
     rotate (a = [90, 0, 0])
	  cylinder (r = HEAD_R, h = SQUARE_W + EPS, $fn = 6, center = true);
}

// The module for the clamp can be generated without the nut holes.
module clamp (make_holes) {
     difference () {
	  raw_clamp ();
	  // Optional Nut holes
	  if (make_holes) {
	       translate (v = [-BOLT_OFF, -SQUARE_W / 2.0, 0])
		    nut_hole ();
	       translate (v = [BOLT_OFF, SQUARE_W / 2.0, 0])
		    nut_hole ();
	       translate (v = [-SQUARE_W / 2.0, BOLT_OFF, 0])
		    rotate (a = [0, 0, -90])
		         nut_hole ();
	       translate (v = [SQUARE_W / 2.0, -BOLT_OFF, 0])
		    rotate (a = [0, 0, -90])
		         nut_hole ();
	  }
	  // Grub screw holes
	  rotate (a = [90, 0, 0])
	       cylinder (r = GRUB_R, h = SQUARE_W, $fn = 42);
	  rotate (a = [-90, 0, 0])
	       cylinder (r = GRUB_R, h = SQUARE_W, $fn = 42);
	  rotate (a = [0, 90, 0])
	       cylinder (r = GRUB_R, h = SQUARE_L, $fn = 42);
	  rotate (a = [0, -90, 0])
	       cylinder (r = GRUB_R, h = SQUARE_L, $fn = 42);
     }
}
