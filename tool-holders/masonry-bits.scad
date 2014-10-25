// Masonry bits holder 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// This 3D Design is licensed under a Creative Commons Attribution-ShareAlike
// 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not,
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------


use <MCAD/regular_shapes.scad>


// Assume offset from base
module drill_hole (x, y, bore) {
	depth = 36;
	translate (v = [x, y, depth / 2 + 5])
		cylinder (r = bore / 2 + 0.2, h = depth, $fn = 24, center = true);
}


module drill_holes () {
	// 4mm bit
	drill_hole (x = 15, y = 30, bore = 3.2);
	// 5mm bits
	drill_hole (x = 25, y = 25, bore = 4.4);
	drill_hole (x = 25, y = 35, bore = 3.8);
	// 6mm bits
	drill_hole (x = 36, y = 25, bore = 4.7);
	drill_hole (x = 36, y = 35, bore = 4.7);
	// 6.5mm and 7mm bits
	drill_hole (x = 48, y = 25, bore = 5.5);
	drill_hole (x = 48, y = 35, bore = 5.9);
	// 8mm bits
	drill_hole (x = 60, y = 15, bore = 5.6);
	drill_hole (x = 60, y = 25, bore = 5.6);
	drill_hole (x = 60, y = 35, bore = 5.8);
	drill_hole (x = 60, y = 45, bore = 6.2);
	// 10mm bit
	drill_hole (x = 72, y = 30, bore = 7.2);
}


// Block to be a support, with bevelled top
module drill_block () {
	width   = 87;
	breadth = 60;
	height  = 40;
	bevel = 10;
	difference () {
		translate (v = [width / 2, breadth / 2, height / 2])
			cube (size = [width, breadth, height], center = true);
		translate (v = [width / 2, 0, height])
			rotate (a = [45, 0, 0])
				rotate (a = [0, 90, 0])
					cube (size = [bevel, bevel, width], center = true);
		translate (v = [width / 2, breadth, height])
			rotate (a = [45, 0, 0])
				rotate (a = [0, 90, 0])
					cube (size = [bevel, bevel, width], center = true);
		translate (v = [0, breadth / 2, height])
			rotate (a = [0, 45, 0])
				rotate (a = [90, 0, 0])
					cube (size = [bevel, bevel, breadth], center = true);
		translate (v = [width, breadth / 2, height])
			rotate (a = [0, 45, 0])
				rotate (a = [90, 0, 0])
					cube (size = [bevel, bevel, breadth], center = true);
	}
}


// Support with screwholes
module drill_support () {
	difference () {
		drill_block ();
		drill_holes ();
	}
}

drill_support ();
width = 87;
height = 40;

