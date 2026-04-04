// Shave stick holder base

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


module base_rim () {
     difference () {
	  cylinder (r = OUTER_R1, h = BASE_THICK + BASE_H,
		    center = false, $fn = 120);
	  cylinder (r = STICK_R, h = BASE_THICK + BASE_H + EPS,
		    center = false, $fn = 120);
     };
}

module base_bottom () {
     cylinder (r = OUTER_R1, h = BASE_THICK,
	       center = false, $fn = 120);
}

module base_flange () {
     difference () {
	  difference () {
	       cylinder (r = OUTER_R2, h = BASE_THICK + BASE_H,
			 center = false, $fn = 120);
	       translate (v = [0, 0, BASE_THICK])
		    cutout ();
	  };
	  cylinder (r = STICK_R + EPS, h = BASE_THICK + BASE_H + EPS,
		    center = false, $fn = 120);
     }
}

module base () {
     base_rim ();
     base_bottom ();
     base_flange ();
}

module fin () {
     hull () {
	  translate (v = [STICK_R + FIN_THICK / 2.0 - FIN_W, 0.0, BASE_THICK - EPS])
	       cube (size = [FIN_THICK, FIN_THICK, FIN_THICK], center = true);
	  translate (v = [STICK_R + FIN_THICK / 2.0, 0.0, BASE_THICK + BASE_H - FIN_THICK / 2.0])
	       cube (size = [FIN_THICK, FIN_THICK, FIN_THICK], center = true);
	  translate (v = [STICK_R + FIN_THICK / 2.0, 0.0, BASE_THICK + EPS])
	       cube (size = [FIN_THICK, FIN_THICK, FIN_THICK], center = true);
     }
}

module base_complete () {
     base ();
     fin ();
     rotate (a = [0.0, 0.0, 90.0])
	  fin ();
     rotate (a = [0.0, 0.0, 180.0])
	  fin ();
     rotate (a = [0.0, 0.0, 270.0])
	  fin ();
}

base_complete ();

