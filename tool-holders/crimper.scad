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
module crimp_block () {
	difference () {
		translate (v = [0, 0, 10])
			cube (size = [83, 38, 20], center = true);
		rotate (a = [0, -8, 0])
			translate (v = [-15.75, 1, 30])
				cube (size = [31.5, 26, 60], center = true);
		rotate (a = [0, 8, 0])
			translate (v = [15.75, 1, 30])
				cube (size = [31.5, 26, 60], center = true);
		translate (v = [0, 1, 30])
			cube (size = [31.5, 26, 60], center = true);
	}
}


// Crimp support with screwholes
module crimp_support () {
	difference () {
		crimp_block ();
		screwhole_y (bore = 4, length = 38, x_off = -36.5, z_off = 10);
		screwhole_y (bore = 4, length = 38, x_off =  36.5, z_off = 10);
	}
}


crimp_support ();