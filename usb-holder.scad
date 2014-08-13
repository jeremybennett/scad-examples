// USB hub holder 3D Design

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


// The holder
module usb_holder () {
	difference () {
		// The main support
		translate (v = [82 / 2, 16 / 2, 18 / 2])
			cube (size = [82, 16, 18], center = true);
		// Slot for the hub
		translate (v = [62.4 / 2 + 9.8, 12 / 2, 14.4 / 2])
			cube (size = [62.4, 12.2, 14.6], center = true);
		// Screw hole
		translate (v = [5, 8, 18.2 / 2])
			cylinder (r = 1.7, h = 18.2, center = true, $fn = 24);
		// Screw countersink
		translate (v = [5, 8, 18.2 - 1.3 / 2])
			cylinder (r1 = 1.7, r2 = 3, h = 1.3, center = true, $fn = 24);
		// Screw hole
		translate (v = [77, 8, 18.2 / 2])
			cylinder (r = 1.7, h = 18.2, center = true, $fn = 24);
		// Screw countersink
		translate (v = [77, 8, 18.2 - 1.3 / 2])
			cylinder (r1 = 1.7, r2 = 3, h = 1.3, center = true, $fn = 24);
	}
}

rotate (a = [-90, 0, 0])
   usb_holder ();


