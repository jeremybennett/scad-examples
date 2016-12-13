// Bolt holder for Topeak adjustable bottle cage

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// This is the holder for the inner nut

include <nut-header.scad>


module hole () {
    translate (v = [0, 0, -DELTA])
        cylinder (r = HOLE_D / 2, h = HOLE_H + NUT_H + DELTA * 2, $fn = 24,
                  center = false);
    cylinder (r = NUT_D / 2, h = NUT_H, $fn = 6, center = false);
}

module nut_block () {
    scale (v = [BLOCK_D_X / BLOCK_D_Y, 1.0, 1.0])
        cylinder (r = BLOCK_D_Y / 2, h = HOLE_H + NUT_H, $fn = 24,
                  center = false);
}

module nut_holder () {
    rotate (a = [180, 0, 0])
        difference () {
            nut_block ();
            hole ();
        }
}

nut_holder ();
