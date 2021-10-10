// Configurable laptop stand

// Copyright (C) 2017 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// General overlap value

DELTA  = 0.05;
DELTA2 = DELTA * 2;

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

// General
// -------

// Vertical lines are represented as vectors [TRUE, x_intercept]
// All other lines are represented as vectors [FALSE, m, c]
// Points are represented as vectors [x ,y, z]

// Note: We could more compactly represent vertical lines as scalars and use
//       vectors for all other lines, relying on len () which returns undef on
//       scalars to distinguish them. However our approach provides an element
//       of redundancy which can be helpful.


// Function to report if a line is vertical

function isvert (l) =
     l[0];


// Function to report if a line is horizontal

function ishoriz (l) =
     (!isvert (l)) && (l[1] == 0);


// Function to compute intersection of 2 lines, neither of which is vertical

//   y = m1 * x + c1
//   y = m2 * x + c2

// Equating the two we get

//   m1 * x + c1 = m2 * x + c2
//   (m1 - m2) * x = c2 - c1
//   x = (c2 - c1) / (m1 - m2)

//   y = m1 * (c2 - c1) / (m1 - m2) + c1

// We return a point [x, y], where x and y are both UNDEF if the lines are
// parallel.

function intersect1 (l1, l2) =
     let (m1 = l1[1], c1 = l1[2], m2 = l2[1], c2 = l2[2])
     (m1 == m2) ? [undef, undef, 0]
                : [(c2 - c1) / (m1 - m2), m1 * (c2 - c1) / (m1 - m2) + c1, 0];


// Function to computer intersection of 2 lines where one is vertical

//   y = m * x + c
//   x = k

// Equating the two we can solve for y

//   y = m * k + c

// Note that the second line is always the vertical one

// We return a pint [x, y, 0]

function intersect2 (l1, l2) =
     let (m = l1[1], c = l1[2], k = l2[1])
     [k, m * k + c, 0];


// Function to compute intersection of 2 lines, one of which may be vertical

// Returns a point [x,y], where x and y are both UNDEF if we are asked for the
// intersection of two vertical lines.

function intersect (l1, l2) =
     (isvert (l1) ? (isvert (l2) ? [undef, undef] : intersect2 (l2, l1))
                  : (isvert (l2) ? intersect2 (l1, l2) : intersect1 (l1, l2)));


// Function to compute the equation of a non-vertical parallel line

// Given y = m * x + c

// The line r above (below if r is negative) has the equation

//   y = m * x + c + r * sqrt (1 + m^2)

// We return the line [FALSE, m, c + r * sqrt (1 + m^2)]

function parallel_line1 (l, r) =
     let (m = l[1], c = l[2])
     [false, m, c + r * sqrt (1 + m * m)];


// Function to compute the equation of a vertical parallel line

// Given x = k

// The line r to the right left if r is negative) has the equation

//   x = k + r;

// We return the line [TRUE, k + r]

function parallel_line2 (l, r) =
     let (k = l[1])
     [true, k + r];


// Function to compute the equation of a parallel line

// This function works for vertical and non-vertical lines

// We return the parallel line

function parallel_line (l, r) =
     (isvert (l) ? parallel_line2 (l, r) : parallel_line1 (l, r));


// Function to compute a perpendicular line which passes through a point,
// where neither the original line, nor the resulting one are vertical.

// Let the originating line be:

//    y = m * x + c

// and the point of intersection be (x1, y1)

// The gradient of the resulting line, m' = -1/m
// The intercept, c' = y1 + x1 / m

// Return the resulting line [FALSE, m', c']

function perpendicular_line1 (l, p) =
     let (m = l[1], c = l[2], x1 = p[0], y1 = p [1])
     [false, -1 / m, y1 + x1 / m];


// Function to compute a perpendicular line which passes through a point where
// the original line is vertical.

// Let the originating line be:

//    x = k

// and the point of intersection be (x1, y1)

// The gradient of the resulting line, m' = 0
// The intercept, c' = y1

// Return the resulting line [FALSE, m', c']

function perpendicular_line2 (l, p) =
     let (y1 = p[1])
     [false, 0, y1];


// Function to compute a perpendicular line which passes through a point where
// the resulting line is vertical.

// Let the originating line be:

//    y = c

// and the point of intersection be (x1, y1)

// The x-intercept of the resulting line, k = x1

// Return the resulting line [TRUE, k]

function perpendicular_line3 (l, p) =
     let (x1 = p[0])
     [true, x1];


// Function to compute a perpendicular line which passes through a point

// We have to deal with the special cases where either the starting line or
// the resulting line may be vertical

// We return the resulting line

function perpendicular_line (l, p) =
     (isvert (l) ? perpendicular_line2 (l, p)
                 : (ishoriz (l) ? perpendicular_line3 (l, p)
                                : perpendicular_line1 (l, p)));


