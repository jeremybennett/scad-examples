// USB hub holder 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported
// License.

// You should have received a copy of the license along with this work.  If not,
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------


// The holder
module usb_holder () {
	difference () {
		// The main support
		translate (v = [82 / 2, 16 / 2, 23 / 2])
			cube (size = [82, 16, 23], center = true);
		// Slot for the hub
		translate (v = [62 / 2 + 9.8, 12 / 2, 19.4 / 2])
			cube (size = [62, 12.2, 19.6], center = true);
		// USB lead access
		translate (v = [40 / 2 + 21, 16 / 2, 15 / 2])
			cube (size = [40, 16.2, 15.2], center = true);
		// Screw access
		translate (v = [5, 8, 10 / 2 + 13.2])
			cylinder (r = 3.3, h = 10.2, center = true, $fn = 24);
		// Screw hole
		translate (v = [5, 8, 23 / 2])
			cylinder (r = 1.7, h = 23.2, center = true, $fn = 24);
		// Screw countersink
		translate (v = [5, 8, 23.2 - 1.3 / 2 - 10])
			cylinder (r1 = 1.7, r2 = 3, h = 1.3, center = true, $fn = 24);
		// Screw access
		translate (v = [77, 8, 10 / 2 + 13.2])
			cylinder (r = 3.3, h = 10.2, center = true, $fn = 24);
		// Screw hole
		translate (v = [77, 8, 23 / 2])
			cylinder (r = 1.7, h = 23.2, center = true, $fn = 24);
		// Screw countersink
		translate (v = [77, 8, 23.2 - 1.3 / 2])
			cylinder (r1 = 1.7, r2 = 3, h = 1.3, center = true, $fn = 24);
	}
}

rotate (a = [-90, 0, 0])
   usb_holder ();


