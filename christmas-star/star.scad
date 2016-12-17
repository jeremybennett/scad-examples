// Christmas star

// Copyright (C) 2016 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A star of David incorporating a Cuttlefish. This is the generic half

HOLE_R = 1.8;
HEAD_R = 3.5;

DELTA = 0.1;

module star () {
    intersection () {
            union () {
		hull () {
                    cylinder (h = 3, r = 75, center = false, $fn = 3);
                    translate (v = [0, 0, 10])
                        sphere (r = 1.5, $fn = 24);
		}
		hull () {
                    rotate (a = [0, 0, 180])
                        cylinder (h = 3, r = 75, center = false, $fn = 3);
                    translate (v = [0, 0, 10])
                        sphere (r = 1.5, $fn = 24);
		}
            }
        translate (v = [0, 0, 200])
            cube (size = [400, 400, 400], center = true);
    }
}

module pin_holes () {
    hull () {
	translate (v = [ -8 * 2.54 - 1.5, 9, -DELTA])
	    cylinder (r1 = 5, r2 = 1.8, h = 8 + DELTA * 2, center = false);
	translate (v = [  8 * 2.54 + 1.5, 9, -DELTA])
	    cylinder (r1 = 5, r2 = 1.8, h = 8 + DELTA * 2, center = false);
    }
    hull () {
	translate (v = [ -8 * 2.54 - 1.5, -9, -DELTA])
	    cylinder (r1 = 5, r2 = 1.8, h = 8 + DELTA * 2, center = false);
	translate (v = [  8 * 2.54 + 1.5, -9, -DELTA])
	    cylinder (r1 = 5, r2 = 1.8, h = 8 + DELTA * 2, center = false);
    }
}


module board_holes () {
    translate (v = [28, 9, 0])
        cylinder (r = HOLE_R, h = 40, center = true, $fn = 24);
    translate (v = [28, -9, 0])
        cylinder (r = HOLE_R, h = 40, center = true, $fn = 24);
    translate (v = [-28, 9, 0])
        cylinder (r = HOLE_R, h = 40, center = true, $fn = 24);
    translate (v = [-28, -9, 0])
        cylinder (r = HOLE_R, h = 40, center = true, $fn = 24);
}


module join_hole (is_top) {
    translate (v = [60, 0, 7])
        rotate (a = [180, 0, 0])
            union () {
		cylinder (r = HOLE_R, h = 23, $fn = 24, center = false);
		cylinder (r = HEAD_R, h =  3, $fn = is_top ? 6 : 24,
		          center = false);
	    }
}


module join_holes (is_top) {
    rotate (a = [0, 0, 60])
        join_hole (is_top);
    rotate (a = [0, 0, 120])
        join_hole (is_top);
    rotate (a = [0, 0, -60])
        join_hole (is_top);
    rotate (a = [0, 0, -120])
        join_hole (is_top);
}


module all_star (is_top) {
    intersection () {
	difference () {
	    minkowski () {
		star ();
		sphere (r = HOLE_R, $fn = 24);
	    }
	    if (is_top) {
		pin_holes ();
		board_holes ();
	    }
	    join_holes (is_top);
	    if (is_top) {
		// plateau for board with tail to the -x direction
		translate (v = [-5, 0, 57.5])
                    cube (size = [90, 25, 100], center = true);
	    }
	}
	translate (v = [0, 0, 50])
            cube (size = [400, 400, 100], center = true);
    }
}