// Function to return the mid point between two points

// Return the resulting mid-point

function mid_point (p1, p2) =
     [(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, (p1[2] + p2[2]) / 2];


// Function to return the non-vertical line which passes between two points.

// For now z is ignored.

// Return the resulting line

function join_line1 (p1, p2) =
     let (x1 = p1[0], x2 = p2[0], y1 = p1[1], y2 = p2[1],
	  m = (y2 - y1) / (x2 - x1), c = y1 - m * x1)
     [false, m, c];


// Function to return the vertical line which passes between two points.

// For now z is ignored.

// Return the resulting line

function join_line2 (p1, p2) =
     let (x1 = p1[0])
     [true, x1];


// Function to return the line which passes between two points.

// For now z is ignored. Split into vertical and non-vertical cases

// Return the resulting line

function join_line (p1, p2) =
     ((p1[0] != p2[0]) ? join_line1 (p1, p2) : join_line2 (p1, p2));


// The lines which outline the stand

//   Face:  y = tan (A) * x + 0  ([FALSE, tan (A), 0])
//   Base:  y = 0                ([FALSE, 0, 0])
//   Back:  x = F * cos (A)      ([TRUE, F * cos (A)])

face_line = [false, tan (A), 0];
base_line = [false, 0, 0];
back_line = [true, F * cos (A)];


// The diagonal goes from halfway along the face to the meeting point of the
// back and base.

mid_line = join_line (mid_point (intersect (back_line, face_line),
				 intersect (face_line, base_line)),
		      intersect (base_line, back_line));


// Block outline of main stand part.

// We use the intersections of OUTER_R inside the main outline:

//   Inside face by w:     y = tan (A) * x - w / cos A
//   Inside base by w:     y = w
//   Inside back by w:     x = F * cos (A) - w

// where w = OUTER_R

// We then add the lip, which is at right angles from the forward bottom
// corner.

module main_block () {
     w = OUTER_R;
     l1 = parallel_line (base_line, w);
     l2 = parallel_line (face_line, -w);
     l3 = parallel_line (back_line, -w);

     hull () {

	  // Main triangle

	  translate (v = intersect (l1, l2))
	       cylinder (r = w, h = H, center = true, $fn = 24);
	  translate (v = intersect (l2, l3))
	       cylinder (r = w, h = H, center = true, $fn = 24);
	  translate (v = intersect (l3, l1))
	       cylinder (r = w, h = H, center = true, $fn = 24);

	  // Lip
     }
}


// Lower hole

module lo_hole () {
     w1 = OUTER_R;
     w2 = INNER_R;
     h = H + DELTA;
     l1 = parallel_line (base_line, w1);
     l2 = parallel_line (face_line, -w1);
     l3 = parallel_line (mid_line,  -(T/2 + w2));
     hull () {
	  translate (v = intersect (l1, l2))
	       cylinder (r = w2, h = h, center = true, $fn = 24);
	  translate (v = intersect (l2, l3))
	       cylinder (r = w2, h = h, center = true, $fn = 24);
	  translate (v = intersect (l3, l1))
	       cylinder (r = w2, h = h, center = true, $fn = 24);
     }
}


// Upper hole

module hi_hole () {
     w1 = OUTER_R;
     w2 = INNER_R;
     h = H + DELTA;
     l1 = parallel_line (back_line, -w1);
     l2 = parallel_line (face_line, -w1);
     l3 = parallel_line (mid_line, T/2 + w2);
     hull () {
	  translate (v = intersect (l1, l2))
	       cylinder (r = w2, h = h, center = true, $fn = 24);
	  translate (v = intersect (l2, l3))
	       cylinder (r = w2, h = h, center = true, $fn = 24);
	  translate (v = intersect (l3, l1))
	       cylinder (r = w2, h = h, center = true, $fn = 24);
     }
}


// The lip

module lip () {
     w1 = T/2;
     w2 = LAPTOP_T + T;
     l1 = parallel_line (base_line, w1);
     l2 = parallel_line (face_line, -w1);
     l3 = perpendicular_line (face_line, intersect (l1, l2));
     l4 = parallel_line (face_line, w1 + w2);
     hull () {
	  translate (v = intersect (l1, l2))
	       cylinder (r = w1, h = H, center = true, $fn = 24);
	  translate (v = intersect (l3, l4))
	       cylinder (r = w1, h = H, center = true, $fn = 24);
     }
}


// The complete stand

module stand () {
     difference () {
	  union () {
	       main_block ();
	       lip ();
	  }
	  lo_hole ();
	  hi_hole ();
     }
}


echo ("mid point", mid_point (intersect (back_line, face_line),
			      intersect (face_line, base_line)))
echo (mid_line);
stand ();
