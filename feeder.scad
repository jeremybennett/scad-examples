// Feeder guide for Prusa-Mendel 3D printer 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported
// License.

// You should have received a copy of the license along with this work.  If not,
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

use <MCAD/regular_shapes.scad>


// Cut out to remove part of the torus

module cut_out () {
	difference () {
		translate (v = [-150, -26.5, -11 ])
			cube (size = [150, 53, 18.5]);
		translate (v = [-150, -34, -11])
			cube (size = [150, 13, 11]);
		translate (v = [-150, +20, -11])
			cube (size = [150, 13, 11]);
		translate (v = [-150, -23.5, 0])
			rotate (a = [0, 90, 0])
				cylinder (h = 150, r = 3.5);
		translate (v = [-150, +23.5, 0])
			rotate (a = [0, 90, 0])
				cylinder (h = 150, r = 3.5);
	}
}


// Basic feeder shape

module  base_shape () {
	difference () {
		union () {
			torus2 (23.5,3.5);
			translate (v = [0, 0, -7])
				cylinder_tube (7, 27, 7);
		}
		cut_out ();
	}
	translate (v = [-150, -27, -7])
		cube (size = [150, 7, 7]);
	translate (v = [-150, +20, -7])
		cube (size = [150, 7, 7]);
	translate (v = [-150, -23.5, 0])
		rotate (a = [0, 90, 0])
			cylinder (h = 150, r = 3.5);
	translate (v = [-150, +23.5, 0])
		rotate (a = [0, 90, 0])
			cylinder (h = 150, r = 3.5);
}



// Feeder with cutouts for threaded rods

module feeder () {
	difference () {
		base_shape ();
		translate (v = [-160, +29, -6])
			rotate (a = [0, 90, 0])
				cylinder (h = 200, r = 4);
		translate (v = [-160, 25, -14])
			cube (size = [200, 9, 8]);
		translate (v = [-160, -29, -6])
			rotate (a = [0, 90, 0])
				cylinder (h = 200, r = 4);
		translate (v = [-160, -34, -14])
			cube (size = [200, 9, 8]);
	}
}


$fn=96;
feeder ();

