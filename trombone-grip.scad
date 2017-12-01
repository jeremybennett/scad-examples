// Trombone case grip

// Copyright (C) 2017 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy@jeremybennett.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// Stop a mouthpiece rolling around

// Small amount to ensure overaps when needed

EPS = 0.01;


module block () {
     hull () {
	  translate (v = [15, 0, 0])
	       cylinder (r = 8, h = 5, $fn = 48, center = false);
	  translate (v = [-15, 0, 0])
	       cylinder (r = 8, h = 5, $fn = 48, center = false);
     }
}


module shaped_block () {
     difference () {
	  block ();
	  translate (v = [-5, 0, 3/2 + 3])
	       cube (size = [15, 20, 3 + EPS], center = true);
     }
}

// Optional notched version of the block

module notched_block () {
     difference () {
	  shaped_block ();
	  hull () {
	       translate (v = [-15, 0, 0])
		    cylinder (r = 1.5, h = 20, $fn = 24, center = true);
	       translate (v = [-15, -10, 0])
		    cylinder (r = 1.5, h = 20, $fn = 24, center = true);
	  }
     }
}

module grip () {
     difference () {
	  shaped_block ();
	  translate (v = [15, 0, 0])
	       cylinder (r = 1.9, h = 20, $fn = 24, center = true);
     }
}

grip ();
