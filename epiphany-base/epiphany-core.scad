// Epiphany Cluster Fan Cooling 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Epiphany Cluster Fan Cooling 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Core module definitions for a fan base for Epiphany Cluster fan cooling

// This is a base to which a pair of fans can be fixed. The entire design is
// parameterized to facilitate changing for different size fans.


// Polygon as a starter for the base
module base_outline () {
	polygon (points = [ // Pounts for outline of base
                       [0, 0],						// Point 0
							 [0, Y_OFF_1],				// Point 1 (not used)
							 [X_OFF_1, Y_OFF_1],		// Point 2 (not used)
							 [X_OFF_1, Y_OFF_2],		// Point 3 (not used)
							 [0, Y_OFF_2],				// Point 4 (not used)
							 [0, Y_OFF_3],				// Point 5
							 [X_OFF_3, Y_OFF_3],		// Point 6
							 [X_OFF_3, Y_OFF_2],		// Point 7 (not used)
							 [X_OFF_2, Y_OFF_2],		// Point 8 (not used)
							 [X_OFF_2, Y_OFF_1],		// Point 9 (not used)
                       [X_OFF_3, Y_OFF_1],		// Point 10 (not used)
							 [X_OFF_3, 0],				// Point 11

                       // Points for centre cutout
                       [X_OFF_1 + 6, Y_OFF_1 + 6],		// Point 12
							 [X_OFF_1 + 6, Y_OFF_2 - 6],		// Point 13
							 [X_OFF_2 - 6, Y_OFF_2 - 6],		// Point 14
							 [X_OFF_2 - 6, Y_OFF_1 + 6],		// Point 15
  
                       // Points for fan cutout 1
                       [FAN_HOLE_OFFSET * 2, 6],							// Point 16
							 [FAN_HOLE_OFFSET * 2, Y_OFF_1 - 6],				// Point 17
							 [X_OFF_3 - FAN_HOLE_OFFSET * 2, Y_OFF_1 - 6],	// Point 18
							 [X_OFF_3 - FAN_HOLE_OFFSET * 2, 6],				// Point 19

                       // Points for fan hole 2
                       [FAN_HOLE_OFFSET * 2, Y_OFF_2 + 6],				// Point 20
							 [FAN_HOLE_OFFSET * 2, Y_OFF_3 - 6],				// Point 21
							 [X_OFF_3 - FAN_HOLE_OFFSET * 2, Y_OFF_3 - 6],	// Point 22
							 [X_OFF_3 - FAN_HOLE_OFFSET * 2, Y_OFF_2 + 6]	// Point 23
						  ],
            paths = [ // Board outline
                      [0, 5, 6, 11],
                      // Cutout for centre hole
                      [12, 13, 14, 15],
	                   // Cutout for first fan hole
                      [16, 17, 18, 19],
	                   // Cutout for second fan hole
                      [20, 21, 22, 23]
                    ]);
}


// Cutout for base end

module board_edge_cutout () {
	translate (v = [X_OFF_1 / 2, BOARD_WIDTH / 2, 1]) {
		scale (v = [2 * X_OFF_1 / BOARD_WIDTH, 1, 1]) {
			circle (r = BOARD_WIDTH / 2, $fn = 240);
		}
	}
}

// Cutout for Epiphany stack

module stack_cutout () {
	minkowski ($fn = 50) {
		square (size = [BOARD_LENGTH - 18, BOARD_WIDTH - 18]);
		translate (v = [3, 3, 0])
			circle (r = 3);
	}
}

// Cutout for fan

module fan_cutout () {
	FAN_HOLE_WIDTH = FAN_THICKNESS + LUG_TOTAL_THICKNESS;
	FAN_HOLE_LENGTH = FAN_DIAMETER - FAN_HOLE_OFFSET * 4;
	minkowski ($fn = 50) {
		square (size = [FAN_HOLE_LENGTH - 18, FAN_HOLE_WIDTH - 18]);
		translate (v = [3, 3, 0])
			circle (r = 3);
	}
}


