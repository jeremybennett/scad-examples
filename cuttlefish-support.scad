// Cuttlefish supporter 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported
// License.

// You should have received a copy of the license along with this work.  If not,
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// The main block
module main_block () {
	union () {
 		translate (v = [0, 0, 5])
			cube (size = [19, 6, 10], center = true);
		translate (v = [19 / 2, 0, 13 / 2])
			cylinder (r = 3, h = 13, center = true, $fn = 24);
 		translate (v = [-19 / 2, 0, 13 / 2])
			cylinder (r = 3, h = 13, center = true, $fn = 24);
	}
}


// The support
module cuttlefish_support () {
	difference () {
		main_block ();
		translate (v = [19 / 2, 0, 13 / 2])
			cylinder (r = 1.5, h = 13.5, center = true, $fn = 24);
		translate (v = [-19 / 2, 0, 13 / 2])
			cylinder (r = 1.5, h = 13.5, center = true, $fn = 24);
	}
}

cuttlefish_support ();
