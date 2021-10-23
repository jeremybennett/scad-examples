// Desk clamp for the projector stand

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This is a shim for the desk to hold the pole

// Useful constants
include <constants.scad>

difference () {
     minkowski () {
	  cylinder (r = DESK_HOLE_R, h = DESK_HOLE_H, center = true, $fn = 120);
	  sphere (r = OUTER_ROUND_R, $fn = 24);
     }
     // Inner hole for tube
     cylinder (r = TUBE_R, h = DESK_HOLE_H * 2, center = true, $fn = 120);
     // Outer shape
     difference () {
	  cube (size = [DESK_HOLE_R * 4, DESK_HOLE_R * 4, DESK_HOLE_H],
		center = true);
	  cylinder (r = DESK_HOLE_R, h = DESK_HOLE_H, center = true, $fn = 120);
	  // Ribs
	  for (ang = [0 : 45 : 360])
	       rotate (a = [0, 0, ang])
		    translate (v = [DESK_HOLE_R, 0, 0])
	                 cylinder (r1 = DESK_RIB_R, r2 = DESK_RIB_R / 2.0,
				   h = DESK_HOLE_H, center = true);
     }
     // Cut off to correct depth
     translate (v = [0, 0, DESK_HOLE_H - EPS])
	  cube (size = [DESK_HOLE_R * 4, DESK_HOLE_R * 4, DESK_HOLE_H],
		center = true);
}
