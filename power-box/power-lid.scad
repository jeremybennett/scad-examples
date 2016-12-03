// Box for microusb power breakout.

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A container for a circuit board containing microusb power breakout. This is
// the lid.

include <pillar-all.scad>

module sides () {
    translate (v = [PCB_X / 2 + WALL, PCB_Y / 2 + WALL, (TOP_H + WALL) / 2])
        difference () {
            round_cube (PCB_X + WALL * 2, PCB_Y + WALL * 2, TOP_H + WALL);
            round_cube (PCB_X, PCB_Y, TOP_H + WALL + DELTA);
        }
}

module base () {
    translate (v = [PCB_X / 2 + WALL, PCB_Y / 2 + WALL, WALL / 2])
        round_cube (PCB_X + WALL * 2, PCB_Y + WALL * 2, WALL);
}

module pillars () {
    translate (v = [WALL, WALL, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, TOP_H + DELTA],
              center = false);
    translate (v = [WALL * 2 + PCB_X - PILLAR, WALL, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, TOP_H + DELTA],
              center = false);
    translate (v = [WALL, WALL * 2 + PCB_Y - PILLAR, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, TOP_H + DELTA],
              center = false);
    translate (v = [WALL * 2 + PCB_X - PILLAR,
                    WALL * 2 + PCB_Y - PILLAR, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, TOP_H + DELTA],
              center = false);
}

module usb_clamp () {
    translate (v = [WALL - DELTA, WALL + 5.5, WALL - DELTA])
        cube (size = [PCB_X + DELTA * 2, 2, TOP_H + DELTA], center = false);
}

module board_clamp () {
    translate (v = [WALL - DELTA, WALL + 12, WALL - DELTA])
        cube (size = [PCB_X + DELTA * 2, 3, TOP_H + 3 + DELTA], center = false);
}

module wire_clamp () {
    translate (v = [PILLAR - DELTA, WALL + PCB_Y - 7, WALL - DELTA])
        cube (size = [PCB_X - (PILLAR -WALL) * 2 + DELTA * 2, 3,
  	              TOP_H + 2 + DELTA], center = false);
}

module hole () {
    union () {
        cylinder (h = WALL + BASE_H + DELTA * 2, r = M3_R, $fn = 24,
                  center = false);
        cylinder (h = M3_HEAD_H + DELTA, r = M3_HEAD_R, $fn = 24,
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

module usb_hole () {
    cube (size = [USB_W, WALL * 2, USB_H + DELTA], center = false);
}

module usb_holes () {
    translate (v = [PCB_X / 2 + WALL - USB_W / 2,
                    -WALL/2, WALL + TOP_H - USB_H])
        usb_hole ();
    // others are 9 .1" holes to the left and the right
    translate (v = [PCB_X / 2 + WALL - USB_W / 2 - 9 * 2.54,
                    -WALL/2, WALL + TOP_H - USB_H])
        usb_hole ();
    translate (v = [PCB_X / 2 + WALL - USB_W / 2 + 9 * 2.54,
                    -WALL/2, WALL + TOP_H - USB_H])
        usb_hole ();
}

module power_lid_base () {
    union () {
        sides ();
        base ();
        pillars ();
	usb_clamp ();
	board_clamp ();
	wire_clamp ();
    }
}

module power_lid () {
    difference () {
        power_lid_base ();
        holes ();
        usb_holes ();
    }
}

power_lid ();
