// Block to fix drawer in office

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// Size is 70 x 10 x10 mm, with holes at right angles

// - at 20mm and 60mm for M4 12mm pan head bolts
// - at 10mm and 50mm for 3.0 x 20mm wood screws

// and mirrored for the other side.

L = 70;
W = 10;
H = 10;

PAD = 0.2;
PAD2 = PAD * 2;
DELTA = 0.1;
DELTA2 = DELTA * 2;

BOLT_R = 4.0 / 2 + PAD;
BOLT_HEAD_R = 8.0 / 2 + PAD;
BOLT_HEAD_H = 3.0 + PAD;

SCREW_R = 3.0 / 2 + PAD;
SCREW_HEAD_R = 6.0 / 2 + PAD;
SCREW_HEAD_H = 1.5 + PAD;


module block () {
    cube (size = [L, W, H], center = false);
}

module bolt_hole (x_off) {
    translate (v = [x_off, H / 2, -DELTA])
        cylinder (r = BOLT_R, h = H + DELTA2, $fn = 24, center = false);
    translate (v = [x_off, H / 2, H - BOLT_HEAD_H])
        cylinder (r = BOLT_HEAD_R, h = BOLT_HEAD_H + DELTA, $fn = 24,
                  center = false);
}

module screw_hole (x_off) {
    translate (v = [x_off, -DELTA, W / 2])
        rotate (a = [-90, 0, 0])
            cylinder (r = SCREW_R, h = W + DELTA2, $fn = 24, center = false);
    translate (v = [x_off, W - SCREW_HEAD_H, W / 2])
        rotate (a = [-90, 0, 0])
            cylinder (r1 = SCREW_R, r2 = SCREW_HEAD_R,
                      h = SCREW_HEAD_H + DELTA, $fn = 24, center = false);
}

module fitting (bolt_off1, bolt_off2, screw_off1, screw_off2) {
    difference () {
        block ();
        bolt_hole (bolt_off1);
        bolt_hole (bolt_off2);
        screw_hole (screw_off1);
        screw_hole (screw_off2);
    }
}


module fitting_pair () {
    fitting (20, 60, 10, 50);                   // Left side
    translate (v = [0, 20, 0])
        fitting (10, 50, 20, 60);               // Right side
}

fitting_pair ();

// Local Variables:
// indent-tabs-mode: nil
// End:
