// Light switch bracket

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// Tiny amount to ensure overlap for simple manifolds
EPS = 0.001;

// Define BASE_PLATE = true on the command line to print the base plate
// instead.


// Top plate
module top_plate () {
   difference () {
      intersection () {
         scale (v = [2.2, 1.2, 1])
            cylinder (r = 5, h = 100, center = false, $fn = 48);
         cube (size = [50, 50, 50], center = true);
      }
      cube (size = [50, 50, 48], center = true);
      translate (v = [-6.5, 0, 24.5])
         cube (size = [1, 2.2, 2], center = true);
   }
}


// Bottom plate
module bottom_plate () {
   difference () {
      intersection () {
         scale (v = [2, 1, 1])
            cylinder (r = 5, h = 1000, center = false, $fn = 48);
         cube (size = [50, 50, 48], center = true);
      }
      scale (v = [2, 1, 1])
         cube (size = [44, 44, 44], center = true);
   }
}

// Base plate
module base_plate () {
   difference () {
      scale (v = [2.2, 1.2, 1])
         cylinder (r = 5, h = 100, center = false, $fn = 48);
      translate (v = [0, 0, 51])
         cube (size = [100, 100, 100], center = true);
      cylinder (r = 3.2, h = 1000, center = true, $fn = 48);
      translate (v = [0, 5.5, 0])
         cube (size = [2, 2, 10], center = true);
      translate (v = [0, -5.5, 0])
         cube (size = [2, 2, 10], center = true);
   }
}


// Hole for the socket
module bracket () {
   rotate (a = [0, 180, 0])
      translate (v = [0, 0, -22]) {
         difference () {
            union () {
               top_plate ();
               bottom_plate ();
            }
            cylinder (r = 3.2, h = 1000, center = false, $fn = 48);
         }
      }
}


if (BASE_PLATE) {
   base_plate ();
} else {
   bracket ();
}
