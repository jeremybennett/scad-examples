// Flush cutter holder 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Flush cutter holder 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// A screw hole with a countersink
module screwhole (bore, length) {
	iota = length / 100;
	half_length = length / 2 + iota;
	full_length = half_length * 2;
	union () {
		cylinder (r = bore / 2, h = full_length, center = true, $fn = 24);
		translate (v = [0, 0, -half_length + bore / 4 + bore / 10])
			cylinder (r1 = bore, r2 = bore / 2, h = bore / 2, center = true, $fn = 24);
		translate (v = [0, 0, -half_length + bore / 20])
			cylinder (r = bore, h = bore / 10, center = true, $fn = 24);
	}
}


// A screw hole for a screw parallel with the Y axis
module screwhole_y (bore, length, x_off, z_off) {
	iota = length / 100;
	translate (v = [x_off, 0, z_off])
		rotate (a = [-90, 0, 0])
			screwhole (bore = bore, length = length);
}


// Produce a curved wedge shape

// @param r_outer   Outer radius
// @param r_inner   Inner radius
// @param edge_off  Offset of sloping sides from radius
// @param tilt      Angle of radii for edges
// @param y_thick   Thickness in the Y direction
// @param y_off     Offset in the Y direction
module wedge (r_outer, r_inner, edge_off, tilt, y_thick, y_off) {
	iota = y_thick / 10;
	half_base = r_outer * sin (tilt);
	height = r_outer * cos (tilt);
   x_thick = r_outer;
	len = r_outer * 4;
	translate (v = [0, y_off, 0])
		difference () {
			intersection () {
				cube (size = [x_thick, y_thick, r_outer * 2], center = true);
				translate (v = [x_thick / 2 * cos (tilt) - edge_off, 0, 0])
					rotate (a = [0, tilt, 0])
						cube (size = [x_thick, y_thick, len], center = true);
				translate (v = [-x_thick / 2 * cos (tilt) + edge_off, 0, 0])
					rotate (a = [0, -tilt, 0])
						cube (size = [x_thick, y_thick, len], center = true);
			}
			cube (size = [x_thick, y_thick + iota, r_inner * 2], center = true);
		}
}


// The actual support
module strip_support () {
	outer = 35;
	inner = 0;
	tilt = 20;
	inner_width = 17;
	off = 7.5;
	iota = 0.1;
	difference () {
		union () {
			wedge (r_outer = outer, r_inner = inner, edge_off = 0, tilt = tilt,
			             y_thick = inner_width + 12, y_off = 0);
			wedge (r_outer = outer, r_inner = inner, edge_off = off, tilt = tilt,
			             y_thick = 7, y_off = (inner_width + 5) / 2);
			wedge (r_outer = outer, r_inner = inner, edge_off = off, tilt = tilt,
			             y_thick = 5, y_off = -(inner_width + 7) / 2);
		}
		screwhole_y (bore = 4, length = inner_width + 12, x_off = 0,
		             z_off = -5);
		screwhole_y (bore = 4, length = inner_width + 12, x_off = 0,
		             z_off = -25);
		translate (v = [0, 0, 25])
			cube (size = [outer, inner_width + 12 + iota, 20], center = true);
	}
}


strip_support ();
