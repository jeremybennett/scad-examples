// Plug cover (US version)

// Copyright (C) 2015-2017 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A cover for an US plug, to prevent pins destroying your bag.


// Very small value

EPS = 0.01;

// Diameter overall

D = 38;

// Height overall

H = 20;

// Rounding

ROUND = 5;

// Slot depth and width

SDEPTH = 3;
SWIDTH = 4;


// Generic dome used for the cover

module dome (rin, hin) {
     intersection ()
     {
	  minkowski () {
	       cylinder (r = rin - ROUND, h = (hin - ROUND) * 2 , center = true,
			 $fn = 60);
	       sphere (r = ROUND, center = true, $fn = 60);
	  }
	  translate (v = [-50, -50, 0])
	       cube (size = [100,100,50], center = false);
     }
}


// Slot for a rubber band

module slot () {
     intersection () {
	  difference () {
	       dome (D / 2 + EPS, H + EPS);
	       dome (D / 2 - SDEPTH, H - SDEPTH);
	  }
	  cube (size = [100, SWIDTH, 100], center = true);
     }
}


// A single pin - allow 0.4mm space each side for easy sliding in.

module pin (pin_x, pin_y, pin_z) {
     translate (v = [0, 0, pin_z / 2])
	  cube  (size = [pin_x, pin_y, pin_z], center = true);
}


// Both pins. Pins are 6.5 x 1.5 x 15.9. Allow 0.4mm clearance each side and
// 2mm at the hole bottom. Pin centres are 12.7 appart.

module pins () {
    hole_x = 6.5 + 0.4 * 2;
    hole_y = 1.5 + 0.4 * 2;
    hole_height = 15.9 + 2.0;
    hole_gap = 12.7;
    translate (v = [0, -hole_gap / 2, 0 - EPS])
        pin (hole_x, hole_y, hole_height);
    translate (v = [0,  hole_gap / 2, 0 - EPS])
        pin (hole_x, hole_y, hole_height);
}


module plug_cover () {
    difference () {
	dome (D/2, H);
	pins ();
	slot ();
    }
}

plug_cover ();

