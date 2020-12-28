// Library of useful things.

// Copyright (C) 2020 Jeremy Bennett <www.jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

//! @file A library of useful things

//! A small distance
EPS = 0.01;

//! @brief a countersunk screwhole

//! Centered on (X = 0, Y = 0) with top at Z = 0 and extending downwards for
//! 1000mm
//!
//! The countersink height is calculated as:
//!
//!      x - y
//!    ----------
//!    2 tan(B/2)
//!
//! @param thread_diam_outer  Outer diameter of the shank
//! @param head_diam          Diameter of the head
//! @param head_full_angle    Full angle of the countersink

module screwhole (thread_diam_outer, head_diam, head_full_angle) {
     cs_height = (head_diam - thread_diam_outer) /
	  (2 * tan(head_full_angle / 2));
     cs_rim_height = 0.3;

     translate(v = [0, 0, -cs_rim_height])
	  cylinder(r = head_diam / 2, h = cs_rim_height + EPS, center = false,
		   $fn = head_diam * head_diam * 4);
     translate(v = [0, 0, -cs_rim_height - cs_height])
	  cylinder(r1 = thread_diam_outer / 2, r2 = head_diam / 2,
		   h = cs_height + EPS, center = false,
		   $fn = head_diam * head_diam * 4);
     translate(v = [0, 0, -cs_rim_height - cs_height - 1000])
	  cylinder(r = thread_diam_outer / 2, h = 1000 + EPS, center = false,
		   $fn = thread_diam_outer * thread_diam_outer * 4);
}

//! Convenience wrapper for a standard metric screwhold

//! @param thread_diam_outer  Outer diameter of the shank

module metric_screwhole (thread_diam_outer) {
     screwhole (thread_diam_outer, thread_diam_outer * 2, 90.0);
}
