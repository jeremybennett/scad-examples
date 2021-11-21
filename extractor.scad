// Simple clamp for unclipping a connector

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// We have a connector which needs two prongs 17 mm apart to release.


EPS = 0.01;
CAP_H = 10.0;
BLOCK_H = 40.0;
COLLAR_H = 10.0;
BLOCK_R = 14.0;
HOLE_H = BLOCK_H + 1.0;
HOLE_R = 3.04;
FLAT_H = 1.25;
ROUND_H = 2.0 - FLAT_H;
HOLE_W = 4.0;
SPIKE_GAP = 17.0;
MINK_PAD_R = 0.15;

module spike_hole (a) {
    rotate (a = [0, 0, a])
     translate (v = [0, ROUND_H - HOLE_R + FLAT_H + MINK_PAD_R, 0])
	  minkowski () {
               union () {
		    difference () {
			 cylinder (h = HOLE_H, r = HOLE_R, center = true,
				   $fn = 24);
			 translate (v = [0, -5 + HOLE_R - ROUND_H, 0])
			      cube (size = [10, 10, HOLE_H + EPS],
				    center = true);
		    }
		    translate (v = [0, HOLE_R - ROUND_H - FLAT_H / 2 + EPS, 0])
			 cube (size = [4.0, FLAT_H, HOLE_H], center = true);
	       }
	       cylinder (h = EPS, r = MINK_PAD_R, $fn = 24);
     }
}

module spike_holes () {
     translate (v = [0, -SPIKE_GAP / 2.0])
          spike_hole (-30);
     translate (v = [0, SPIKE_GAP / 2.0])
          rotate (a = [0, 0, 180])
               spike_hole (30);
}

module block () {
     translate (v = [0, 0, EPS - BLOCK_H / 2])
	  cylinder (h = CAP_H, r = BLOCK_R, $fn = 96, center = true);
     difference () {
	  cylinder (h = BLOCK_H, r = BLOCK_R, $fn = 96, center = true);
	  spike_holes ();
     }
}

module collar () {
     difference () {
	  cylinder (h = COLLAR_H, r = BLOCK_R, $fn = 96, center = true);
	  spike_holes ();
     }
}

//block ();
collar ();
