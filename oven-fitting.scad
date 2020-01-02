// Oven control

// Copyright (C) 2019 Jeremy Bennett <www.jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A replacement oven controller


// Very small value
EPS = 0.001;

// Very large value
INF = 100;

// M3 dimensions
M3_SCREW_D = 3.0;
M3_NUT_D = 5.5;
M3_NUT_H = 2.5;


// Hole for D fitting of radius r
module d_hole (r) {
     intersection () {
	  cylinder (r = r, h = INF * 2, center = true, $fn = 36);
	  translate (v = [r / 2, 0, 0])
	       cube (size = [r * 2, r * 2, INF * 2 + EPS], center = true);
     }
}


// Grub screw hole, screw diameter d_screw, nut diameter d_nut and nut height
// h_nut and offsets from the center of x_off and base of z_off.
module grub_hole (d_screw, d_nut, h_nut, x_off, z_off) {
     r_screw = d_screw / 2;
     r_nut = d_nut / 2;
     translate (v = [0, 0, z_off])
	  rotate (a = [0, -90, 0])
	      cylinder (r = r_screw, h = INF, center = false, $fn = 36);
     translate (v = [-x_off, 0, z_off])
	  rotate (a = [0, -90, 0])
	      cylinder (r = r_nut, h = h_nut, center = false, $fn = 6);
}


// Bar and bush of radius r, height h, inner bar length l_i and outer bar
// length l_o
module bar_bush(r, h, l_i, l_o, h_spring) {
     cylinder (r = r, h = h, center = false, $fn = 36);
     intersection () {
	  cylinder (r = l_i / 2, h = INF, center = true, $fn = 72);
	  translate (v = [-r, -INF / 2, 0])
	       cube (size = [r * 2, INF, h], center = false);
     }
     intersection () {
	  cylinder (r = l_o / 2, h = INF, center = true, $fn = 72);
	  translate (v = [-r, -INF / 2, 0])
	       cube (size = [r * 2, INF, h - h_spring], center = false);
     }
     intersection () {
	  translate (v = [0, -r, 0])
	       cube (size = [INF, r * 2, h - h_spring], center = false);
	  translate (v = [-l_o / 2, 0, 0])
		    cylinder (r = l_o, h = INF, center = true, $fn = 3);
     }
}


// Central bush of height h and radius r_main, with D fitting of radius r_d,
// inner bar of length l_i and outer bar of l_o
module fitting (h, r_main, r_d, grub_off, l_i, l_o, h_spring) {
     difference () {
	  bar_bush (r = r_main, h = h, l_i = l_i, l_o = l_o,
		    h_spring = h_spring);
	  d_hole (r = r_d);
	  grub_hole (d_screw = M3_SCREW_D, d_nut = M3_NUT_D, h_nut = M3_NUT_H,
		     x_off = r_d / 2 - EPS, z_off = grub_off);
     }
}


// The fitting
fitting (h = 13, r_main = 6, r_d = 3.3, grub_off = 13 - 6.5, l_i = 38, l_o = 51,
	 h_spring = 5);
