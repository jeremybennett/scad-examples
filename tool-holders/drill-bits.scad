// Drill bits holder 3D Design

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
module screwhole_y (bore, length, x_off, y_off, z_off) {
	translate (v = [x_off, y_off, z_off])
		rotate (a = [-90, 0, 0])
			screwhole (bore = bore, length = length);
}


module drill_holes () {
	diams = [1.5, 2.0, 2.5, 3.0, 3.2, 3.5, 4.0, 4.5, 4.8, 5.0, 5.5, 6.0, 6.5];
	offs  = [11, 14, 18, 23, 29, 35, 42, 50, 59, 69, 79, 90, 102];
	for (i = [0 : 12]) {
		translate (v = [offs[i], 0, 2.5])
			cylinder (r = diams[i] / 2, h = 20, $fn = 24, center = false);
	}
}

// Block to be a support. Needs to be far enough away that we can get our hands on the
// drill bits
module drill_block () {
	width = 115;
	difference () {
		translate (v = [width / 2, 5, 7.5])
			cube (size = [width, 20, 15], center = true);
		drill_holes ();
	}
}


// Support with screwholes
module drill_support () {
	difference () {
		drill_block ();
		// screw_holes
		screwhole_y (bore = 4, length = 22, x_off =   5, y_off = 6, z_off = 7.5);
		screwhole_y (bore = 4, length = 22, x_off = 110, y_off = 6, z_off = 7.5);
	}
}

drill_support ();