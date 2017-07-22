// Improved, curtain rail hook.

// Copyright (C) 2017 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// This is based on http://www.thingiverse.com/thing:408249, but designed to
// be configurable and a bit more forgiving to print.



module lug () {
     cube (size = [18, 5.5, 2.4], center = false);
     translate (v = [4.5, 1.75, 0])
	  cube (size = [9, 2, 6], center = false);
}


module bar () {
     difference () {
	  union () {
	       translate (v = [4.5, 1.75, 5])
		    cube (size = [9, 30, 6], center = false);
	       translate (v = [4.5, 10, 0])
		    cube (size = [9, 21.75, 6], center = false);
	  }
	  translate (v = [9, 0, 11])
	       rotate (a = [-90, 0, 0])
	            cylinder (r = 3, h = 40, $fn = 48, center = false);
     }
}


module block () {
     difference () {
	  translate (v = [1, 22.75, 0])
	       cube (size = [16, 9, 16], center = false);
	  translate (v = [9, 0, 11])
	       rotate (a = [-90, 0, 0])
	            cylinder (r = 2, h = 40, $fn = 48, center = false);
     }
}


module curtain_hook () {
     lug ();
     bar ();
     block ();
}


curtain_hook ();
