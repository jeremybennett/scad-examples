// Plug cover (CEE 7/7 version)

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A cover for an EU plug, to prevent pins destroying your bag.


EPS = 0.01;			// Very small value
LARGE = 200.0;			// Large dimension

GAP = 0.3;			// Spacing to allow for plastic "bleed"
PIN_R = 4.8 / 2.0 + GAP;
PIN_H = 19.0;
PIN_SPACING = 19.0;
RIDGE_R = 0.4 / 2.0;		// Ridges to grip pins
COVER_R = 37.2 / 2.0;
COVER_H = 30;
SLOT_D = 2.0;
SLOT_W = 4.0;

// Large centered cube for convenience
module large_cube () {
     cube (size = [LARGE, LARGE, LARGE], center = true);
}

// Hemisphere
module hemisphere (radius) {
     difference () {
	  sphere (r = radius, $fn = 180);
	  translate (v = [0, 0, -LARGE / 2.0])
	       large_cube ();
     }
}

// Generic cover hull
module generic_cover (rad, cyl_h) {
     union () {
	  translate (v = [0, 0, cyl_h - EPS])
	       hemisphere (rad);
	  cylinder (r = rad, h = cyl_h, $fn = 180);
     }
}

// A ridge on a pin
module ridge () {
     hull () {
	  translate (v = [PIN_R + RIDGE_R, 0, -EPS])
	       cylinder (r = RIDGE_R, h = EPS, center = false);
	  translate (v = [PIN_R, 0, PIN_H])
	       cylinder (r = RIDGE_R, h = EPS, center = false);
     }
}

// A single pin. The basic hole, but with ridges for tightness
module pin () {
     difference () {
	  cylinder (r = PIN_R, h = PIN_H, center = false, $fn = 24);
	  ridge ();
	  rotate (a = [0, 0, 120])
	       ridge ();
	  rotate (a = [0, 0, 240])
	       ridge ();
     }
}

// Both pins
module pins () {
    translate (v = [0, -PIN_SPACING / 2, 0 - EPS])
        pin ();
    translate (v = [0, PIN_SPACING / 2, 0 - EPS])
        pin ();
}


// Slot for rubber band
module slot () {
     difference () {
	  cube (size = [LARGE, SLOT_W, LARGE], center = true);
	  generic_cover (COVER_R - SLOT_D, COVER_H - SLOT_D - COVER_R);
     }
}


module plug_cover () {
    difference () {
	 generic_cover (COVER_R, COVER_H - COVER_R);
	 pins ();
	 slot ();
    }
}


plug_cover ();
