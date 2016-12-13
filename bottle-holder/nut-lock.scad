// Bolt holder for Topeak adjustable bottle cage

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// This is the lock for the outer nut.

include <nut-header.scad>


module slot () {
    translate (v = [50, 0, 1 + LOCK_NUT_H / 2])
        cube (size = [100 + LOCK_NUT_X, LOCK_NUT_Y, LOCK_NUT_H],
              center = true);
}

module hole () {
    translate (v = [0, 0, -DELTA])
        cylinder (r = HOLE_D / 2, h = HANDLE_H + LOCK_H + DELTA * 2,
                  $fn = 24, center = false);
}

module nut_lock_block () {
    union () {
         translate (v = [ 0, 0,
                         LUG_H / 2 + LOCK_H - DELTA  ])
            cube (size = [WASHER_D, HANDLE_Y, HANDLE_H], center = true);
        cylinder (r = WASHER_D / 2, h = LOCK_H, $fn = 48,
                  center = false);
    }
}

module nut_lock () {
    difference () {
        nut_lock_block ();
        slot ();
        hole ();
    }
}

nut_lock ();
