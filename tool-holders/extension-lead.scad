// A holder for a plug

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0


// Small amount
EPS = 0.1;

// Calculate the arc we are using
ARC_H = 8.0;
ARC_W = 90.0;
RADIUS = (ARC_H / 2.0) + ((ARC_W * ARC_W) / (8.0 * ARC_H));
CUT_OFFSET = RADIUS - 10.0 - ARC_H;

// Dimensions of a 4mm wood screew

HEAD_DIAM  = 7.5;                   // x
SHANK_DIAM = 4.0;                   // y
HEAD_ANGLE = 100.0;                 // B - not used explicitly

// The countersink height is calculated as:
//
//      x - y
//    ----------
//    2 tan(B/2)

// Table of 2 tan(B/2) for various B
//
//  60    1.1547
//  82    1.7386
//  90    2.0000
// 100    2.3835
// 110    2.8563

CS_HEIGHT = 1.47;
CS_RIM_HEIGHT = 0.3;

// Screw height
SCREW_HEIGHT = 100;

// Hole for a countersink screw
module cs_hole() {
     translate(v = [0, 0, -CS_RIM_HEIGHT])
	  cylinder(r = HEAD_DIAM / 2, h = CS_RIM_HEIGHT + EPS, center = false,
		   $fn = 45);
     translate(v = [0, 0, -CS_HEIGHT - CS_RIM_HEIGHT])
	  cylinder(r1 = SHANK_DIAM / 2, r2 = HEAD_DIAM / 2, h = CS_HEIGHT,
		   center = false, $fn = 45);
     cylinder(r = SHANK_DIAM / 2, h = SCREW_HEIGHT, center = true, $fn = 45);
}


// The basic arc
module arc (height, off) {
     translate (v = [-off, 0, height/2])
	  intersection () {
	       cylinder (r = RADIUS, h = height, center = true, $fn = 360);
	       translate (v = [off + 500, 0, 0])
		    cube (size = [1000,ARC_W,1000], center = true);
          }
}

// The stand without its screw holes
module holder () {
     arc (height = 60, off = CUT_OFFSET);
     arc (height = 20, off = CUT_OFFSET - 20);
     translate (v = [0, 0, 55])
	  arc (height = 5, off = CUT_OFFSET - 3);
}

difference () {
     holder ();
     translate (v = [22.5, 35, 20])
          cs_hole ();
     translate (v = [22.5, -35, 20])
          cs_hole ();
     translate (v = [28.0, 0, 20])
          cs_hole ();
}
