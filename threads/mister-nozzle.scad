// A threaded nozzle for a mister

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This uses the bolts, nuts and threaded rods library by Rudolf Huttary (aka
// Parkinbot).

use <Threading.scad>

OD = 13.0;
NOZZLE_D = OD + 1.5;

union () {
     Threading (D = NOZZLE_D, d = OD, pitch = 8.0 / 6.0, windings = 10,
		angle = 20, edges = 40, $fn = 40);
     difference () {
	  translate (v = [0, 0, -2])
	       cylinder (h = 2, r = NOZZLE_D / 2, center = false, $fn = 40);
	  translate (v = [0, 0, -3])
	       cylinder (h = 3, r= 0.7, center = false, $fn = 40);
     }
}
