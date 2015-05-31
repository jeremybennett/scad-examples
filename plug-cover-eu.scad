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
	translate (v = [0, 0, 25 - 37.2 / 2])
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
	translate (v = [0, 0, 25 - 37.2 / 2])
            intersection () {
		sphere (r = 37.2 / 2, $fn = 180);
		translate (v = [0, 0, 25])
	            cube (size = [50, 50, 50], center = true);
	    }
	cylinder (r = 37.2 / 2, h = EPS, center = false, $fn = 180);
    }
}


// A single pin - allow 0.4mm space each side for easy sliding in.
module pin () {
    cylinder (r = 3.9 / 2 + 0.4, h = 20 + 0.4, center = false, $fn = 36);
}


// Both pins
module pins () {
    translate (v = [-7.5 - 3.9 / 2 - 0.4, 0, 0 - EPS])
        pin ();
    translate (v = [ 7.5 + 3.9 / 2 + 0.4, 0, 0 - EPS])
        pin ();
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
	    cube (size = [3, 50, 50], center = true);
	};
	intersection () {
	    sub_cover ();
	    cube (size = [4, 50, 50], center = true);
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
