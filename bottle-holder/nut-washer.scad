// Bolt holder for Topeak adjustable bottle cage

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// This is the washer for the outer nut.

include <nut-header.scad>


module hole () {
    translate (v = [0, 0, -DELTA])
        cylinder (r = HOLE_D / 2, h = WASHER_H + DELTA * 2, $fn = 24,
                  center = false);
}

module washer_block () {
    union () {
         translate (v = [(WASHER_D + HOLE_D) / 4, 0,
                         LUG_H / 2 + WASHER_H - DELTA  ])
            cube (size = [LUG_X, LUG_Y, LUG_H], center = true);
        translate (v = [-(WASHER_D + HOLE_D) / 4, 0,
                        LUG_H / 2 + WASHER_H - DELTA  ])
            cube (size = [LUG_X, LUG_Y, LUG_H], center = true);
        cylinder (r = WASHER_D / 2, h = WASHER_H, $fn = 48,
                  center = false);
    }
}

module washer () {
    difference () {
        washer_block ();
        hole ();
    }
}

washer ();
