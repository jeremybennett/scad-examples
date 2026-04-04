// Carrot stick string guide

// Copyright (C) 2024 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

include <../lib/screw-hole.scad>

EPS =   0.01;			// Very small value
INF = 500.00;			// Very large value

LIP_THICK = 3.0;
LIP_WIDTH = 10.0;
WALL_THICK = 3.0;
GROOVE_D = 4.0;
CHORD_L = sqrt(3.0) * GROOVE_D / 2.0;

// These are common to all guides.  There are two types of stick, one with
// 26x23 and one 19.5 x 27.5
// LENGTH = 26;
// WIDTH = 23;
LENGTH = 27.5;
WIDTH = 19.5;
