// Pectoral Cross

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A pectoral cross.  Scale according to your needs when printing.  Rounding
// the corners makes printing on a Rep Rap more forgiving.


// Thickness of cross
T = 5;

// Radius of Minkowski sphere
R = 3;

// Size of hole for ribbon
HOLE_R = 2.0;

// Thickness of first slice
SLICE = 0.4;

// The basic cross

module cross () {
   d = R * 2;
   difference () {
      minkowski () {
         union () {
            // The vertical
            cube (size = [10 - d, 40 - d, T], center = true);
            // The horizontal
            translate (v = [0, 5, 0])
               cube (size = [30 - d, 10 - d, T], center = true);
         }
         sphere (r = R, $fn = 12);
      }
      // Make a flat bottom
      translate (v = [0, 0, -250 - T/2])
         cube (size = [500, 500, 500], center = true);
      // Make a flat top
      translate (v = [0, 0, 250 + T/2])
         cube (size = [500, 500, 500], center = true);
   }
}


// Add a hole for the pectoral cross.  But leave the bottom layer for ease of
// printing - we'll drill it out later.

module pectoral_cross () {
   difference () {
      cross ();
      translate (v = [0, 15, 0])
         cylinder (h = 500, r = HOLE_R, $fn = 12, center = true);
   }
}


pectoral_cross ();
