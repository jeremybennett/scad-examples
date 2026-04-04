// Shave stick holder cap

// Copyright (C) 2023 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// A simple holder with cover for Arko shaving soap sticks.  These soap sticks
// are approximately 82mm long and 33mm in diameter.

// Common definitions
include <shave.scad>


module inverse_cutout () {
     cylinder (r = OUTER_R1 + SPACE, h = BASE_H, center = false, $fn = 120);
     difference () {
	  cylinder (r = OUTER_R2 + EPS, h = BASE_H, center = false, $fn = 120);
	  difference () {
	       translate (v = [0, 0, -EPS])
		    cylinder (r = OUTER_R2 + EPS, h = BASE_H + 2 * EPS,
			      center = false, $fn = 120);
	       translate (v = [0, 0, 0])
		    minkowski () {
		         cutout ();
			 // There is a bug in OpenScad with 10 as the multiplier
		         cylinder (r = SPACE * 10.1, h = EPS);
	            }
	  };
     }
}

module cap_rim () {
     difference () {
	  cylinder (r = OUTER_R2, h = CAP_THICK + CAP_H,
		    center = false, $fn = 120);
	  cylinder (r = OUTER_R1 + SPACE, h = CAP_THICK + CAP_H + EPS,
		    center = false, $fn = 120);
	  translate (v = [0, 0, CAP_THICK + CAP_H + EPS - BASE_H])
	       inverse_cutout ();
     };
}

module cap_top () {
     cylinder (r = OUTER_R2, h = CAP_THICK,
		    center = false, $fn = 120);
}

module cap () {
     intersection () {
	  union () {
	       cap_rim ();
	       cap_top ();
	  };
	  translate (v = [0, 0, INF / 2.0])
	       cube (size = [INF, INF, INF], center = true);
     }
}

cap ();
