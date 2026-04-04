// Corner clip for the mini greenhouse

// Copyright (C) 2023 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

// Designed to hold the corners together and provide a projection to locate
// the top.

include <../lib/screw-hole.scad>

EPS = 0.01;

// 2 are base length 80, 2 are 85
SIDE_LENGTH = 30;
HEIGHT = 30;
THICK = 5;

// Translate and rotate a screwhole
module transrot_screwhole (x = 0, y = 0, z = 0, ax = 0, ay = 0, az = 0) {
     translate (v=[x, y, z])
	  rotate (a = [ax, ay, az])
	       screw_hole(4.0);
}

// Side panel with screw holes
module side_panel () {
     let (off = HEIGHT / 4.0,
	  xoff1 = off,
	  xoff2 = SIDE_LENGTH - off,
	  yoff = THICK + EPS,
	  zoff1 = off,
	  zoff2 = HEIGHT - off) {
	  difference () {
	       cube (size = [SIDE_LENGTH, THICK, HEIGHT]);
	       transrot_screwhole (x = xoff1, y = yoff, z = zoff1, ax = -90);
	       transrot_screwhole (x = xoff2, y = yoff, z = zoff2, ax = -90);
	  }
     }
}

// base panel with screw holes
module base_panel () {
     let (off = HEIGHT / 4.0,
	  xoff1 = off,
	  xoff2 = BASE_LENGTH - off,
	  xoff3 = BASE_LENGTH / 2.0,
	  yoff = THICK + EPS,
	  zoff1 = off,
	  zoff2 = HEIGHT - off,
	  zoff3 = HEIGHT / 2.0) {
	  difference () {
	       cube (size = [BASE_LENGTH, THICK, HEIGHT]);
	       transrot_screwhole (x = xoff1, y = yoff, z = zoff1, ax = -90);
	       transrot_screwhole (x = xoff1, y = yoff, z = zoff2, ax = -90);
	       transrot_screwhole (x = xoff2, y = yoff, z = zoff1, ax = -90);
	       transrot_screwhole (x = xoff2, y = yoff, z = zoff2, ax = -90);
	       transrot_screwhole (x = xoff3, y = yoff, z = zoff3, ax = -90);
	  }
     }
}

// Plain corner without screwholes
module plain_corner () {
     union () {
	  base_panel ();
	  rotate (a = [0, 0, -45])
	       translate (v = [-SIDE_LENGTH, 0, 0])
	            side_panel ();
	  translate (v = [BASE_LENGTH, 0, 0])
	       rotate (a = [0, 0, 45])
	            side_panel ();
     }
}

plain_corner ();