// Base is a linear extrusion of the cutout shape we would like.

module base () {
	linear_extrude (height = BASE_THICKNESS, center = false) {
		difference () {
			square (size = [X_OFF_3, Y_OFF_3], center = false);
			translate (v = [-X_OFF_1 / 2, Y_OFF_1, 0])
				board_edge_cutout ();
			translate (v = [X_OFF_3 - X_OFF_1 / 2, Y_OFF_1, 0])
				board_edge_cutout ();
			translate (v = [X_OFF_1 + 6, Y_OFF_1 + 6, 0])
				stack_cutout ();
			translate (v = [FAN_HOLE_OFFSET * 2 + 6, 6, 0])
				fan_cutout ();
			translate (v = [FAN_HOLE_OFFSET * 2 + 6, Y_OFF_2 + 6, 0])
				fan_cutout ();
		}
	}
}


// Support for the end of a fan. Make cube at base 1 mm bigger so we can get a
// 2-manifold when combined with the base. Make the cube hollow to save plastic. 
module fan_support () {
	difference () {
		cube (size = [FAN_HOLE_OFFSET * 2,
						  FAN_THICKNESS + LUG_TOTAL_THICKNESS,
      	           FAN_ELEVATION + 1], center = false);
		translate (v = [3, 3, 0])
			cube (size = [ FAN_HOLE_OFFSET * 2 - 6,
							   FAN_THICKNESS + LUG_TOTAL_THICKNESS - 6,
							   FAN_ELEVATION + 1 - 3], center = false);
		}

	// Lugs have a 1mm overlap to ensure we get a 2-manifold
	translate (v = [0, 0, FAN_ELEVATION])
		difference () {
			lug (LUG_OUTER_THICKNESS);
			lug_hole (FAN_HOLE_DIAMETER, LUG_OUTER_THICKNESS);
		}

	translate (v = [0, FAN_THICKNESS + LUG_OUTER_THICKNESS, FAN_ELEVATION])
		difference () {
			lug (LUG_INNER_THICKNESS);
			lug_hole (FAN_HOLE_DIAMETER, LUG_INNER_THICKNESS);
			lug_head_hole (SCREW_HEAD_DIAMETER, SCREW_HEAD_THICKNESS,
								LUG_INNER_THICKNESS);
		}
}


// A mirror image of the fan support.
module mirror_fan_support () {
	translate (v = [0, FAN_THICKNESS + LUG_TOTAL_THICKNESS, 0])
		mirror (v = [0, 1, 0])
			fan_support ();
}


// Lug for mounting fan. Extrude and rotate. Make 1mm deeper than expected to
// ensure we can get a 2-manifold when comined with fan support.

// @param thickness  How thick should this lug be?
module lug (thickness) {
	translate (v = [0, thickness, 0]) {
		rotate (a = 90, v = [1, 0, 0]) {
			linear_extrude (height = thickness, centre = false) {
				union () {
					square (size = [FAN_HOLE_OFFSET * 2, FAN_HOLE_OFFSET + 2],
					        centre = false);
					translate (v = [FAN_HOLE_OFFSET, FAN_HOLE_OFFSET + 2, 0]) {
						circle (r = FAN_HOLE_OFFSET, $fn = 120);
					}
				}
			}
		}
	}
}


// Lug holes. These are typically 4mm for common fans. Make them stick out
// 1mm each end so they cut a full hole. Remember that the lug is 1mm deeper
// than expected to ensure we get a 2-manifold with the base.

// @param diameter   Diameter of the lug hole
// @param thickness  How thick is the lug
module lug_hole (diameter, thickness) {
	translate (v = [FAN_HOLE_OFFSET - (diameter / 2),
						 thickness + 1,
                   FAN_HOLE_OFFSET - (diameter / 2) + 1])
		rotate (a = 90, v = [1, 0, 0])
			translate (v = [diameter / 2, diameter / 2, 0])
				cylinder (h = thickness + 2, r = diameter / 2, $fn = 24,
                      center = false);
}


