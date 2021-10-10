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
SCREW_R = 4.0 / 2.0;		// Assume 4mm screw clearance
GRUB_R = 2.0 / 2.0;		// Space for grub screw tip

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

difference () {
     raw_clamp ();
     // Bolt holes
     translate (v = [-BOLT_OFF, 0, 0])
	  rotate (a = [90, 0, 0])
	      cylinder (r = SCREW_R, h = SQUARE_W, $fn = 42);
     translate (v = [BOLT_OFF, 0, 0])
	  rotate (a = [-90, 0, 0])
	      cylinder (r = SCREW_R, h = SQUARE_W, $fn = 42);
     translate (v = [0, -BOLT_OFF, 0])
	  rotate (a = [0, 90, 0])
	      cylinder (r = SCREW_R, h = SQUARE_L, $fn = 42);
     translate (v = [0, BOLT_OFF, 0])
	  rotate (a = [0, -90, 0])
	      cylinder (r = SCREW_R, h = SQUARE_L, $fn = 42);
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
