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
     cylinder (r = TUBE_R, h = DESK_HOLE_H * 2, center = true, $fn = 120);
     difference () {
	  cube (size = [DESK_HOLE_R * 4, DESK_HOLE_R * 4, DESK_HOLE_H],
		center = true);
	  cylinder (r = DESK_HOLE_R, h = DESK_HOLE_H, center = true, $fn = 120);
     }
     translate (v = [0, 0, DESK_HOLE_H - EPS])
	  cube (size = [DESK_HOLE_R * 4, DESK_HOLE_R * 4, DESK_HOLE_H],
		center = true);
}
