// A holder for a plug

// Copyright (C) 2020 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor Jeremy Bennett <jeremy@jeremybennett.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// This uses the bolts, nuts and threaded rods library by Rudolf Huttary (aka
// Parkinbot).


MAX_X = 126.10892;
MAX_Y =  91.50459;

// Small amount
EPS = 0.1;

// Dimensions of a 4mm wood screew

HEAD_DIAM  = 7.5;                   // x
SHANK_DIAM = 4.0;                   // y
HEAD_ANGLE = 100.0;                 // B - not used explicitly

// The countersink height is calculated as:
//
//      x - y
//    ----------
//    2 tan(B/2)

// Table of 2 tan(B/2) for various B
//
//  60    1.1547
//  82    1.7386
//  90    2.0000
// 100    2.3835
// 110    2.8563

CS_HEIGHT = 1.47;
CS_RIM_HEIGHT = 0.3;

// Screw height
SCREW_HEIGHT = 100;

// Hole for a countersink screw
module cs_hole() {
     translate(v = [0, 0, -CS_RIM_HEIGHT])
	  cylinder(r = HEAD_DIAM / 2, h = CS_RIM_HEIGHT + EPS, center = false,
		   $fn = 45);
     translate(v = [0, 0, -CS_HEIGHT - CS_RIM_HEIGHT])
	  cylinder(r1 = SHANK_DIAM / 2, r2 = HEAD_DIAM / 2, h = CS_HEIGHT,
		   center = false, $fn = 45);
     cylinder(r = SHANK_DIAM / 2, h = SCREW_HEIGHT, center = true, $fn = 45);
}


module basic_shape () {
     difference () {
          translate (v=[-15, -15, 0])
     	  cube (size=[MAX_X + 10, MAX_Y + 10, 26], center = false);
          minkowski() {
     	  scale (v=[(MAX_X - 20) / MAX_X, (MAX_Y - 20) / MAX_Y, 1.0])
     	       linear_extrude (height = 33, slices = 2, center = true,
     			       convexity = 3)
     	            polygon (points = [
                              [  63.054, 91.410],
                              [  69.394, 91.032],
                              [  72.627, 87.745],
                              [  75.435, 84.542],
                              [  82.401, 82.354],
                              [  92.094, 77.014],
                              [ 105.354, 66.655],
                              [ 114.071, 57.110],
                              [ 125.532, 35.338],
                              [ 124.558, 24.163],
                              [ 111.497, 11.786],
                              [ 101.345,  6.954],
                              [  90.061,  3.476],
                              [  76.228,  0.919],
                              [  66.131,  0.090],
                              [  59.978,  0.090],
                              [  49.881,  0.919],
                              [  36.048,  3.476],
                              [  24.764,  6.954],
                              [  14.612, 11.786],
                              [   1.551, 24.163],
                              [   0.576, 35.338],
                              [  12.038, 57.110],
                              [  20.755, 66.655],
                              [  34.015, 77.014],
                              [  43.708, 82.354],
                              [  50.674, 84.542],
                              [  53.482, 87.745],
                              [  56.715, 91.032]],
     			     convexity = 3);
     	  sphere (r=10.0);
          };
	  // Cable slot
          translate (v = [(MAX_X + 10) / 2 - 15, (MAX_Y + 10) - 15, 0])
     	       cube (size = [20, 40, 42], center = true);
	  // Screw holes
          translate (v = [5, -5, 26])
     	       cs_hole();
          translate (v = [10, MAX_Y - 25, 26])
     	       cs_hole();
          translate (v = [MAX_X - 25, -5, 26])
     	       cs_hole();
          translate (v = [MAX_X - 30, MAX_Y - 25, 26])
     	       cs_hole();
     }
}

rotate (a = [180, 0, 0])
     union() {
          intersection() {
               basic_shape();
               translate (v = [(MAX_X + 10) / 2 - 15, (MAX_Y + 10) / 2 - 25, 0])
     	            cylinder (r = 70, h = 100, center = true);
     	}
          translate(v = [(MAX_X + 10) / 2 - 15, -30, 25.5])
               cylinder(r = 1, h = 0.5, center = false);
}
