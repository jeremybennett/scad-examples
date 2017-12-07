// Box for microusb power breakout.

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A container for a circuit board containing microusb power breakout. This is
// commond code and definitions.

DELTA = 0.01;
PILLAR = 10;
WALL = 3;
PCB_X = 102 + (PILLAR - WALL) * 2;
PCB_Y = 77;
H = 20;      // overall box height
BASE_H = 10; // base height
TOP_H = H - BASE_H - WALL * 2;
USB_W = 11;  // usb power width
USB_H = 3;   // usb power height
WIRE_W = 40; // wire hole length
WIRE_H = 6;  // wire hole height
M3_R = 1.9;
M3_HEAD_R = 3.4;
M3_HEAD_H = 3;
M3_NUT_H = 2.5;

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

