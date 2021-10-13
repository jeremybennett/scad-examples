// Clamp for the projector stand

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This fits inside the square to ensure a snug fit on the alumnium tube.

// Useful constants
EPS = 0.1;			// Small distance
TUBE_R = 52.2 / 2.0;		// Radius of alumninium tube measured 51.6
SQUARE_L = 54.0;		// Dimensions of the square
SQUARE_W = 54.0;
SQUARE_H = 30.0;
ROUND_R = 5.0;			// Curvature of edge
BOLT_OFF = SQUARE_W / 2.0 - 10.0;
HEAD_R = 8.6 / 2.0;		// Screw head face-to-face (nominal 8.0 diameter)
HEAD_H = 4.3 / 2.0;		// Screw head thickness (nominal 4.0)
GRUB_R = 3.0 / 2.0;		// Space for grub screw tip

// The basic block with rounded edges from which we cut out everything else.
module block () {
     minkowski () {
	  cube (size = [SQUARE_L, SQUARE_W, SQUARE_H], center = true);
	  sphere (r = ROUND_R, $fn = 24);
     }
}

// Cut out the edges and the central hole
module raw_clamp () {
     difference () {
	  block ();
	  translate (v = [SQUARE_L, 0, ROUND_R]) 
	       cube (size = [SQUARE_L, SQUARE_W * 2, SQUARE_H + ROUND_R * 2],
		     center = true);
	  translate (v = [-SQUARE_L, 0, ROUND_R]) 
	       cube (size = [SQUARE_L, SQUARE_W * 2, SQUARE_H + ROUND_R * 2],
		     center = true);
	  translate (v = [0, SQUARE_W, ROUND_R]) 
	       cube (size = [SQUARE_L * 2, SQUARE_W, SQUARE_H + ROUND_R * 2],
		     center = true);
	  translate (v = [0, -SQUARE_W, ROUND_R]) 
	       cube (size = [SQUARE_L * 2, SQUARE_W, SQUARE_H + ROUND_R * 2],
		     center = true);
	  translate (v = [0, 0, SQUARE_H]) 
	       cube (size = [SQUARE_L * 2, SQUARE_W * 2, SQUARE_H],
		     center = true);
	  cylinder (r = TUBE_R, h = SQUARE_H + ROUND_R * 2, center = true,
		    $fn = 120);
     }
}

// The slot in which the nut will fit.
module nut_slot () {
     hull () {
	  rotate (a = [90, 0, 0])
	       cylinder (r = HEAD_R, h = HEAD_H + EPS, $fn = 6, center = true);
	  translate (v = [0, 0, SQUARE_H])
	       rotate (a = [90, 0, 0])
	            cylinder (r = HEAD_R, h = HEAD_H + EPS, $fn = 6,
			      center = true);
     }
}

// The module for the clamp can be generated without the nut slots.
module clamp (make_slots) {
     difference () {
	  raw_clamp ();
	  // Optional Nut slots
	  if (make_slots) {
	       translate (v = [-BOLT_OFF, (-SQUARE_W + HEAD_H) / 2.0, 0])
		    nut_slot ();
	       translate (v = [BOLT_OFF, (SQUARE_W - HEAD_H) / 2.0, 0])
		    nut_slot ();
	       translate (v = [(-SQUARE_W + HEAD_H) / 2.0, BOLT_OFF, 0])
		    rotate (a = [0, 0, -90])
		         nut_slot ();
	       translate (v = [(SQUARE_W - HEAD_H) / 2.0, -BOLT_OFF, 0])
		    rotate (a = [0, 0, -90])
		         nut_slot ();
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

// Generate a clamp with nut slots
clamp (true);
