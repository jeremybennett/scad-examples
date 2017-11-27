// Wing bolt

// Copyright (C) 2015 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy@jeremybennett.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// 45678901234567890123456789012345678901234567890123456789012345678901234567890


// Wing bolts are really hard to obtain.  This is a cover for a standard hex
// head M4 bolt, so it can be turned into a wing bolt


// Small amount to ensure overaps when needed
EPS = 0.01;

// Amount around threads, heads etc, to allow for printer overflow
GAP = 0.4;

// Standard constants
M3_SHANK_R = 3.0 / 2 + GAP;
M3_HEAD_R   = 5.5 / 2 + GAP;
M4_SHANK_R = 4.0 / 2 + GAP;
M4_HEAD_R   = 7.0 / 2 + GAP;
M5_SHANK_R = 5.0 / 2 + GAP;
M5_HEAD_R   = 8.0 / 2 + GAP;

// Our specific
SHANK_R = M4_SHANK_R;
HEAD_R  = M4_HEAD_R;
HEAD_H  = 3.0;
HEIGHT  = HEAD_H * 2;

// Main wing shape
module  wing_block () {
    cr = SHANK_R / 2;
    hull () {
        // Left
        translate (v = [SHANK_R * 6, SHANK_R, 0])
            cylinder (r = cr, h = HEIGHT, center = true, $fn = 24);
        translate (v = [SHANK_R * 6, -SHANK_R, 0])
            cylinder (r = cr, h = HEIGHT, center = true, $fn = 24);
        // Center
        translate (v = [0, 2 * SHANK_R, 0])
            cylinder (r = cr, h = HEIGHT, center = true, $fn = 24);
        translate (v = [0, -2 * SHANK_R, 0])
            cylinder (r = cr, h = HEIGHT, center = true, $fn = 24);
        // Right
        translate (v = [-SHANK_R * 6, SHANK_R, 0])
            cylinder (r = cr, h = HEIGHT, center = true, $fn = 24);
        translate (v = [-SHANK_R * 6, -SHANK_R, 0])
            cylinder (r = cr, h = HEIGHT, center = true, $fn = 24);
    }
}


// Bolt hole
module bolt_hole () {
    union () {
        cylinder (r = SHANK_R, h = HEIGHT + EPS, center = true, $fn = 24);
        translate (v = [0, 0, (HEIGHT - HEAD_H) / 2 + EPS])
            cylinder (r = HEAD_R, h = HEAD_H, center = true, $fn = 6);
    }
}


module  wing_bolt () {
    difference () {
        wing_block ();
        bolt_hole ();
    }
}


wing_bolt ();
