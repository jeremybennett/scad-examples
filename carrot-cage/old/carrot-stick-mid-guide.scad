// Carrot stick string guide (middle)

// Copyright (C) 2024 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Set these for different guides

include <carrot-stick-guide-header.scad>

HEIGHT = 20;

GROOVE_H_OFF = HEIGHT / 2;
SCREW_H_OFF_L = (HEIGHT - CHORD_L) / 4;
SCREW_H_OFF_R = (3 * HEIGHT + CHORD_L) / 4;

include <carrot-stick-guide-common.scad>

box ();
