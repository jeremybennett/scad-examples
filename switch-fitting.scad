// Light switch bracket

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// Tiny amount to ensure overlap for simple manifolds
EPS = 0.001;


// Top plate
module top_plate () {
   difference () {
      intersection () {
         scale (v = [2.2, 1.2, 1])
            cylinder (r = 5, h = 1000, center = false, $fn = 12);
         scale (v = [2, 1, 1])
            sphere (r = 50, center = true, $fn = 96);
      }
      scale (v = [2, 1, 1])
         sphere (r = 49, center = true, $fn = 96);
   }
}


// Bottom plate
module bottom_plate () {
   difference () {
      intersection () {
         scale (v = [2, 1, 1])
            cylinder (r = 5, h = 1000, center = false, $fn = 12);
         scale (v = [2, 1, 1])
            sphere (r = 49, center = true, $fn = 96);
      }
      scale (v = [4, 2, 2])
         cube (size = [47, 47, 47], center =true);
   }
}


// Hole for the socket
module bracket () {
   difference () {
      union () {
         top_plate ();
         bottom_plate ();
      }
      cylinder (r = 3, h = 1000, center = false, $fn = 12);
   }
}

bracket ();

