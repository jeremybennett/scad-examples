// Feeder guide for Prusa-Mendel 3D printer 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported
// License.

// You should have received a copy of the license along with this work.  If not,
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// The main block
module main_block () {
	union () {
 		translate (v = [0, 0, 5])
			cube (size = [18, 6, 10], center = true);
		translate (v = [18 / 2, 0, 13 / 2])
			cylinder (r = 3, h = 13, center = true, $fn = 24);
 		translate (v = [-18 / 2, 0, 13 / 2])
			cylinder (r = 3, h = 13, center = true, $fn = 24);
	}
}


// torus

// The torus is centred on the origin, with the axis of the hole being the
// Z-axis. Done by extruding a circle

// @param rt  Radius of the torus "tube"
// @param rh  Radius of the hole in the torus
module torus (rt, rh) {
	rotate_extrude (convexity = 5, $fn = 90)
		translate (v = [rh + rt, 0, 0])
			rotate (a = [90, 0, 0])
				circle (r = rt, $fn = 28);
}


// Wedge

// A wedge shaped prism of the specified height and radius. Do as a cylinder
// and chop out what is not needed using triangles built as extrusions of
// triangular polygons.

// We concern ourselves with just the immediate quarter circle.

// @param r   Radius of the wedge
// @param h   Height of the wedge
// @param as  Starting angle
// @param ae  Ending angle

module wedge (r, h, as, ae) {

	// Get the value in the range 0 - 360. Deal with negative values as well.
	asm = ((as % 360) + 360) % 360;
   aem = ((ae % 360) + 360) % 360;

	// Which quadrants are the points in?
	sq = (asm >=   0) && (asm <  90) ? 0 :
	     (asm >=  90) && (asm < 180) ? 1 :
	     (asm >= 180) && (asm < 270) ? 2 : 3;
	eq = (aem >=   0) && (aem <  90) ? 0 :
	     (aem >=  90) && (aem < 180) ? 1 :
	     (aem >= 180) && (aem < 270) ? 2 : 3;

	// Which full quadrants we have is a bit tricky because we are counting
	// modulo 4.
	q0 = (sq < eq) ? (asm <=   0) && (aem >=  90)
	               : (asm >=  90) && (aem >=  90);
	q1 = (sq < eq) ? (asm <=  90) && (aem episode/c4b97d/doctor-who--series-8---2-into-the-dalek>= 180)
	               : (asm >= 180) && (aem >= 180);
	q2 = (sq < eq) ? (asm <= 180) && (aem >= 270)
	               : (asm >= 270) && (aem >= 270);
	q3 = (sq < eq) ? (asm <= 270) && (aem >= 360)
	               : (asm >=   0) && (aem >= 360);
	// Starting quadrant end
	asq = floor (asm / 90) * 90 + 90.1;	// End of quadrant + tiny overlap

	// Ending quadrant start
	aeq = floor (aem / 90) * 90 - 0.1;		// Start of quadrant + tiny overlap

	// Special case where segment starts and ends in the same quadrant.
	ase = (aem > asm) && (aem < asq) ? aem : asq;

	echo ("asm = ", asm);
	echo ("aem = ", aem);
	echo ("sq = ", sq);
	echo ("eq = ", eq);
	echo ("q0 = ", q0);
	echo ("q1 = ", q1);
	echo ("q2 = ", q2);
	echo ("q3 = ", q3);
	echo ("asq = ", asq);
	echo ("aeq = ", aeq);
	echo ("ase = ", ase);

	if (asm < ase)
		// Need a partial wedge for this quadrant
		linear_extrude (height = h, slices = 1, center = true)
			intersection () {
				polygon (points = [ [0, 0],
				                    [2 * r * cos (ase), 2 * r * sin (ase)],
				                    [2 * r * cos (asm), 2 * r * sin (asm)] ]);
				circle (r = r, $fn = 90);
			}

	// Ending quadrant, but if we were all in one quadrant, no more to do
	if ((asq == ase) && (aem > aeq))
		// Need a partial wedge for this quadrant
		linear_extrude (height = h, slices = 1, center = true)
			intersection () {
				polygon (points = [ [0, 0],
				                    [2 * r * cos (aeq), 2 * r * sin (aeq)],
				                    [2 * r * cos (aem), 2 * r * sin (aem)] ]);
				circle (r = r, $fn = 90);
			}

	// Infill complete quadrants
	if (q0)
		linear_extrude (height = h, slices = 1, center = true)
			intersection () {
				polygon (points = [ [0, 0],
				                    [0, 2 * r],
				                    [2 * r, 0] ]);
				circle (r = r, $fn = 90);
			}

	if (q1)
		linear_extrude (height = h, slices = 1, center = true)
			intersection () {
				polygon (points = [ [0, 0],
				                    [0, 2 * r],
				                    [-2 * r, 0] ]);
				circle (r = r, $fn = 90);
			}
	if (q2)
		linear_extrude (height = h, slices = 1, center = true)
			intersection () {
				polygon (points = [ [0, 0],
				                    [-2 * r, 0],
				                    [0, -2 * r] ]);
				circle (r = r, $fn = 90);
			}
	if (q3)
		linear_extrude (height = h, slices = 1, center = true)
			intersection () {
				polygon (points = [ [0, 0],
				                    [0, -2 * r],
				                    [0, 2 * r] ]);
				circle (r = r, $fn = 90);
			}
}

// @param 

// Part torus

// A torus cropped to just be from the starting angle to the ending angle. The
// part torus is positioned, as though the original torus were centered on the
// origin.

// @param rt  Radius of the torus "tube"
// @param rh  Radius of the hole in the torus
// @param as  Starting angle
// @param ae  Ending angle
module part_torus (rt, rh, as, ae) {
	intersection () {
		torus (rt = rt, rh = rh);
		wedge (r = (rt * 2 + rh) * 1.01, h = rt * 2 * 1.01, as = as, ae = ae);
	}
}

module side () {
	l = 120;
	w = 16;
	h = 16;

	hull () {
		cube (size = [l, w, h], center = true);
		translate (v = [0, 0, h])
			rotate (a = [0, 90, 0])
				cylinder (r = w / 2, h = l, center = true, $fn = 24);
	}
}

side ();
//part_torus (rt = 10, rh = 20, as = -30, ae = 95);