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

// Angle of the stand, plus it opposite angle

A = 60.0;
B = 90.0 - A;

// Breadth of the stand, which since we are printing on our side is the height
// of the print.

H = 20;

// Length of the face.  This is the longest part of the stand, so limited by
// the printer.

F = 200.0;

// Other edges, base and back

BASE = F * cos (A);
BACK = F * sin (A);

// Various lines of use to us

//   Face:                 y = tan (A) * x + 0
//   Inside face by w:     y = tan (A) * x - w / cos A
//   Base:                 y = 0
//   Inside base by w:     y = w
//   Back:                 x = F * cos (A)
//   Inside back by w:     x = F * cos (A) - w
//   Mid split:            y = -tan (A) * x + f * sin (A)
//   Below mid-split by w: y = -tan A() * x + f * sin (A) - w / cos (A)
//   Above mid-split by w: y = -tan A() * x + f * sin (A) + w / cos (A)

// Solving gives us the following useful intersections for offset lines:

// Face (w) & base (w): (w / tan (A / 2), w)

// Back (w) & base (w): (F * cos (A) - w, w)

// Face (w) & back (w): (F * cos (A) - w, F * sin (A) - w / tan (B / 2)

// Mid-split (+w1) & base (w2): (1 / tan (A) * (F * sin (A) + w1 / cos (A)
//                                              - w2), w2)

// Mid-split (+w1) & face (w2): (1/2 * (F * cos (A) + (w1 - w2)
//                                                 / (tan (A) * cos (A))),
//                               1/2 * (F * sin (A) - (w1 + w2 * (1 - tan (A)))
//                                                  / cos (A)))

// Mid-split (-w1) & face (w2): (1/2 * (F * cos (A) - (w1 + w2)
//                                                 / (tan (A) * cos (A))),
//                               1/2 * (F * sin (A) + (w1 - w2 * (1 - tan (A)))
//                                                  / cos (A)))

// Mid-split (-w1) & back (w2): (F * cos (A) - w2, (w2* sin (A) + w1) / cos (A))


// Function to compute intersection of 2 lines

//   y = m1 * x + c1
//   y = m2 * x + c2

// Equating the two we get

//   m1 * x + c1 = m2 * x + c2
//   (m1 - m2) * x = c2 - c1
//   x = (c2 - c1) / (m1 - m2)

//   y = m1 * (c2 - c1) / (m1 - m2) + c1

// We return a vector [x, y], where z = 0

function intersect (m1, c1, m2, c2) =
     [(c2 - c1) / (m1 - m2), m1 * (c2 - c1) / (m1 - m2) + c1, 0];


// Function to computer intersection of 2 lines where one is vertical

//   y = m * x + c
//   x = k

// Equating the two we can solve for y

//   y = m * k + c

// We return a vector [x, y, z], where z = 0

function intersect2 (m, c, k) =
     [k, m * k + c, 0];


// Block outline of main stand part.

// We use the intersections of OUTER_R inside the main outline:

//   Inside face by w:     y = tan (A) * x - w / cos A
//   Inside base by w:     y = w
//   Inside back by w:     x = F * cos (A) - w

// where w = OUTER_R

module main_block () {
     w = OUTER_R;
     hull () {
	  translate (v = intersect (tan(A), -w / cos (A), 0, w))
	       cylinder (r = w, h = H, center = false, $fn = 24);
	  translate (v = intersect2 (0, w, F * cos (A) - w))
	       cylinder (r = w, h = H, center = false, $fn = 24);
	  translate (v = intersect2 (tan(A), w / cos (A), F * cos (A) - w))
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
//	  lo_hole ();
     }
}


stand ();