// Lug screw head hole. This allows us to sink the screw head into the lug.

// @param head_diameter   Diameter of the screw head
// @param head_thickness  How thick is the screw head
// @param lug_thickness   How thick is the lug
module lug_head_hole (head_diameter, head_thickness, lug_thickness) {
	translate (v = [FAN_HOLE_OFFSET - (head_diameter / 2),
						 lug_thickness + 1,
                   FAN_HOLE_OFFSET - (head_diameter / 2) + 1])
		rotate (a = 90, v = [1, 0, 0])
			translate (v = [head_diameter / 2, head_diameter / 2, 0])
				cylinder (h = head_thickness + 1, r = head_diameter / 2, $fn = 24,
                      center = false);
}

// Base holes. These are typically 3mm and stick out 1mm each end so they cut a full
// hole. There is a recess for the head. Note that this hole will be centered on the
// origin in the X/Y plane
module base_hole (diameter, head_diameter, head_thickness) {
	translate (v = [	0, 0, -1])
		cylinder (h = BASE_THICKNESS + 2, r = diameter / 2, $fn = 24,
				    center = false);
	translate (v = [	0, 0, -1])
		cylinder (h = head_thickness + 1, r = head_diameter / 2, $fn = 24,
				   center = false);
}


// The complete design of a base and four fan supports

module epiphany_base () {
	// Base has four holes
	difference () {
		base ();
		translate (v = [X_OFF_1 + PAD_OFF_1, Y_OFF_1 + PAD_OFF_1, 0])
			base_hole (BOARD_HOLE_DIAMETER, BASE_SCREW_HEAD_DIAMETER,
						 BASE_SCREW_HEAD_THICKNESS);
		translate (v = [X_OFF_1 + PAD_OFF_1, Y_OFF_2 - PAD_OFF_2, 0])
			base_hole (BOARD_HOLE_DIAMETER, BASE_SCREW_HEAD_DIAMETER,
						 BASE_SCREW_HEAD_THICKNESS);
		translate (v = [X_OFF_2 - PAD_OFF_2, Y_OFF_2 - PAD_OFF_2, 0])
			base_hole (BOARD_HOLE_DIAMETER, BASE_SCREW_HEAD_DIAMETER,
						 BASE_SCREW_HEAD_THICKNESS);
		translate (v = [X_OFF_2 - PAD_OFF_2, Y_OFF_1 + PAD_OFF_1, 0])
			base_hole (BOARD_HOLE_DIAMETER, BASE_SCREW_HEAD_DIAMETER,
						 BASE_SCREW_HEAD_THICKNESS);
	}

	// All fan supports overlap by 1mm, to ensure we get a 2-manifold.
	translate (v = [0, 0, BASE_THICKNESS - 1])
		fan_support ();
	translate (v = [X_OFF_3 - FAN_HOLE_OFFSET * 2, 0, BASE_THICKNESS - 1])
		fan_support ();
	translate (v = [0, Y_OFF_1 + BOARD_WIDTH , BASE_THICKNESS - 1])
		mirror_fan_support ();
	translate (v = [X_OFF_3 - FAN_HOLE_OFFSET * 2, Y_OFF_1 + BOARD_WIDTH,
						 BASE_THICKNESS - 1])
		mirror_fan_support ();
}


// A spacer. Useful if the fan has a guard to go outside the lugs

module spacer (thickness) {
	translate (v = [FAN_HOLE_OFFSET, FAN_HOLE_OFFSET, 0])
		difference () {
			cylinder (h = thickness, r = FAN_HOLE_OFFSET, center = false,
						 $fn = 96);
			translate (v = [0, 0, -1])
				cylinder (h = thickness + 2, r = FAN_HOLE_DIAMETER / 2,
							center = false, $fn = 24);
		}
}

