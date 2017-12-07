// Box for microusb power breakout.

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A container for a circuit board containing microusb power breakout. This is
// the base.

include <pillar-all1.scad>

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

     // Corners

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

     // Supports

     translate (v = [15, 14, 0])
	  cylinder (r = M3_HEAD_R, h = WALL + 3, $fn=24, center = false);
     translate (v = [15 + 88.5, 14, 0])
	  cylinder (r = M3_HEAD_R, h = WALL + 3, $fn=24, center = false);
     translate (v = [15, 14 + 50.5, 0])
	  cylinder (r = M3_HEAD_R, h = WALL + 3, $fn=24, center = false);
     translate (v = [15 + 88.5, 14 + 50.5, 0])
	  cylinder (r = M3_HEAD_R, h = WALL + 3, $fn=24, center = false);
}

module hole () {
    difference () {
        cylinder (h = WALL + BASE_H + DELTA * 2, r = M3_R, $fn = 24,
                  center = false);
        cylinder (h = M3_NUT_H + DELTA, r = M3_HEAD_R, $fn = 6,
                  center = false);
    }
}

module holes () {
    union () {

	 // Corners

	 translate (v = [PILLAR / 2, PILLAR / 2, -DELTA])
	      hole ();
	 translate (v = [WALL * 2 + PCB_X - PILLAR / 2, PILLAR / 2, -DELTA])
	      hole ();
	 translate (v = [PILLAR / 2, WALL * 2 + PCB_Y - PILLAR / 2, -DELTA])
	      hole ();
	 translate (v = [WALL * 2 + PCB_X - PILLAR / 2,
			 WALL * 2+ PCB_Y - PILLAR / 2, -DELTA])
	      hole ();

	 // Supports

     translate (v = [15, 14, 0])
	  hole ();
     translate (v = [15 + 88.5, 14, 0])
	  hole ();
     translate (v = [15, 14 + 50.5, 0])
	  hole ();
     translate (v = [15 + 88.5, 14 + 50.5, 0])
	  hole ();
    }
}

module wire_holes () {

     // Slot for power supplies

     translate (v = [30, PCB_Y + WALL/2, WALL + BASE_H - USB_H])
	  cube (size = [67, WIRE_W, WIRE_H + DELTA], center = false);

     // Slot for input signal wires from Pi

     translate (v = [52, 0, WALL + BASE_H - USB_H])
	  cube (size = [22, WIRE_W, WIRE_H + DELTA], center = false);

     // Slot for output wires to cuttlefishes/seahorses

     translate ([PCB_X + WALL - 1, PCB_Y / 2 - 15, WALL + BASE_H - WIRE_H])
	  cube (size = [WALL * 2, WIRE_W, WIRE_H + DELTA], center = false);
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
