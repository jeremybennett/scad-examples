// Plug cover (US version)

// Copyright (C) 2015-2017 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A cover for an US plug, to prevent pins destroying your bag.


// Very small value
EPS = 0.001;


// Hull inside main cover
module sub_cover () {
    hull () {
	translate (v = [0, 0, 30 - 38.2 / 2])
            intersection () {
		sphere (r = 38.2 / 2 - 2, $fn = 180);
		translate (v = [0, 0, 25])
	            cube (size = [50, 50, 50], center = true);
	    }
	cylinder (r = 38.2 / 2 - 2, h = EPS, center = false, $fn = 180);
    }
}


// The main cover
module cover () {
    hull () {
	translate (v = [0, 0, 30 - 38.2 / 2])
            intersection () {
		sphere (r = 38.2 / 2, $fn = 180);
		translate (v = [0, 0, 25])
	            cube (size = [50, 50, 50], center = true);
	    }
	cylinder (r = 38.2 / 2, h = EPS, center = false, $fn = 180);
    }
}


// A single pin - allow 0.4mm space each side for easy sliding in.
module pin (pin_x, pin_y, pin_z) {
     translate (v = [0, 0, pin_z / 2])
	  cube  (size = [pin_x, pin_y, pin_z], center = true);
}


// Both pins. Pins are 6.5 x 1.5 x 15.9. Allow 0.4mm clearance each side and
// 2mm at the hole bottom. Pin centres are 12.7 appart.
module pins () {
    hole_x = 6.5 + 0.4 * 2;
    hole_y = 1.5 + 0.4 * 2;
    hole_height = 15.9 + 2.0;
    hole_gap = 12.7;
    translate (v = [0, -hole_gap / 2, 0 - EPS])
        pin (hole_x, hole_y, hole_height);
    translate (v = [0,  hole_gap / 2, 0 - EPS])
        pin (hole_x, hole_y, hole_height);
}


// Slot for rubber band
module slot () {
    difference () {
	intersection () {
	    union () {
		translate (v = [0, 0,  EPS])
	            cover ();
		translate (v = [0, 0, -EPS])
	            cover ();
	    }
	    cube (size = [3, 100, 100], center = true);
	};
	intersection () {
	    sub_cover ();
	    cube (size = [4, 100, 100], center = true);
	};
    }
}


module plug_cover () {
    difference () {
	cover ();
	pins ();
	slot ();
    }
}


plug_cover ();
