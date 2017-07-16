// Configurable laptop stand

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// Measure the laptop thickness from the desk to the flat with the laptop
// open.

LAPTOP_T = 22;

// Thickness of the wall

T = 3.0;

// Degree of rounding of the inner edges

INNER_R = 1.5;

// Degree of rounding of the outer edges

OUTER_R = INNER_R + T;

// Angle of the stand

A = 60.0;

// Breadth of the stand, which since we are printing on our side is the height
// of the print.

H = 20;

// Length of the face.  This is the longest part of the stand, so limited by
// the printer.

F = 200.0;

// Other edges, base and back

BASE = F * cos (A);
BACK = F * sin (A);

// Block outline of main stand part

module main_block () {
     a = A / 2.0;
     b = (90 - A) / 2;
     y1 = OUTER_R;
     x1 = y1 / tan (a);
     y2 = OUTER_R;
     x2 = BASE - OUTER_R;
     y3 = BACK - OUTER_R / tan (b);
     x3 = x2;
     hull () {
	  translate (v = [x1, y1, 0])
	       cylinder (r = OUTER_R, h = H, center = false, $fn = 24);
	  translate (v = [x2, y2, 0])
	       cylinder (r = OUTER_R, h = H, center = false, $fn = 24);
	  translate (v = [x3, y3, 0])
	       cylinder (r = OUTER_R, h = H, center = false, $fn = 24);
     }
}


// Lower hole

module lo_hole () {
     a = A / 2.0;
     b = (90 - A) / 2;
     y1 = OUTER_R;
     x1 = y1 / tan (a);
     y2 = OUTER_R;
     x2 = BASE + (T / 2 * sin (A)) - OUTER_R / tan (a);
     y3 = BACK - OUTER_R / tan (b);
     x3 = x2;
     hull () {
	  translate (v = [x1, y1, -H])
	       cylinder (r = INNER_R, h = 3 * H, center = false, $fn = 24);
	  translate (v = [x2, y2, -H])
	       cylinder (r = INNER_R, h = 3 * H, center = false, $fn = 24);
	  translate (v = [x3, y3, -H])
	       cylinder (r = INNER_R, h = 3 * H, center = false, $fn = 24);
     }
}


// The complete stand

module stand () {
     difference () {
	  main_block ();
	  lo_hole ();
     }
}


stand ();

