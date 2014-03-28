// Epiphany Cluster Fan Cooling 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Epiphany Cluster Fan Cooling 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Constants defining the fan base for Epiphany Cluster fan cooling

// Cluster boards are 86mm x 54mm. Mounting holes 3mm on the center of 6mm pads
// in each corner.

// The entire stack is 123mm to base of top layer.

// Fans are 120mm x 120mm x 25mm, with mounting hole centers 105mm apart in each
// corner.

// The fans are lifted 15mm from the base position, since there is no need to
// blow under the bottom board, while there is a need to blow across the top
// board.

FAN_DIAMETER = 120;				// Overall diameter of the fan.
FAN_THICKNESS = 25;				// Overall thickness of the fan
FAN_HOLE_OFFSET = 7.5;			// How far mounting holes centers are in from base
FAN_HOLE_DIAMETER = 4;			// Diameter of mounting holes
FAN_ELEVATION = 15;				// How far we lift fan from base of stack
LUG_INNER_THICKNESS = 5;		// Inner lug thickness (must sink screw head)
LUG_OUTER_THICKNESS = 5;		// Outer lug thickness
SCREW_HEAD_THICKNESS = 3;		// How deep to sink screw head
SCREW_HEAD_DIAMETER = 9;		// How wide is screw head
BOARD_WIDTH = 54;				// Width of parallella board
BOARD_LENGTH = 86;				// Length of parallella board
BOARD_HOLE_DIAMETER = 3.2;		// Diameter of parallella mounting holes (with play)
PAD_WIDTH = 6;					// Width (and length) of pad with mounting holes
BASE_THICKNESS = 5;				// Thickness of the main base
BASE_SCREW_HEAD_DIAMETER = 7;	// Screws holding base
BASE_SCREW_HEAD_THICKNESS = 3;// How deep to sink screw

// Useful derived constants
LUG_TOTAL_THICKNESS = LUG_INNER_THICKNESS + LUG_OUTER_THICKNESS;
X_OFF_1 = (FAN_DIAMETER - BOARD_LENGTH) / 2;
X_OFF_2 = (FAN_DIAMETER + BOARD_LENGTH) / 2;
X_OFF_3 = FAN_DIAMETER;
Y_OFF_1 = FAN_THICKNESS + LUG_TOTAL_THICKNESS;
Y_OFF_2 = Y_OFF_1 + BOARD_WIDTH;
Y_OFF_3 = Y_OFF_1 * 2 + BOARD_WIDTH;
PAD_OFF_1 = (PAD_WIDTH) / 2;
PAD_OFF_2 = 6 - (PAD_WIDTH) / 2;