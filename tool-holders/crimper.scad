// Crimp holder 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Crimp holder 3D Design is licensed under a Creative Commons
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
	translate (v = [x_off, 0, z_off])
		rotate (a = [-90, 0, 0])
			screwhole (bore = bore, length = length);
}


// The main holder block

// @param base_len  Length of the hole at the base
// @param base_width  Width of the base
module crimp_block (base_len, base_width) {
	difference () {
		translate (v = [0, 0, 10])
			cube (size = [base_len + 26, base_width + 18, 20], center = true);
		rotate (a = [0, -8, 0])
			translate (v = [-base_len / 4, -1, 30])
				cube (size = [base_len / 2, base_width, 60], center = true);
		rotate (a = [0, 8, 0])
			translate (v = [base_len / 4, -1, 30])
				cube (size = [base_len / 2, base_width, 60], center = true);
		translate (v = [0, -1, 29])
			cube (size = [base_len / 2, base_width, 60], center = true);
	}
}


// Crimp support with screwholes
module crimp_support () {
	base_len = 58;
   base_width = 20;
	screw_off = base_len / 2 + 7;
	screw_len = base_width + 18;
	difference () {
		crimp_block (base_len = base_len, base_width = base_width);
		screwhole_y (bore = 4, length = 38, x_off = -screw_off, z_off = 10);
		screwhole_y (bore = 4, length = 38, x_off =  screw_off, z_off = 10);
		translate (v = [10, -1, 29])
			cube (size = [30, base_width + 6, 60], center = true);
	}
}


crimp_support ();