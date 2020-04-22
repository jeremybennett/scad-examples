// Drilling gide

// Copyright (C) 2020 Jeremy Bennett <www.jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A guide for drilling holes in the WCU enclosure.


// Very small value
EPS = 0.001;

// Very large value
INF = 100;

// M3 dimensions
M3_SCREW_D = 3.0;
M3_NUT_D = 5.5;
M3_NUT_H = 2.5;

// End face dimensions
END_H = 68.5;
END_W = 73.8;

// Hole radius
HOLE_R = 1.5 / 2;

// Corner radius
CORNER_R = 10;

// Hole offset from top
HOLE_OFFSET = 10.0;

// Template depth
TEMPLATE_D = 2.5;

// The wedge is a triangle that touches the bottom of the drill hole
module wedge() {
     cylinder(r = HOLE_OFFSET + HOLE_R, h = TEMPLATE_D * 2, $fn = 3);
}

// The slot ensures the hole is not pinched by the wedge
module slot () {
     cube(size = [HOLE_OFFSET, HOLE_R * 2, TEMPLATE_D * 2]);
}

module hole() {
     cylinder(r = HOLE_R, h = TEMPLATE_D * 2, $fn = 24);
}

// The overall outline is used to clip the corners
module outline() {
     hull() {
	  translate(v = [END_H - CORNER_R, CORNER_R])
	       cylinder(r = CORNER_R, h = TEMPLATE_D * 2, $fn = 24);
	  translate(v = [END_H - CORNER_R, END_W - CORNER_R])
	       cylinder(r = CORNER_R, h = TEMPLATE_D * 2, $fn = 24);
	  translate(v = [0, END_W - CORNER_R])
	       cylinder(r = CORNER_R, h = TEMPLATE_D * 2, $fn = 24);
	  translate(v = [0, CORNER_R])
	       cylinder(r = CORNER_R, h = TEMPLATE_D * 2, $fn = 24);
     }
}

intersection() {
     outline();
     difference () {
	  cube(size = [END_H, END_W, TEMPLATE_D]);
	  translate(v = [0, END_W / 2, -TEMPLATE_D / 2])
	       wedge();
	  translate(v = [0, END_W / 2 - HOLE_R, -TEMPLATE_D / 2])
	       slot();
	  translate(v = [HOLE_OFFSET, END_W / 2, -TEMPLATE_D / 2])
	       hole();
     }
}

