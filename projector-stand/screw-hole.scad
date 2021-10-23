// Generic screw holder

// Copyright (C) 2021 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0


// The countersink height is calculated as:
//
//      x - y
//    ----------
//    2 tan(B/2)
//
// where x is the head diameter, y is the shank diameter and B is the head
// angle (100 degrees for DIN 7997x I believe).
//
// Table of 2 tan(B/2) for various B
//
//  60    1.1547
//  82    1.7386
//  90    2.0000
// 100    2.3835
// 110    2.8563

// Small amount
CS_EPS = 0.1;

// Height of rim above countersink
CS_RIM_HEIGHT = 0.3;

// Screw height - effectively infinite!
SCREW_HEIGHT = 100;

// Table of screw dimensions for DIN 7997z countersunk wood screws
// Entry is thread diameter, head diameter, head height.
SCREW_TAB = [ [2.5,  4.7, 1.50],
	      [3.0,  5.6, 1.65],
	      [3.5,  6.5, 1.93],
	      [4.0,  7.5, 2.20],
	      [4.5,  8.3, 2.35],
	      [5.0,  9.2, 2.50],
	      [5.5, 10.2, 2.75],
	      [6.0, 11.0, 3.00],
              [0.0,  0.0, 0.00] ];		// End marker

// Recursively look up dimensions in the SCREW_TAB
function recursive_screw_dims (diam, n) =
     ( (SCREW_TAB[n][0] == 0.0) ? SCREW_TAB[n] :
       (SCREW_TAB[n][0] == diam) ? SCREW_TAB[n] :
       recursive_screw_dims (diam, n + 1) );

// Look up a screw's dimensions
function screw_dims (diam = 4.0) = recursive_screw_dims (diam, 0);

// Hole for a countersink screw
module screw_hole (shank_diam, invert = true) {
     let (dims = screw_dims (shank_diam),
	  head_diam = dims[1],
	  cs_height = dims[2],
	  screw_angle = invert ? 180 : 0) {
	  rotate (a = [0, screw_angle, 0]) {
	       cylinder(r = head_diam / 2, h = CS_RIM_HEIGHT + CS_EPS,
			center = false, $fn = 45);
	       translate(v = [0, 0, CS_RIM_HEIGHT])
	            cylinder(r1 = head_diam / 2, r2 = shank_diam / 2,
			     h = cs_height, center = false, $fn = 45);
	       cylinder(r = shank_diam / 2, h = SCREW_HEIGHT, center = false,
			$fn = 45);
	  }
     }
}
