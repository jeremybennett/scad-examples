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
PCB_X = 85 + (PILLAR - WALL) * 2;
PCB_Y = 48;
H = 23;
BASE_H = 13;
TOP_H = H - BASE_H - WALL * 2;
USB_W = 9;
USB_H = 3;
WIRE_W = 3 * 2.54;
WIRE_H = 2;
M3_R = 1.7;
M3_HEAD_R = 3.2;
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

