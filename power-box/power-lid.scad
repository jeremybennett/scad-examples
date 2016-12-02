// Box for microusb power breakout.

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A container for a circuit board containing microusb power breakout. This is
// the lid.


PILLAR = 8;
WALL = 3;
PCB_X = 85 + (PILLAR - WALL) * 2;
PCB_Y = 46;
BASE_H = 13;
DELTA = 0.01;
H = 23;
TOP_H = H - BASE_H - WALL * 2;
USB_W = 9;
USB_H = 3;
WIRE_W = 3 * 2.54;
WIRE_H = 2;


module round_cube (x, y, z) {
    hull () {
        translate (v = [-x/2 + 3, -y/2 + 3, 0])
            cylinder (r = 3, h = z, center = true);
        translate (v = [ x/2 - 3, -y/2 + 3, 0])
            cylinder (r = 3, h = z, center = true);
        translate (v = [-x/2 + 3,  y/2 - 3, 0])
            cylinder (r = 3, h = z, center = true);
        translate (v = [ x/2 - 3,  y/2 - 3, 0])
            cylinder (r = 3, h = z, center = true);
        }
}

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

module board_clamp () {
    translate (v = [WALL - DELTA, WALL + 5.5, WALL - DELTA])
        cube (size = [PCB_X + DELTA * 2, 2, TOP_H + DELTA], center = false);
    // Infill
    translate (v = [WALL, WALL + 2, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL, TOP_H + DELTA],
              center = false);
    translate (v = [WALL * 2 + PCB_X - PILLAR, WALL, WALL - DELTA])
        cube (size = [PILLAR - WALL, PILLAR - WALL + 2, TOP_H + DELTA],
              center = false);
}

module wire_clamp () {
    translate (v = [PILLAR - DELTA, WALL + PCB_Y - 5, WALL - DELTA])
        cube (size = [PCB_X - (PILLAR -WALL) * 2 + DELTA * 2, 3,
  	              TOP_H + 2 + DELTA], center = false);
}

module hole () {
    union () {
        cylinder (h = WALL + TOP_H + DELTA * 2, r = 1.7, $fn = 24,
                  center = false);
        cylinder (h = 3 + DELTA, r = 3, $fn = 24, center = false);
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

module wire_hole () {
    cube (size = [WIRE_W, WALL * 2, WIRE_H + DELTA], center = false);
}

module wire_holes () {
    // Spaced 5 .1" holdes appart
    translate (v = [PCB_X / 2 + WALL - WIRE_W - 11 * 2.54,
                    PCB_Y + WALL/2, WALL + TOP_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL - WIRE_W - 6 * 2.54,
                    PCB_Y + WALL/2, WALL + TOP_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL - WIRE_W - 1 * 2.54,
                    PCB_Y + WALL/2, WALL + TOP_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL + 1 * 2.54,
                    PCB_Y + WALL/2, WALL + TOP_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL + 6 * 2.54,
                    PCB_Y + WALL/2, WALL + TOP_H - WIRE_H])
        wire_hole ();
    translate (v = [PCB_X / 2 + WALL + 11 * 2.54,
                    PCB_Y + WALL/2, WALL + TOP_H - WIRE_H])
        wire_hole ();
}
module power_lid_base () {
    union () {
        sides ();
        base ();
        pillars ();
	board_clamp ();
	wire_clamp ();
    }
}

module power_lid () {
    difference () {
        power_lid_base ();
        holes ();
        usb_holes ();
	wire_holes ();
    }
}

power_lid ();
