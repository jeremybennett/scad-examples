// A threaded join for a ribbed hose pipe

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This uses the bolts, nuts and threaded rods library by Rudolf Huttary (aka
// Parkinbot).

use <Threading.scad>

Threading (D = 45, d = 39, pitch = 5, windings = 5, angle = 60, edges = 120,
	   $fn = 120, left = true);
