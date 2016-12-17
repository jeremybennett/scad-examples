// Christmas star

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A star of David incorporating a Cuttlefish. This is the generic half

HOLE_R = 1.8;
HEAD_R = 3.5;
SPACER_H = 8;

DELTA = 0.1;

module spacer () {
    difference () {
        minkowski () {
            cylinder (r = 4, h = SPACER_H, $fn = 3, center = true);
            cylinder (r = 1.5, $fn = 24);
        }
        cylinder (r = HOLE_R, h = SPACER_H +1.5 * 2 + DELTA, $fn = 24,
                  center = true);
    }
}

spacer ();
