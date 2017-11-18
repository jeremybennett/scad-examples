// Spacer for furniture

// Copyright (C) 2017 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// Designed to go under feet of desks/drawers where more spacing than the
// standard is needed.

EPS = 0.01;			// Small space

// Parameterize the space needed

FOOT_D = 50;			// How wide is the foot
SPACE = 13;			// How much spacing do we need?

// Generically parameterize the spacer

RIM_W = 5;			// How wide a rim round the foot
RIM_H = 10;			// How high a rim?
R = 2;				// Radius for rounding


// The basic shape.

module raw_spacer () {
     difference () {
	  cylinder (r = FOOT_D / 2 + RIM_W - R,
		    h = (RIM_H + SPACE - R) * 2,
		    $fn = 90, center = true);
	  translate (v = [0, 0, SPACE - R])
	       cylinder (r = FOOT_D / 2 + R, h = 100, $fn = 90, center = false);
     }
}

module rounded_spacer () {
     minkowski () {
	  raw_spacer ();
	  sphere (r = R, $fn = 12);
     }
}

module spacer () {
     intersection () {
	  rounded_spacer ();
	  translate (v = [0, 0, 50])
	       cube (size = [100, 100, 100], center = true);
     }
}

spacer ();
