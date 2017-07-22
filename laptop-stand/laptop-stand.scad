// Configurable laptop stand

// Copyright (C) 2017 Embecosm Limited (www.embecosm.com)

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

H = 25;

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
//   Mid split:            y = -tan (A) * x + F * sin (A)
//   Below mid-split by w: y = -tan A() * x + F * sin (A) - w / cos (A)
//   Above mid-split by w: y = -tan A() * x + F * sin (A) + w / cos (A)

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

function intersect (m1, c1, m2, c2, z = 0) =
     [(c2 - c1) / (m1 - m2), m1 * (c2 - c1) / (m1 - m2) + c1, z];


// Function to computer intersection of 2 lines where one is vertical

//   y = m * x + c
//   x = k

// Equating the two we can solve for y

//   y = m * k + c

// We return a vector [x, y, z], where z = 0

function intersect2 (m, c, k, z = 0) =
     [k, m * k + c, z];


// Function to compute the intercept of a parallel line at a specified offset

// Given a line

//   y = m * x + c

// We compute the parallel line

//   y = m * x + c'

// Such that the second line is a specified distance, w, apart. If w > 0, then
// c' > c. Result is c'.

function parallel (m, c, w) =
     (w == 0) ? c :
     (w > 0) ? c + sqrt (w * w * (m * m + 1)) : c - sqrt (w * w * (m * m + 1));


// Block outline of main stand part.

// We use the intersections of OUTER_R inside the main outline by w

//   Face:     y = tan (A) * x
//   Case:     y = 0
//   Back:     x = F * cos (A)

// where w = OUTER_R


// Function to compute the center of a circle touching two lines.

// The lines are:

//   y = m1 * x + c1
//   y = m2 * x + c2

// We assume the first line is clockwise of the second line, which controls
// which of the four possible circles we find.

function cc (m1, c1, m2, c2, r, z = 0) =
     let (start = intersect (m1, c1, m2, c2, z),
	  B = atan (m1),
	  D = atan ((m2 - m1) / (1 + m1 * m2)),
	  E = D / 2.0,
	  b = r / sin (E),
	  xinc = b * cos (E + B),
	  yinc = b * sin (E + B))
     [start [0] + xinc, start[1] + yinc, z];


// Function to compute the center of a circle touching two lines, one of which
// is vertical.

// We assume the first line is clockwise of the second line, which controls
// which of the four possible circles we find.

function cc2 (m, c, k, r, z = 0) =
     let (start = intersect (m1, c1, m2, c2, z),
	  B = atan (m1),
	  D = atan ((m2 - m1) / (1 + m1 * m2)),
	  E = D / 2.0,
	  b = r / sin (E),
	  xinc = b * cos (E + B),
	  yinc = b * sin (E + B))
     [start [0] + xinc, start[1] + yinc, z];


module main_block () {
     w = OUTER_R;

     hull () {
	  translate (v = cc (m1 = 0,
			     c1 = 0,
			     m2 = tan(A),
			     c2 = 0,
			     r = w,
			     z = 0))
	       cylinder (r = OUTER_R, h = H, center = false, $fn = 24);
	  translate (v = intersect2 (m = 0,
				     c = w,
				     k = F * cos (A) - w,
			             z = 0))
	       cylinder (r = OUTER_R, h = H, center = false, $fn = 24);
	  translate (v = intersect2 (m = tan (A),
				     c = parallel (m = tan (A),
						   c = 0,
						   w = -w),
				     k = F * cos (A) - w,
			             z = 0))
	       cylinder (r = OUTER_R, h = H, center = false, $fn = 24);
     }
}


// Lower hole

// We use the intersection of OUTER_R inside the main outline and a line
// parallel to the mid-split line by OUTER_R / 2.  The mid-split line is

//    y = -tan (A) * x + F * sin (A)

module lo_hole () {
     w1 = OUTER_R;
     w2 = OUTER_R / 1.5;

     hull () {
	  translate (v = intersect (m1 = tan (A),
				    c1 = parallel (m = tan (A),
						   c = 0,
						   w = -w1),
				    m2 = 0,
				    c2 = w1,
				    z = -H))
	       cylinder (r = INNER_R, h = H * 3, center = false, $fn = 24);
	  translate (v = intersect (m1 = -tan (A),
				    c1 = parallel (m = -tan (A),
						   c = F * sin (A),
						   w = -w2),
				    m2 = tan (A),
				    c2 = parallel (m = tan (A),
						   c = 0,
						   w = -w1),
			            z = -H))
	       cylinder (r = INNER_R, h = H * 3, center = false, $fn = 24);
	  translate (v = intersect (m1 = 0,
				    c1 = w1,
				    m2 = -tan (A),
				    c2 = parallel (m = -tan (A),
						   c = F * sin (A),
						   w = -w2),
			            z = -H))
	       cylinder (r = INNER_R, h = H * 3, center = false, $fn = 24);
     }
}


// Upper hole

// We use the intersection of OUTER_R inside the main outline and a line
// parallel to the mid-split line by OUTER_R / 2.  The mid-split line is

//    y = -tan (A) * x + F * sin (A)

module hi_hole () {
     w1 = OUTER_R;
     w2 = OUTER_R / 1.5;

     hull () {
	  translate (v = intersect (m1 = -tan (A),
				    c1 = parallel (m = -tan (A),
						   c = F * sin (A),
						   w = w2),
				    m2 = tan (A),
				    c2 = parallel (m = tan (A),
						   c = 0,
						   w = -w1),
			            z = -H))
	       cylinder (r = INNER_R, h = H * 3, center = false, $fn = 24);
	  translate (v = intersect2 (m = tan (A),
				     c = parallel (m = tan (A),
						   c = 0,
						   w = -w1),
				     k = F * cos (A) - w1,
				     z = -H))
	       cylinder (r = INNER_R, h = H * 3, center = false, $fn = 24);
	  translate (v = intersect2 (m = -tan (A),
				     c = parallel (m = -tan (A),
						   c = F * sin (A),
						   w = w2),
				     k = F * cos (A) - w1,
			            z = -H))
	       cylinder (r = INNER_R, h = H * 3, center = false, $fn = 24);
     }
}


// The complete stand

module stand () {
     difference () {
	  main_block ();
	  lo_hole ();
	  hi_hole ();
     }
}


stand ();

