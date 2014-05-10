// Samsung Monitor Support 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Samsung Monitor Support 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Wedge supports for a Samsung monitor

// Start 


// Triangle

// Apex at origin, with sides of given length at the given angles from the
// origin (x axis positive direction is 0).

// @param l   Length of edges from origin
// @param a1  Angle from origin of first line of triangle
// @param a2  Angle from origin of second line of triangle
module triangle (l, a1, a2) {
	x0 = 0;
	y0 = 0;
	x1 = cos (a1) * l;
	y1 = sin (a1) * l;
	x2 = cos (a2) * l;
	y2 = sin (a2) * l;
	polygon ( points = [ [x0, y0], [x1, y1], [x2, y2] ], convexity = 5 );

}			// triangle ()


// Square with a triangle cut out

// @param l   Length of edge
// @param a1  Angle from origin of start of triangle
// @param a2  Angle from origin of end of triangle
module square_mask (l, a1, a2) {
	difference () {
		square (size = l, center = true);
		triangle (l, a1, a2);
	}
}			// square_mask ()


// 2D triangle wedge from an elipse.

// @param d1  Diameter in the X direction
// @param d2  Diameter in the Y direction
// @param a1  Angle from origin of start of wedge
// @param a2  Angle from origin of end of wedge
module wedge2d (d1, d2, a1, a2) {
	difference () {
		scale (v = [d1 / 100, d2 / 100, 1])
			circle (d = 100, $fn = 360);
		square_mask (d1 + d2, a1, a2);
	}
}			// wedge2d ()


// 3D wedge from an elipse

// The angle up is from the far side of the original elipse, not the center.
// rotate_extrude, which we might use seems not to generate a solid that will
// render correctly, so instead we build as a set of layers, using rotate.

// It is clearer to move the wedge and rotate around the Y axis, than to try to
// work out the actual rotation vector.

// @param d1   Diameter in the X direction
// @param d2   Diameter in the Y direction
// @param a1   Angle from origin of start of wedge
// @param a2   Angle from origin of end of wedge
// @param az1  Starting angle up of the wedge
// @param az2  Ending angle up of the wedge
module wedge3d (d1, d2, a1, a2, az1, az2) {
	step_len = (d1 + d2) / 100;		// wedge increment in mm
	step_angle = acos (1 - step_len * step_len  / 2 / d1 / d1);		// Cosine rule
	// Reduce step angle to ensure wedge increments overlap
	for (a = [ az1 : step_angle * 0.9 : az2 ])
		rotate (a = [0, -a, 0])
			translate (v = [d1 / 2, 0, 0])
				rotate (a = [0, 0, -(a1 + a2) / 2])
					linear_extrude (height = step_len, center = false)
						wedge2d (d1, d2, a1, a2);

}			// wedge3d ()


// Construct one wedge in its correct location

// wedge3d has translated the wedge to be centered on the X axix and
// shifted by the x radius. Move it back.

// @param d1   Diameter in the X direction
// @param d2   Diameter in the Y direction
// @param a1   Angle from origin of start of wedge
// @param a2   Angle from origin of end of wedge
// @param az1  Starting angle up of the wedge
// @param az2  Ending angle up of the wedge
module wedge (d1, d2, a1, a2, az1, az2) {
	rotate (a = [0, 0, (a1 + a2) / 2])
		translate (v = [-d1 / 2, 0, 0])
			wedge3d (d1, d2, a1, a2, az1, az2);
}


// Print an actual support wedge

// This knows that the base is an elipse with diameters 19.3cm and 25.0cm

// @param start_angle  The angle at which the wedge starts
// @param end_angle    The angle at which the wedge starts
// @param tilt_angle   The angle at which the stand is to be tilted
module samsung_support (start_angle, end_angle, tilt_angle) {
	difference () {
		union () {
			wedge (189, 246, start_angle, end_angle, 0, tilt_angle);
			difference () {
				wedge (199, 256, start_angle, end_angle, 0, tilt_angle);
				wedge (193, 250, start_angle - 1, end_angle + 1, tilt_angle - 1,
				       tilt_angle + 1);
			}
		}
		wedge (193 * 0.9, 250 * 0.9, start_angle - 2, end_angle + 2, -1,
		       tilt_angle + 5);
		// Remove any anoying bit at the center
		cylinder (h = 199, d = 100, center = true);
	}
}	


// Produce a pair of supports

// For convenience when printing move them closer together.

// @param start_angle  The angle at which the wedge starts
// @param end_angle    The angle at which the wedge starts
// @param tilt_angle   The angle at which the stand is to be tilted
module samsung_support_pair (start_angle, end_angle, tilt_angle) {
	rotate (a = [0, 0, 5 - start_angle])
		samsung_support (start_angle, end_angle, tilt_angle);

	// Produce a mirror support
	mirror (v = [0, 1, 0])
		rotate (a = [0, 0, 5 - start_angle])
			samsung_support (start_angle, end_angle, tilt_angle);

}			// samsung_support_pair ()

samsung_support_pair (30, 45, 7);
//cube (100)
