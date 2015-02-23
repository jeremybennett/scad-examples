// A4 clip frame stand

// Copyright (C) 2015 Jeremy Bennett <jeremy@jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy@jeremybennett.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// 45678901234567890123456789012345678901234567890123456789012345678901234567890


// This is a tetrahedron, with the front face 5 degrees back from vertical and
// a slot in the base for the clip.  We build it as a cube, tilt it, then
// slice bits off to make the tetrahedron.


// Base dimensions
WIDTH  = 210.0;                         // Frame width
HEIGHT = 297.0;                         // Frame depth
DEPTH  =   3.5;                         // Frame thickness

TILT = 10;                              // How much to tilt back

CLIP_W = 15;                            // Clip width
CLIP_H = 40;                            // Clip height
CLIP_D =  8;                            // Clip depth

// Derived dimensions
base_w = WIDTH / 3;
base_h = HEIGHT / 3;
base_d = base_w;

clear_d = DEPTH * 1.2;                  // Allow some play in frame thickness


// The basic cube with a ledge. Face is on X-Z plane, base is on X-Y plane,
// face centered on Y-Z plane, with ledge sticking forward

module base_holder () {
   // Dimensions for the ledge
   ledge_w = base_w;
   ledge_h = clear_d * 2;
   ledge_d = ledge_h;

   // Dimensions for groove in the ledge
   groove_w = ledge_w;
   groove_h = clear_d;
   groove_d = groove_h;

   difference () {
      union () {
         // The base cube
         translate (v = [-base_w / 2, 0, 0])
            cube (size = [base_w, base_d, base_h], center = false);
         // Ledge
         translate (v = [-ledge_w / 2, -ledge_d, 0])
            cube (size = [ledge_w, ledge_d, ledge_h], center = false);
      }

      // Groove in the ledge
      translate (v = [-groove_w / 2, -groove_d, ledge_h - groove_h])
         cube (size = [groove_w, groove_d, groove_h], center = false);

      // Slot for clip
      translate (v = [-CLIP_W / 2, -base_d + CLIP_D, 0])
         cube (size = [CLIP_W, base_d, CLIP_H], center = false);
   }
}


// A cube rotated around Y to slice off the side.

// @param  direction  Which direction to rotate.
module side_slice (direction) {
   // Amount to tilt to ensure meeting at the top
   angle = direction * atan ((base_w / 2) / base_h);
   rotate (a = [0, angle, 0])
      translate (v = [-direction * base_w / 2, 0, 0])
         cube (size = [base_w, base_d * 4, base_h * 4], center = true);
}


// A cube rotated around X to slice off the back
module back_slice () {
   // Amount to tilt to ensure meeting at the top
   angle = atan (base_d / base_h) - TILT;
   rotate (a = [angle, 0, 0])
      translate (v = [0, base_d, 0])
         cube (size = [base_w * 2, base_d * 2, base_h * 4], center = true);
}


// The full holder

// The base is tipped back, then triangles are cut away.  And have a flat top,
// because printing a point is a bad idea.

// To save weight, we take a cylinder out of the middle

module holder () {
   sliced_height = base_h * 0.8;

   difference () {
      rotate (a = [-TILT, 0, 0])
         base_holder ();

      // Cube to slice the base. Ensure wide enough
      translate (v = [-base_w, 0, -base_h])
         cube (size = [base_w * 2, base_d * 2, base_h], center = false);

      // Cubes to slice off the sides
      translate (v = [base_w / 2, 0, 0])
         side_slice (-1);
      translate (v = [-base_w / 2, 0, 0])
         side_slice (+1);

      // Cube to slice off the back
      translate (v = [0, base_d, 0])
         back_slice ();

      // Cube to slice off to top
      translate (v = [-base_w / 2, 0, sliced_height])
         cube (size = [base_w, base_d, base_h], center = false);

      // Cylinder to save weight
      translate (v = [0, base_d / 2.3, base_h / 4])
         rotate (a = [36, 0, 0])
            rotate (a = [0, 90, 0])
               cylinder (r = base_d / 4, h = base_w * 2, center = true,
                         $fn = 12);
   }
}


// Print out the base
holder ();