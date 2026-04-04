// Shave stick holder common code

// Copyright (C) 2023 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// A simple holder with cover for Arko shaving soap sticks.  These soap sticks
// are approximately 82mm long and 33mm in diameter.

// Code common to all components

EPS = 0.01;			// Very small value
INF = 100.0;			// Very large value

STICK_D = 35.0;			// Shave stick diameter
STICK_L = 82.0;			// Shave stick length

WALL = 2.0;			// Thickness of the main wall
OUTER_D1 = STICK_D + WALL * 2.0;
OUTER_D2 = OUTER_D1 + WALL * 2.0;

BASE_THICK = 2.0;		// Thickness of base
BASE_H = 15.0;			// Depth of base
BASE_FLANGE_H = 7.0;		// Height of bottom flange
//CAP_H = 85.0;			// Height of cap excl. cap
CAP_H = 25.0;
CAP_THICK = 1.5;		// Thickness of lid

FIN_THICK = 1.2;		// Thickness of a fin
FIN_W = 5.0;			// Maximum width of a fin

SPACE = 0.10;			// Space for overlap

// Derived
STICK_R = STICK_D / 2.0;
OUTER_R1 = OUTER_D1 / 2.0;
OUTER_R2 = OUTER_D2 / 2.0;

// Reflect -1 is the slice pointing up, +1 is the slice pointing down
module slice (reflect = 1.0) {
     difference () {
	  hull () {
	       ang = atan (BASE_H / STICK_R);
	       translate (v = [0, 0, 0])
		    sphere(r = EPS);
	       rotate (a = [0, 0, -22.5 - reflect * 7.5])
		    translate (v = [INF, 0, 0])
		    sphere (r = EPS);
	       rotate (a = [0, 0, 22.5 + reflect *  7.5])
		    translate (v = [INF, 0, 0])
		    sphere (r = EPS);
	       rotate (a = [0, reflect * ang, -22.5 + reflect * 7.5])
		    translate (v = [INF, 0, 0])
		    sphere (r = EPS);
	       rotate (a = [0, reflect * ang, 22.5 - reflect * 7.5])
		    translate (v = [INF, 0, 0])
		    sphere (r = EPS);
	  };
	  translate (v = [0, 0, -reflect * (BASE_H + EPS + INF / 2)])
	       cube (size = [INF * 2.0, INF * 2.0, INF], center = true);
     }
}

module cutout () {
     union () {
	  slice (-1);
	  rotate (a = [0, 0, 90])
	       slice (-1);
	  rotate (a = [0, 0, 180])
	       slice (-1);
	  rotate (a = [0, 0, 270])
	       slice (-1);
     }
}
