// Carrot stick string guide (top)

// Copyright (C) 2024 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Set these for different guides

include <carrot-stick-guide-header.scad>

BOT_HEIGHT = 8;
HEIGHT = BOT_HEIGHT + CHORD_L + 2;

GROOVE_H_OFF = BOT_HEIGHT + CHORD_L / 2;
SCREW_H_OFF_L = BOT_HEIGHT / 2;
SCREW_H_OFF_R = BOT_HEIGHT / 2;

include <carrot-stick-guide-common.scad>

box ();
