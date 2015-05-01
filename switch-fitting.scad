// Light switch bracket

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// Tiny amount to ensure overlap for simple manifolds
EPS = 0.001;
//BASE_PLATE = true;


// Top plate
module top_plate () {
   difference () {
      intersection () {
         scale (v = [2.2, 1.2, 1])
            cylinder (r = 5, h = 100, center = false, $fn = 48);
         scale (v = [2, 1, 1])
            sphere (r = 25, center = true, $fn = 96);
      }
      scale (v = [2, 1, 1])
         sphere (r = 24, center = true, $fn = 96);
      scale (v = [2, 1, 1])
      translate (v = [0, 0, 24.65])
         cylinder (r = 5, h = 100, center = false, $fn = 48, center = false);
   }
}


// Bottom plate
module bottom_plate () {
   difference () {
      intersection () {
         scale (v = [2, 1, 1])
            cylinder (r = 5, h = 1000, center = false, $fn = 48);
         scale (v = [2, 1, 1])
            sphere (r = 24, center = true, $fn = 96);
      }
      scale (v = [4, 2, 2])
         cube (size = [22, 22, 22], center = true);
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
