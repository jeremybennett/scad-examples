// Sunshade upper clip
//
// Copyright (C) 2019 Jeremy Bennett <www.jeremybennett.com>
// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>
//
// SPDX-License-Identifier: CC-BY-SA-4.0

// A shim to fit a narrow sunshade pole in a larger holder

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

module rim () {
     translate (v = [0, 0, INNER_H])
	  difference () {
	       minkowski () {
		    cylinder (r = OUTER_R - MINK_R, h = RIM_H - MINK_R,
			      center = false, $fn = 72);
	       sphere (r = MINK_R);
	       }
	       translate (v = [0, 0, -INF / 2])
		    cube (size = INF, center = true);
     }
}

module inner_cylinder () {
     translate (v = [0, 0, (INNER_H + EPS) / 2.0])
	  cylinder (r = INNER_R, h = INNER_H + EPS, center = true, $fn= 72);
}

module rib () {
     hull () {
	  translate (v = [INNER_R - EPS, - RIB_W / 2, INNER_H - RIB_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R - EPS, RIB_W / 2, INNER_H - RIB_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R, - RIB_W / 2, INNER_H - RIB_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R, RIB_W / 2, INNER_H - RIB_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R + RIB_D, - RIB_W / 2, INNER_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R + RIB_D, RIB_W / 2, INNER_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R, - RIB_W / 2, INNER_H])
	       sphere (r = EPS);
	  translate (v = [INNER_R, RIB_W / 2, INNER_H])
	       sphere (r = EPS);
     }
}

module rib_set () {
     union () {
	  rotate (a = [0, 0,   0])
	       rib ();
	  rotate (a = [0, 0,  60])
	       rib ();
	  rotate (a = [0, 0, 120])
	       rib ();
	  rotate (a = [0, 0, 180])
	       rib ();
	  rotate (a = [0, 0, 240])
	       rib ();
	  rotate (a = [0, 0, 300])
	       rib ();
     }
}

module upper_clip () {
     difference () {
	  union () {
	       rim();
	       inner_cylinder ();
	       rib_set ();
	  }
	  cylinder (r = POLE_R, h = INF, center = true, $fn= 72);
     }
}

// Have to print upside down
translate (v = [0, 0, RIM_H + INNER_H])
     rotate (a = [180, 0, 0])
	  upper_clip ();
