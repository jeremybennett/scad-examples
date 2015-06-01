// Plug cover (EU version)

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A cover for an EU plug, to prevent pins destroying your bag.


// Very small value
EPS = 0.001;


// Hull inside main cover
module sub_cover () {
    hull () {
	translate (v = [0, 0, 27 - 37.2 / 2])
            intersection () {
		sphere (r = 37.2 / 2 - 2, $fn = 180);
		translate (v = [0, 0, 25])
	            cube (size = [50, 50, 50], center = true);
	    }
	cylinder (r = 37.2 / 2 - 2, h = EPS, center = false, $fn = 180);
    }
}


// The main cover
module cover () {
    hull () {
	translate (v = [0, 0, 27 - 37.2 / 2])
            intersection () {
		sphere (r = 37.2 / 2, $fn = 180);
		translate (v = [0, 0, 25])
	            cube (size = [50, 50, 50], center = true);
	    }
	cylinder (r = 37.2 / 2, h = EPS, center = false, $fn = 180);
    }
}


// A single pin - allow 0.4mm space each side for easy sliding in.
module pin (pin_rad, pin_height) {
    cylinder (r = pin_rad, h = pin_height, center = false, $fn = 36);
}


// Both pins
module pins () {
    // Pin radius, with 0.4mm clearance each side
    hole_rad = 3.9 / 2 + 0.4;
    // Pin length is 20mm + 2mm clearance
    hole_height = 20.0 + 2.0;
    // Pin gap varies between 14.2 and 15mm, so use 14.6mm
    hole_gap = (14.2 + 15.0) / 2;
    translate (v = [-hole_gap / 2  - hole_rad, 0, 0 - EPS])
        pin (hole_rad, hole_height);
    translate (v = [ hole_gap / 2  + hole_rad, 0, 0 - EPS])
        pin (hole_rad, hole_height);
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
