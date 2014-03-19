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


// Base is a linear extrusion of the cutout shape we would like.

module base () {
	linear_extrude (height = 5, center = false) {
		polygon (points = [ // Pounts for outline of base
                          [0, 0], [0, 31], [20, 33], [20, 87], [0, 89], [0,120],
   	                    [120, 120], [120, 89], [100, 87], [100, 33],
                          [120, 31],[120, 0],
                          // Points for centre hole
                          [26, 39], [26, 81], [94, 81], [94, 39],
                          // Points for fan hole 1
                          [15, 9], [15, 22], [105, 22], [105, 9],
                          // Points for fan hole 2
                          [15, 111], [15, 98], [105, 98], [105, 111]
                         ],
               paths = [ // Cutout for centre hole
                         [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                         // Cutout for centre hole
                         [12, 13, 14, 15],
	                      // Cutout for first fan hole
                         [16, 17, 18, 19],
	                      // Cutout for second fan hole
                         [20, 21, 22, 23]
                       ]);
	}
}


// Support for the end of a fan. Make cube at base 1 mm bigger so we can get a
// 2-manifold when combined with the base.
module fan_support () {
	cube (size = [15, 31, 16], enter = false);
	// Lugs have a 1mm overlap to ensure we get a 2-manifold
	translate (v = [0, 0, 15]) {
		lug ();
	}
	translate (v = [0, 28, 15]) {
		lug ();
	}
}

// Lug for mounting fan. Extrude and rotate. Make 1mm deeper than expected to
// ensure we can get a 2-manifold when comined with fan support.
module lug () {
	translate (v = [0, 3, 0]) {
		rotate (a = 90, v = [1, 0, 0]) {
			linear_extrude (height = 3, centre = false) {
				union () {
					square (size = [15, 8.5], centre = false);
					translate (v = [7.5, 8.5, 0]) {
						circle (r = 7.5);
					}
				}
			}
		}
	}
}

base ();
// All fan supports overlap by 1mm, to ensure we get a 2-manifold.
translate (v = [0, 0, 2]) fan_support ();
translate (v = [105, 0, 2]) fan_support ();
translate (v = [0, 89, 2]) fan_support ();
translate (v = [105, 89, 2]) fan_support ();
