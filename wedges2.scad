// Samsung Monitor Support 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Samsung Monitor Support 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Version 2 of wedge supports for a Samsung monitor

// Start with a squashed elipse and slice off the bits we don't want. Much
// easier approach than the old wedges.scad, and produces correctly shaped
// wedges.


// The starting elipse

// Assume longer is along the Y axis, but we move it out to be adjacent to the Y
// axis. The rotation is around the Y axis

// @param dx  Diameter in the X direction (assume shorter)
// @param dy  Diamater in the Y direction.
module ellipsoid (dx, dy) {
	translate (v = [dx / 2, 0, 0])
		scale (v = [dx / 100, dy / 100, dx / 100])
			sphere (d = 100, $fn = 360);
}

// ellipsoid (193, 250);

// 3D wedge from an elipse

// We cut away big rotated boxes in the directions that matter.

// @param dx   Diameter in the X direction
// @param dy   Diameter in the Y direction
// @param a1   Angle from origin of start of wedge
// @param a2   Angle from origin of end of wedge
// @param az1  Starting angle up of the wedge
// @param az2  Ending angle up of the wedge
module wedge (dx, dy, a1, a2, az1, az2) {
	s = dx + dy;
	difference () {
		ellipsoid (dx, dy);
		rotate (a = [0, 0, a1])
			translate (v = [0, -s, 0])
				cube (size = 2 * s, center = true);
		rotate (a = [0, 0, a2])
			translate (v = [0, s, 0])
				cube (size = 2 * s, center = true);
		rotate (a = [0, -az1, 0])
			translate (v = [s, 0, -s])
				cube (size = 2 * s, center = true);
		rotate (a = [0, -az2, 0])
			translate (v = [s, 0, s])
				cube (size = 2 * s, center = true);
	}
}			// wedge ()


// Print an actual support wedge

// This knows that the base is an elipse with diameters 19.3cm and 25.0cm.
// Remember when working out spacings, that the rotations are all done with the
// ellipsoids aligned on the Y axis, not centered, so widths of grooves are
// reductions in diameters, not radii.

// @param start_angle  The angle at which the wedge starts
// @param end_angle    The angle at which the wedge starts
// @param tilt_angle   The angle at which the stand is to be tilted
module samsung_support (start_angle, end_angle, tilt_angle) {
	difference () {
		union () {
			wedge (191, 248, start_angle, end_angle, 0, tilt_angle);
			difference () {
				wedge (196, 253, start_angle, end_angle, 0, tilt_angle);
				wedge (193, 250, start_angle - 1, end_angle + 1, tilt_angle - 1,
				       tilt_angle + 1);
			}
		}
		wedge (193 * 0.94, 250 * 0.94, start_angle - 2, end_angle + 2, -1,
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

samsung_support_pair (20, 32, 9);



