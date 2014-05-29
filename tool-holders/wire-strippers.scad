// Try-square holder 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Watering Can Rose 3D Design is licensed under a Creative Commons
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
		cylinder (d = bore, h = full_length, center = true, $fn = 24);
		translate (v = [0, 0, -half_length + bore / 4 + bore / 10])
			cylinder (d1 = bore * 2, d2 = bore, h = bore / 2, center = true, $fn = 24);
		translate (v = [0, 0, -half_length + bore / 20])
			cylinder (d = bore * 2, h = bore / 10, center = true, $fn = 24);
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
module curve_wedge (r_outer, r_inner, edge_off, tilt, y_thick, y_off) {
	iota = y_thick / 10;
	half_base = r_outer * sin (tilt);
	height = r_outer * cos (tilt);
   x_thick = r_outer;
	len = r_outer * 4;
	translate (v = [0, y_off, 0])
		difference () {
			intersection () {
				rotate (a = [-90, 0, 0])
					cylinder (r = r_outer, h = y_thick, center = true);
				translate (v = [x_thick / 2 * cos (tilt) - edge_off, 0, 0])
					rotate (a = [0, tilt, 0])
						cube (size = [x_thick, y_thick, len], center = true);
				translate (v = [-x_thick / 2 * cos (tilt) + edge_off, 0, 0])
					rotate (a = [0, -tilt, 0])
						cube (size = [x_thick, y_thick, len], center = true);
			}
			rotate (a = [-90, 0, 0])
				cylinder (r = r_inner, h = y_thick + iota, center = true);
		}
}


// The hole for the bolt to slip through

// @param thick  The thickness of the hole
// @param diam   The diameter of the bolt head
module bolt_hole (thick, diam) {
	iota = thick / 100;
	height = (diam + thick) * 5;
	union () {
		rotate (a = [-90, 0, 0])
			cylinder (d = diam, h = thick + iota, center = true);
		translate (v = [0, 0, height / 2])
			cube (size = [diam, thick + iota, height], center = true);
	}
}


// The actual support
module strip_support () {
	difference () {
		union () {
			curve_wedge (r_outer = 100, r_inner = 60, edge_off = 0, tilt = 17.5,
			             y_thick = 32, y_off = 0);
			curve_wedge (r_outer = 100, r_inner = 30, edge_off = 10, tilt = 17.5,
			             y_thick = 7, y_off = (32 - 7) / 2);
			curve_wedge (r_outer = 100, r_inner = 30, edge_off = 10, tilt = 17.5,
			             y_thick = 5, y_off = -(32 - 5) / 2);
		}
		translate (v = [0, 0, -45+23/2])
			bolt_hole (thick = 32, diam = 23);
		screwhole_y (bore = 4, length = 32, x_off =  20, z_off = -75);
		screwhole_y (bore = 4, length = 32, x_off = -20, z_off = -75);
	}
}


// Support with a flat base for easier printing.
module flat_strip_support () {
	intersection () {
		strip_support ();
		translate (v = [0, 0, -45])
			cube (size = [200, 32, 90], center = true);
	}
}


flat_strip_support ();
