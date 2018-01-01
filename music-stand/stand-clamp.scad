// Music stand clamp

// Copyright (C) 2015 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy@jeremybennett.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// 45678901234567890123456789012345678901234567890123456789012345678901234567890


// This clamp was designed to stop my music stand legs splaying around after
// its original locking screw stripped its thread.  But it would work for any
// situation where you need a lockable clamp on a bar.

// It is designed for any situation where you cannot slip the clamp over the
// end of the bar, so the clamp must be in two halves.

// In the main design, the hole for the main bar is horizontal, so all the
// other holes etc are vertical, thereby reducing the number of cylinders
// needing rotating.  The final parts are rotated for ease of printing.


// Small amount to ensure overaps when needed
EPS = 0.001;

// Amount around shanks, heads etc, to allow for printer overflow
GAP = 0.4;

// Standard constants
M3_SHANK_R = 3.0 / 2 + GAP;
M3_HEAD_R   = 5.5 / 2 + GAP;
M4_SHANK_R = 4.0 / 2 + GAP;
M4_HEAD_R   = 7.0 / 2 + GAP;
M5_SHANK_R = 5.0 / 2 + GAP;
M5_HEAD_R   = 8.0 / 2 + GAP;

// Constants defining the design
SHANK_R = M3_SHANK_R;                 // Main construction bolts
HEAD_R   = M3_HEAD_R;
HEAD_H   = 3.5;
NUT_H    = 2.5;
LENGTH   = 20.0;

WING_SHANK_R = M4_SHANK_R;            // Wing bolt for locking
WING_HEAD_R   = M4_HEAD_R;

LENGTH  = 30.0;                       // Block dimensions
BREADTH = 30.0;
DEPTH   = 20.0;

//BAR_D = 10.9;                         // Jeremy's music stand
BAR_D = 13.0;                         // Lucy's music stand

BAR_R = BAR_D / 2 + GAP * 2;         // The main bar being clamped


// The basic block with a horizontal hole in it
module block () {
    difference () {
        cube (size = [LENGTH, BREADTH, DEPTH], center = true);
        rotate (a = [0, 90, 0])
            cylinder (r = BAR_R, h = LENGTH * 2, center = true, $fn = 48);
    }
}


// A bolt hole, with space for the head
module bolt_hole () {
    union () {
        cylinder (r = SHANK_R, h = DEPTH + EPS, center = true, $fn = 24);
        translate (v = [0, 0, (DEPTH - HEAD_H) / 2 + EPS])
            cylinder (r = HEAD_R, h = HEAD_H, center = true, $fn = 48);
        translate (v = [0, 0, - (DEPTH - NUT_H) / 2 - EPS])
            cylinder (r = HEAD_R, h = NUT_H, center = true, $fn = 6);
    }
}

// Set of bolts
module bolts () {
    b_off = (BREADTH + 2 * BAR_R) / 4;
    l_off = LENGTH / 4;
    translate (v = [ l_off,  b_off , 0])
        bolt_hole ();
    translate (v = [ l_off, -b_off , 0])
        bolt_hole ();
    translate (v = [-l_off,  b_off , 0])
        bolt_hole ();
    translate (v = [-l_off, -b_off , 0])
        bolt_hole ();
}


// Wing nut and bolt tighener
module wing () {
    union () {
        cylinder (r = WING_SHANK_R, h = DEPTH, center = false, $fn = 24);
        cylinder (r = WING_HEAD_R, h = NUT_H + BAR_R, center = false, $fn = 6);
    }
}


// The clamp proper
module clamp () {
    difference () {
        block ();
        bolts ();
        wing ();
    }
}


// Top half of clamp
module clamp_top () {
    intersection () {
        clamp ();
        translate (v = [0, 0, DEPTH])
            cube (size = [LENGTH * 2, BREADTH * 2, DEPTH *2], center = true);
    }
}


// Bottom half of clamp
module clamp_bottom () {
    intersection () {
        clamp ();
        translate (v = [0, 0, -DEPTH])
             cube (size = [LENGTH * 2, BREADTH * 2, DEPTH *2], center = true);
    }
}


// Invert for printing
translate (v = [0, BREADTH / 2 + 2, DEPTH / 2])
     rotate (a = [180, 0, 0])
          clamp_top ();

translate (v = [0, -BREADTH / 2 - 2, DEPTH / 2])
     clamp_bottom ();
