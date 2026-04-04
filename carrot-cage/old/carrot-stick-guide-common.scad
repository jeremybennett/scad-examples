// Carrot stick string guide

// Copyright (C) 2024 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0


module lip () {
     let (h = LIP_THICK,
	  l = LENGTH + WALL_THICK * 2.0 + LIP_WIDTH * 2.0,
	  w = WIDTH + WALL_THICK * 2.0 + LIP_WIDTH * 2.0) {
	  translate (v = [0, 0, (LIP_THICK - HEIGHT) / 2])
	       cube (size = [l, w, h], center = true);
     }
}

module outer_box () {
     let (h = HEIGHT,
	  l = LENGTH + WALL_THICK * 2.0,
	  w = WIDTH + WALL_THICK * 2.0) {
	  cube (size = [l, w, h], center = true);
     }
}

module inner_box () {
     let (h = HEIGHT + EPS,
	  l = LENGTH,
	  w = WIDTH) {
	  cube (size = [l, w, h], center = true);
     }
}

module bare_box () {
     translate (v = [0, 0, HEIGHT / 2])
	  difference () {
	       outer_box ();
	       inner_box ();
     }
}

module bare_lip_box () {
     translate (v = [0, 0, HEIGHT / 2])
	  difference () {
	       union () {
		    outer_box ();
		    lip ();
	       }
	       inner_box ();
     }
}

module groove (x_off = 0, y_off = 0, x_rot = 0, y_rot = 0, h_off) {
     let (groove_r = GROOVE_D / 2.0) {
	  translate (v = [x_off, y_off, h_off])
	       rotate (a = [x_rot, y_rot, 0])
	            cylinder (r = groove_r, h = INF, $fn=36, center = true);
     }
}

module groove_x (x_off, h_off) {
     groove (x_off = x_off, x_rot = 90, h_off = h_off);
}

module groove_y (y_off, h_off) {
     groove (y_off = y_off, y_rot = 90, h_off = h_off);
}

module box () {
     let (x_off = LENGTH / 2.0 + WALL_THICK + GROOVE_D / 4.0,
	  y_off = WIDTH / 2.0 + WALL_THICK + GROOVE_D / 4.0,
	  screw_x_off = LENGTH / 2.0 + WALL_THICK + EPS) {
	  difference () {
	       bare_box ();
	       groove_x (x_off, GROOVE_H_OFF);
	       groove_x (-x_off, GROOVE_H_OFF);
	       groove_y (y_off, GROOVE_H_OFF);
	       groove_y (-y_off, GROOVE_H_OFF);
	       translate (v = [screw_x_off, 0, SCREW_H_OFF_L])
		    rotate (a = [0, 90, 0])
		         screw_hole (shank_diam = 3.0, screw_height = x_off);
	       translate (v = [-screw_x_off, 0, SCREW_H_OFF_R])
		    rotate (a = [0, -90, 0])
		         screw_hole (shank_diam = 3.0, screw_height = x_off);
	  }
     }
}

module lip_box () {
     let (x_off = LENGTH / 2.0 + WALL_THICK + GROOVE_D / 4.0,
	  y_off = WIDTH / 2.0 + WALL_THICK + GROOVE_D / 4.0,
	  screw_x_off = LENGTH / 2.0 + WALL_THICK + EPS) {
	  difference () {
	       bare_lip_box ();
	       translate (v = [screw_x_off, 0, SCREW_H_OFF_L])
		    rotate (a = [0, 90, 0])
		         screw_hole (shank_diam = 3.0, screw_height = x_off);
	       translate (v = [-screw_x_off, 0, SCREW_H_OFF_R])
		    rotate (a = [0, -90, 0])
		         screw_hole (shank_diam = 3.0, screw_height = x_off);
	  }
     }
}
