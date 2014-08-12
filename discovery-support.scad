// Discovery supporter 3D Design

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
			cube (size = [18, 6, 10], center = true);
		translate (v = [18 / 2, 0, 13 / 2])
			cylinder (r = 3, h = 13, center = true, $fn = 24);
 		translate (v = [-18 / 2, 0, 13 / 2])
			cylinder (r = 3, h = 13, center = true, $fn = 24);
	}
}


// The support
module discovery_support () {
	difference () {
		// The main support
		translate (v = [10 / 2, 10 / 2, 13 / 2])
			cube (size = [10, 10, 13], center = true);
		// Slot for the board
		translate (v = [10 / 2 + 7, 10 / 2 + 7, 1.8 / 2 + 9])
			cube (size = [10, 10, 1.8], center = true);
		// Screw hole
		translate (v = [3.5, 3.5, 13 / 2])
			cylinder (r = 1.7, h = 13.2, center = true, $fn = 24);
		// Screw countersink
		translate (v = [3.5, 3.5, 13.1 - 1.3 / 2])
			cylinder (r1 = 1.7, r2 = 3, h = 1.3, center = true, $fn = 24);
	}
}

discovery_support ();
