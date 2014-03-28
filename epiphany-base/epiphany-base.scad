// Epiphany Cluster Fan Cooling 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Epiphany Cluster Fan Cooling 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Fan base for Epiphany Cluster fan cooling

// This is a base to which a pair of fans can be fixed. The entire design is
// parameterized to facilitate changing for different size fans.

include <epiphany-core.scad>				// The main module definitions
include <epiphany-parameters.scad>		// Parameters defining this base


// The design

epiphany_base ();

// Optionally include dimensioning. Needs TextGenerator.scad and dimlines.scad
// installed and a reasonably recent version of OpenSCAD (2012.03 is known *not*
// to work!

// To be useful view this from the top, end or side. An orthogonal view is best.

// include <epiphany-dimensions.scad>
