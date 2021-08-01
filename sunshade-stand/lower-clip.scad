// Sunshade lower clip
//
// Copyright (C) 2019 Jeremy Bennett <www.jeremybennett.com>
// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>
//
// SPDX-License-Identifier: CC-BY-SA-4.0

// A shim to fit a narrow sunshade pole in a larger holder

// The 3D printer is calibrated so that X-Y are around 2% too small, sizes are
// adjusted accordingly

OUTER_CONE_H = 27.3;
OUTER_UPPER_R = 50.4 / 2.0;	// Measured 49.3
OUTER_LOWER_R = 29.6 / 2.0;	// Measured 29.0

POLE_CONE_H = 37.0;
POLE_UPPER_R = 25.9 / 2.0;	// Actual 25.3
POLE_LOWER_R = 16.8 / 2.0;	// Actual 16.4

MINK_R = 2.0;
RIM_H = 4.0;
INNER_H = 25.0;
RIB_H = 20.0;
RIB_W = 2.0;
RIB_D = 1.5;
OUTER_R = 60.0 / 2.0;
INNER_R = 53.0 / 2.0;
POLE_R = 25.3 / 2.0;

// Very small value
EPS = 0.01;

// Very large value
INF = 1000.0;

module outer_cone () {
     union () {
	  cylinder (r = OUTER_UPPER_R, h = POLE_CONE_H - OUTER_CONE_H + EPS,
		    center = false, $fn = 72);
	  translate (v = [0, 0, POLE_CONE_H - OUTER_CONE_H])
	       cylinder (r1 = OUTER_UPPER_R, r2 = OUTER_LOWER_R,
			 h = OUTER_CONE_H, center = false, $fn = 72);
     }
}

module inner_cone () {
     translate (v = [0, 0, -EPS])
	  cylinder (r1 = POLE_UPPER_R, r2 = POLE_LOWER_R,
		    h = POLE_CONE_H + 2 * EPS, center = false, $fn = 72);
}

module lower_clip () {
     difference () {
	  outer_cone ();
	  inner_cone ();
     }
}

lower_clip ();
