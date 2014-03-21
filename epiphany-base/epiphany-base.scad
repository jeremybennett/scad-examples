// Fan base for Epiphany Cluster fan cooling

// 45678901234567890123456789012345678901234567890123456789012345678901234567890

// Cluster boards are 80mm x 54mm. Mounting holes 3mm on the center of 6mm pads
// in each corner.

// The entire stack is 123mm to base of top layer.

// Fans are 120mm x 120mm x 25mm, with mounting hole centers 105mm apart in each
// corner.

// The fans are lifted 15mm from the base position, since there is no need to
// blow under the bottom board, while there is a need to blow across the top
// board.

// Overall base is 120mm x 120mm, with 3mm thick lugs to hold the fans and a 2mm
// gap between fan and cluster.


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

module base_cutout () {
	translate (v = [X_OFF_1 / 2, BOARD_WIDTH / 2, 1]) {
		scale (v = [2 * X_OFF_1 / BOARD_WIDTH, 1, 1]) {
			circle (r = BOARD_WIDTH / 2);
		}
	}
}


// Base is a linear extrusion of the cutout shape we would like.

module base () {
	linear_extrude (height = 5, center = false) {
		difference () {
			base_outline ();
			translate (v = [-X_OFF_1 / 2, Y_OFF_1, 0]) {
				base_cutout ();
			}
			translate (v = [X_OFF_3 - X_OFF_1 / 2, Y_OFF_1, 0]) {
				base_cutout ();
			}
		}
	}
}


// Support for the end of a fan. Make cube at base 1 mm bigger so we can get a
// 2-manifold when combined with the base.
module fan_support () {
	cube (size = [FAN_HOLE_OFFSET * 2, FAN_THICKNESS + LUG_THICKNESS * 2,
                 FAN_HOLE_OFFSET * 2 + 1], center = false);
	// Lugs have a 1mm overlap to ensure we get a 2-manifold
	translate (v = [0, 0, FAN_HOLE_OFFSET * 2]) {
		difference () {
			lug ();
			lug_hole (FAN_HOLE_DIAMETER);
		}
	}
	translate (v = [0, FAN_THICKNESS + LUG_THICKNESS, FAN_HOLE_OFFSET * 2]) {
		difference () {
			lug ();
			lug_hole (FAN_HOLE_DIAMETER);
		}
	}
}


// Lug for mounting fan. Extrude and rotate. Make 1mm deeper than expected to
// ensure we can get a 2-manifold when comined with fan support.
module lug () {
	translate (v = [0, LUG_THICKNESS, 0]) {
		rotate (a = 90, v = [1, 0, 0]) {
			linear_extrude (height = LUG_THICKNESS, centre = false) {
				union () {
					square (size = [FAN_HOLE_OFFSET * 2, FAN_HOLE_OFFSET + 1], centre = false);
					translate (v = [FAN_HOLE_OFFSET, FAN_HOLE_OFFSET + 1, 0]) {
						circle (r = FAN_HOLE_OFFSET);
					}
				}
			}
		}
	}
}


// Lug holes. These are typically 4mm for common fans. Make them stick out
// 1mm each end so they cut a full hole.
module lug_hole (diameter) {
	translate (v = [FAN_HOLE_OFFSET - (diameter / 2), FAN_HOLE_DIAMETER,
                   FAN_HOLE_OFFSET - (diameter / 2)]) {
		rotate (a = 90, v = [1, 0, 0]) {
			translate (v = [diameter / 2, diameter / 2, 0]) {
				cylinder (h = LUG_THICKNESS + 2, r = diameter / 2, $fn = 12, center = false);
			}
		}
	}
}


// Base holes. These are typically 3mm and stick out 1mm each end so they cut a full hole.
module base_hole (diameter) {
	translate (v = [diameter / 2, diameter / 2, -1]) {
		cylinder (h = BOARD_THICKNESS + 2, r = diameter / 2, $fn = 12, center = false);
	}
}


// The complete design of a base and four fan supports

module epiphany_base () {
	// Base has four holes
	difference () {
		base ();
		translate (v = [X_OFF_1 + PAD_OFF_1, Y_OFF_1 + PAD_OFF_1, 0])
			base_hole (BOARD_HOLE_DIAMETER);
		translate (v = [X_OFF_1 + PAD_OFF_1, Y_OFF_2 - PAD_OFF_2, 0])
			base_hole (BOARD_HOLE_DIAMETER);
		translate (v = [X_OFF_2 - PAD_OFF_2, Y_OFF_2 - PAD_OFF_2, 0])
			base_hole (BOARD_HOLE_DIAMETER);
		translate (v = [X_OFF_2 - PAD_OFF_2, Y_OFF_1 + PAD_OFF_1, 0])
			base_hole (BOARD_HOLE_DIAMETER);
	}

	// All fan supports overlap by 1mm, to ensure we get a 2-manifold.
	translate (v = [0, 0, BOARD_THICKNESS - 1])
		fan_support ();
	translate (v = [X_OFF_3 - FAN_HOLE_OFFSET * 2, 0, BOARD_THICKNESS - 1])
		fan_support ();
	translate (v = [0, Y_OFF_1 + BOARD_WIDTH , BOARD_THICKNESS - 1])
		fan_support ();
	translate (v = [X_OFF_3 - FAN_HOLE_OFFSET * 2, Y_OFF_1 + BOARD_WIDTH, BOARD_THICKNESS - 1])
		fan_support ();
}

// Constants defining the design
FAN_DIAMETER = 120;
FAN_THICKNESS = 25;
FAN_HOLE_OFFSET = 7.5;
FAN_HOLE_DIAMETER = 4;
LUG_THICKNESS = 3;
BOARD_WIDTH = 54;
BOARD_LENGTH = 80;
BOARD_HOLE_DIAMETER = 3;
BOARD_THICKNESS = 5;
PAD_WIDTH = 6;

// Useful derived constants
X_OFF_1 = (FAN_DIAMETER - BOARD_LENGTH) / 2;
X_OFF_2 = (FAN_DIAMETER + BOARD_LENGTH) / 2;
X_OFF_3 = FAN_DIAMETER;
Y_OFF_1 = FAN_THICKNESS + LUG_THICKNESS * 2;
Y_OFF_2 = Y_OFF_1 + BOARD_WIDTH;
Y_OFF_3 = Y_OFF_1 * 2 + BOARD_WIDTH;
PAD_OFF_1 = (PAD_WIDTH - BOARD_HOLE_DIAMETER) / 2;
PAD_OFF_2 = 6 - (PAD_WIDTH - BOARD_HOLE_DIAMETER) / 2;

// The design

epiphany_base ();

