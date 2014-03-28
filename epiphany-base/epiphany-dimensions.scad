// Epiphany Cluster Fan Cooling 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Epiphany Cluster Fan Cooling 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Dimension lines for the Epiphany fan base

// This requires TextGenerator.scad and dimlines.scad to be installed. You'll
// need to modify the directories below as necessary to find these.

include <epiphany-core.scad>				// The main module definitions
include <epiphany-parameters.scad>		// Parameters defining this base

// You may need to specify directories if you have these libraries elsewhere.

include <../libraries/TextGenerator.scad>
include <../libraries/dimlines.scad>

DIM_LINE_WIDTH = 0.2;

// Offsets in Z direction
Z_TOP = 40;
Z_BOTTOM = -5;


// Dimension of mounting holes in board width direction

color ("black")
	translate([X_OFF_1 + PAD_WIDTH / 2, Y_OFF_1 + PAD_WIDTH / 2, Z_TOP])
		rotate([0, 0, 90])
			dimensions (length=BOARD_WIDTH - PAD_WIDTH);


// Dimension of mounting holes in board length direction

color ("black")
	translate([X_OFF_1 + PAD_WIDTH / 2, Y_OFF_1 + PAD_WIDTH / 2, Z_TOP])
		rotate([0, 0, 0])
			dimensions (length=BOARD_LENGTH - PAD_WIDTH);