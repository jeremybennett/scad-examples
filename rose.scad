// Watering Can Rose 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Watering Can Rose 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Watering can rose. Internal diameter of connector is 15.67mm, depth of
// connector is 4mm (we allow 5).
difference () {
	union () {
		difference () {
			translate (v = [0, 0, 31.99])
				cylinder (d = 19.67, h = 5.01, center = false);
			translate (v = [0, 0, 31.98])
				cylinder (d = 15.67, h = 5.03, center = false);
		}
		difference () {
			cylinder (d1 = 83.67, d2 = 19.67, h = 32.00, center = false);
			cylinder (d1 = 79.67, d2 = 15.67, h = 32.01, center = false);
		}

		cylinder (d = 79.67, h = 2, center = false);
	}
	for (x = [-38 : 5 : +38]) {
		for (y = [-38 : 5 : +38]) {
			assign (r = x * x + y * y) {
				if (r < (38 * 38)) {
					translate (v = [x, y, -0.01])
						cylinder (d = 1, h = 2.02, center = false);
				}
			}
		}
	}
}
