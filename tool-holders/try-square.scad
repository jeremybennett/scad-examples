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
	translate (v = [x_off, length / 2, z_off])
		rotate (a = [-90, 0, 0])
			screwhole (bore = bore, length = length);
}


// The solid support is a block with a triangular end.
module try_square_block () {
	iota = 0.01;
	l = sqrt (68 * 68 / 2);
	union () {
		cube (size = [147.5, 20, 20], center = false);
		intersection () {
			rotate (a = [0, -45, 0])
				translate (v = [l / 2, 10, 0])
					cube (size = [l, 20, 400], center = true);
			cube (size = [68, 20, 68 - 7.5], center = false);
		}
	}
}


// Supporter for a try-square on a rack
module try_square () {
	iota = 0.01;
	difference () {
		try_square_block ();
		translate (v = [7.5, 5.5, -iota])
			cube (size = [48, 3, 400], center = false);
		screwhole_y (bore = 3.5, length = 20, x_off =  65.5, z_off = 10);
		screwhole_y (bore = 3.5, length = 20, x_off = 137.5, z_off = 10);
	}
}

try_square ();

