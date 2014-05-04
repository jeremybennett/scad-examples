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

// @param d1  Diameter in the X direction
// @param d2  Diameter in the Y direction
// @param a1  Angle from origin of start of wedge
// @param a2  Angle from origin of end of wedge
// @param az  Angle up of the wedge
module wedge3d (d1, d2, a1, a2, az) {
	difference () {
		rotate_extrude ($fn = 360)
			wedge2d (d1, d2, a1, a2);
		linear_extrude (height = d1 + d2, center = true)
			square_mask (l = d1 + d2, a1 = 0, a2 = az);
	}
}			// wedge3d ()

//		linear_extrude (height = 44.3, center = true)
//			square_mask (l = 44.3, a1 = 0, a2 = 15);
//wedge3d (19.3, 25.0, 10, 30, 15);

linear_extrude (height = 10)
wedge2d (19.3, 25.0, 10, 30);


	


