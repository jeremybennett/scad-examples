// Wire strippers (second type) holder 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Crimp holder 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not,
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------


use <MCAD/regular_shapes.scad>


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
	translate (v = [x_off, 0, z_off])
		rotate (a = [-90, 0, 0])
			screwhole (bore = bore, length = length);
}


// Crimp support with screwholes
module stripper_support () {
	back_thickness = 7;
	front_thickness = 5;
	side_thickness = 10;
	hole_width = 32;
	hole_depth = 16;
	block_width = hole_width + side_thickness * 2;
	block_depth = hole_depth + back_thickness + front_thickness;
	height = 20;
	screw_x_off = (hole_width + side_thickness) / 2;
	screw_z_off = 0;
	iota = 0.1;
	difference () {
		cube (size = [block_width, block_depth, height], center = true);
		// hole for strippers
		translate (v = [0, (back_thickness - front_thickness) / 2, 0])
			cube (size = [ hole_width, hole_depth, height + iota], center = true);
		// screw_holes
		screwhole_y (bore = 4, length = block_depth + iota, x_off =  screw_x_off,
		             z_off = screw_z_off);
		screwhole_y (bore = 4, length = block_depth + iota, x_off = -screw_x_off,
		             z_off = screw_z_off);
	}
}


stripper_support ();