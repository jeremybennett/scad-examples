// Fan base for Epiphany Cluster fan cooling

// 45678901234567890123456789012345678901234567890123456789012345678901234567890

// Cluster boards are 80mm x 54mm. Mounting holes 3mm on the center of 6mm pads
// in each corner.

// Cluster boards are 11mm per layer, so the entire stack is 88m to base of top
// layer.

// Fans are 92mm x 92mm x 25mm, with mounting hole centers 82.5mm apart in each
// corner.

// The fans are lifted 7mm from the base position, since there is no need to
// blow under the bottom board, while there is a need to blow across the top
// board.

// Overall base is 120mm x 92mm, with 3mm thick lugs to hold the fans and a 2mm
// gap between fan and cluster.


// Base is a linear extrusion of the cutout shape we would like.

module base () {
	linear_extrude (height = 5, center = false) {
		polygon (points = [ // Pounts for Ooutline of base
                          [0, 0], [0, 31], [3, 33], [3, 87], [0, 89], [0,120],
   	                       [92, 120], [92, 89], [89, 87], [89, 33], [92, 31],
                          [92, 0],
                          // Points for centre hole
                          [9, 39], [9, 81], [83, 81], [83, 39],
                          // Points for fan hole 1
                          [9.5, 9], [9.5, 22], [82.5, 22], [82.5, 9],
                          // Points for fan hole 2
                          [9.5, 111], [9.5, 98], [82.5, 98], [82.5, 111]
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


// Lug for mounting fan. Extrude and rotate
module lug () {
	linear extrude (height = 3, centre = false) {
		

base ();