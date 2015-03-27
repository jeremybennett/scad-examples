// Roller blinkd holder

// Copyright (C) 2015 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy@jeremybennett.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

EPS = 0.0001;


module back () {
   translate (v = [0.0, 7.0 - EPS, 0.0])
   cube (size = [31.3, 55.9 - (31.3 / 2) - 7.0, 2.8], center = false);
   translate (v = [31.3 / 2, 55.9 - (31.3 / 2)])
      cylinder(r = 31.3 / 2, h = 2.8, center = false);
}


module knob () {
   translate (v = [(31.3 - 8.2) / 2, 35.2, 2.8])
      difference () {
         cube (size = [8.2, 8.2, 7.1], center = false);
         translate (v = [8.2 / 2, 8.2 / 2, 0])
            cylinder (r = 1.8, h = 7.1, center = false, $fn = 24);
      }
}

module bottom () {
   difference () {
      cube (size = [31.3, 7, 18.8], center = false);
      translate (v = [2.5, 1.5, 0.0])
         cube (size = [8.0, 3.8, 16.6], center = false);
      translate (v = [5.0, 0.0, 0.0])
         cube (size = [3.0, 1.5, 14.1], center = false);
      translate (v = [31.3 - 2.5 - 8.0, 1.5, 0.0])
         cube (size = [8.0, 3.8, 16.6], center = false);
      translate (v = [31.3 - 5.0 - 3.0, 0.0, 0.0])
         cube (size = [3.0, 1.5, 14.1], center = false);
   }
}

back ();
knob ();
bottom ();