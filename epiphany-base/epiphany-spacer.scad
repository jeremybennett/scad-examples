// Epiphany Cluster Fan Cooling 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Epiphany Cluster Fan Cooling 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Spacer washer for epiphany fan base. This is needed if you have a cage over
// your fan to match the lugs on the base (you'll need four).

include <epiphany-core.scad>				// The main module definitions
include <epiphany-parameters.scad>		// Parameters defining this base


// The design for the spacer

echo (LUG_OUTER_THICKNESS);
spacer (LUG_OUTER_THICKNESS);
