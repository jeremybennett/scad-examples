// Box for microusb power breakout.

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A container for a circuit board containing microusb power breakout. This is
// the base.

include <pillar-all.scad>

module sides () {
    translate (v = [PCB_X / 2 + WALL, PCB_Y / 2 + WALL, (BASE_H + WALL) / 2])
        difference () {
            round_cube (PCB_X + WALL * 2, PCB_Y + WALL * 2, BASE_H + WALL);
            round_cube (PCB_X, PCB_Y, BASE_H + WALL + DELTA);
        }
}

module base () {
    translate (v = [PCB_X / 2 + WALL, PCB_Y / 2 + WALL, WALL / 2])
        round_cube (PCB_X + WALL * 2, PCB_Y + WALL * 2, WALL);
}


module pillars () {
    translate (v = [WALL, WALL, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, BASE_H + DELTA],
              center = false);
    translate (v = [WALL * 2 + PCB_X - PILLAR, WALL, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, BASE_H + DELTA],
              center = false);
    translate (v = [WALL, WALL * 2 + PCB_Y - PILLAR, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, BASE_H + DELTA],
              center = false);
    translate (v = [WALL * 2 + PCB_X - PILLAR,
                    WALL * 2 + PCB_Y - PILLAR, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, BASE_H + DELTA],
              center = false);
}

module hole () {
    union () {
        cylinder (h = WALL + BASE_H + DELTA * 2, r = M3_R, $fn = 24,
                  center = false);
        cylinder (h = M3_NUT_H + DELTA, r = M3_HEAD_R, $fn = 6,
                  center = false);
    }
}

module holes () {
    union () {
        translate (v = [PILLAR / 2, PILLAR / 2, -DELTA])
            hole ();
        translate (v = [WALL * 2 + PCB_X - PILLAR / 2, PILLAR / 2, -DELTA])
            hole ();
        translate (v = [PILLAR / 2, WALL * 2 + PCB_Y - PILLAR / 2, -DELTA])
            hole ();
        translate (v = [WALL * 2 + PCB_X - PILLAR / 2,
                        WALL * 2+ PCB_Y - PILLAR / 2, -DELTA])
            hole ();
    }
}

module wire_hole () {
    cube (size = [WIRE_W, WALL * 2, WIRE_H + DELTA], center = false);
}

module wire_holes () {
    // Spaced 5 .1" holdes appart
    translate (v = [PCB_X / 2 + WALL - WIRE_W - 11 * 2.54,
                    PCB_Y + WALL/2, WALL + BASE_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL - WIRE_W - 6 * 2.54,
                    PCB_Y + WALL/2, WALL + BASE_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL - WIRE_W - 1 * 2.54,
                    PCB_Y + WALL/2, WALL + BASE_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL + 1 * 2.54,
                    PCB_Y + WALL/2, WALL + BASE_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL + 6 * 2.54,
                    PCB_Y + WALL/2, WALL + BASE_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL + 11 * 2.54,
                    PCB_Y + WALL/2, WALL + BASE_H - WIRE_H])
        wire_hole ();
}

module power_box_base () {
    union () {
        sides ();
        base ();
        pillars ();
    }
}

module power_box () {
    difference () {
        power_box_base ();
        holes ();
	wire_holes ();
    }
}

power_box ();
