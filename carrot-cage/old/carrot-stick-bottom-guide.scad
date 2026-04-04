// Carrot stick string guide (bottom)

// Copyright (C) 2024 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Set these for different guides

include <carrot-stick-guide-header.scad>

HEIGHT = 13;

GROOVE_H_OFF = 0;
SCREW_H_OFF_L = (HEIGHT + LIP_THICK) / 2;
SCREW_H_OFF_R = HEIGHT / 2;

include <carrot-stick-guide-common.scad>

lip_box ();
