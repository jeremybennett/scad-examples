// Small picture frame clip

// Copyright (C) 2020 Jeremy Bennett <www.jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


EPS = 0.1;

// Dimensions of a 3/8" no 3 wood screw

HEAD_DIAM = 0.199 * 25.4;           // x
SHANK_DIAM = 0.099 * 25.4;          // y
HEAD_ANGLE = 100.0;                 // B - not used explicitly

// The countersink height is calculated as:
//
//      x - y
//    ----------
//    2 tan(B/2)

CS_HEIGHT = 1.065656532;
CS_RIM_HEIGHT = 0.3;

// Clip dimensions
CLIP_H = 1.5;
CLIP_L = 8.0;
CLIP_MAJOR_D = 6.0;
CLIP_MINOR_D = 2.0;

// Hole for a countersink screw
module cs_hole() {
     translate(v = [0, 0, CS_HEIGHT])
	  cylinder(r = HEAD_DIAM / 2, h = CS_RIM_HEIGHT + EPS, center = false,
		   $fn = 45);
     cylinder(r1 = SHANK_DIAM / 2, r2 = HEAD_DIAM / 2, h = CS_HEIGHT,
	      center = false, $fn = 45);
     cylinder(r = SHANK_DIAM / 2, h = CLIP_H * 3, center = true, $fn = 45);
}

// plain clip
module clip() {
     hull() {
	  translate(v = [-CLIP_L / 2, 0, 0])
	       cylinder(r = CLIP_MAJOR_D / 2, h = CLIP_H, center = false,
			$fn = 90);
	  translate(v = [CLIP_L / 2, 0, 0])
	       cylinder(r = CLIP_MINOR_D / 2, h = CLIP_H, center = false,
			$fn = 90);
     }
}

difference() {
     clip();
     translate(v = [-CLIP_L / 2, 0, CLIP_H - CS_HEIGHT - CS_RIM_HEIGHT])
	  cs_hole();
}

