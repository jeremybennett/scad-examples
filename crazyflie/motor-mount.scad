// Crazyflie 2.0 motor mount

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.

// 45678901234567890123456789012345678901234567890123456789012345678901234567890


// Stick the various parts together in the correct place.  Everything sits on
// or above the X-Y plane, with the motor mount cylinder centered on the
// origin.


// Constants defining the components
EPSILON        = 0.001;

MOTOR_CYL_R    = 4.0;
MOTOR_CYL_WALL = 0.8;
MOTOR_CYL_H    = 9.1;           // Real cylinder extends 0.8 below
MOTOR_SLOT_W   = 1.4;
MOTOR_RIDGE_H  = 0.8;
MOTOR_RIDGE_T  = 0.4;

LEG_H = 16.2;                   // Real leg extends 0.8 below
LEG_W =  3.5;
LEG_IN_T  = 0.9;                // Leg thickness tapers
LEG_OUT_T = 0.5;

ARM_WALL_H = 3.3;
ARM_WALL_W = 21.3;
ARM_WALL_T = 0.5;

ARM_BASE_XOFF = 1.0;
ARM_BASE_W    = 4.2;
ARM_BASE_T    = 0.7;
ARM_BASE_GAP  = 3.0;
ARM_BASE1_L   = 2.3;
ARM_BASE2_L   = 2.8;
ARM_BASE3_L   = 2.8;

HOOK_XOFF1   =  3.8;
HOOK_XOFF2   = 10.0;
HOOK_ZOFF    =  2.2;
HOOK_BASE_W  =  2.0;
HOOK_BASE_T  =  0.8;
HOOK_SIDE1_W =  3.0;
HOOK_SIDE1_H =  3.3;
HOOK_SIDE1_T =  0.6;
HOOK_SIDE2_W =  2.0;
HOOK_SIDE2_H =  3.0;
HOOK_SIDE2_T =  0.6;
HOOK_SIDE2_A = 25.0;
HOOK_TOP_W   =  0.8;
HOOK_TOP_H   =  ARM_BASE_W / 2 - ARM_WALL_T;
HOOK_TOP_T   =  0.6;

// The motor cylinder

module motor_cyl () {
   difference () {
      union () {
         // The main cylinder
         difference () {
            cylinder (r = MOTOR_CYL_R + MOTOR_CYL_WALL, h = MOTOR_CYL_H,
                      center = false);
            cylinder (r = MOTOR_CYL_R, h = MOTOR_CYL_H, center = false);
         }
         // The ridge
         translate (v = [0, 0, MOTOR_CYL_H - MOTOR_RIDGE_H * 2])
            difference () {
               cylinder (r = MOTOR_CYL_R + MOTOR_CYL_WALL, h = MOTOR_RIDGE_H,
                         center = false);
               cylinder (r = MOTOR_CYL_R - MOTOR_RIDGE_T, h = MOTOR_RIDGE_H,
                         center = false);
            }
      }
      // Slot
      translate (v = [0, -MOTOR_SLOT_W / 2, 0])
         cube (size = [MOTOR_CYL_R + MOTOR_CYL_R, MOTOR_SLOT_W, MOTOR_CYL_H],
               center = false);
   }
}


// The legs. For now we do as a cube

// @param  t  Distance to translate along X axis before rotating
// @param  a  Angle to rotate around Z axis

module legs (t, a) {
   leg_t = (LEG_IN_T + LEG_OUT_T) / 2;
   rotate (a = [0, 0, a])
      translate (v = [t - EPSILON, - leg_t / 2, 0])
         cube (size = [LEG_W, leg_t, LEG_H], center = false);
}


// The arm wall

// @param  xoff  Offset in X direction
// @param  yoff  Offset in Y direction

module arm_wall (xoff, yoff) {
   translate (v = [xoff, yoff, 0])
      cube (size = [ARM_WALL_W, ARM_WALL_T, ARM_WALL_H]);
}


// Bars across the base

// @param[in] xoff  Offset from X direction
module base_bars (xoff) {
   // First base bar
   translate (v = [xoff, -ARM_BASE_W / 2, 0])
      cube (size = [ARM_BASE1_L, ARM_BASE_W, ARM_BASE_T]);
   // Second base bar
   translate (v = [xoff + ARM_BASE1_L + ARM_BASE_GAP, -ARM_BASE_W / 2, 0])
      cube (size = [ARM_BASE2_L, ARM_BASE_W, ARM_BASE_T]);
   // Third base bar
   translate (v = [xoff + ARM_BASE1_L + ARM_BASE2_L + ARM_BASE_GAP * 2,
                   -ARM_BASE_W / 2, 0])
      cube (size = [ARM_BASE3_L, ARM_BASE_W, ARM_BASE_T]);
}


// Wire hooks across the top

// @param[in] xoff  Offset from X direction
module wire_hook (xoff) {
   // Base
   base_xoff  = HOOK_SIDE1_W - HOOK_BASE_W;
   side2_xoff = HOOK_SIDE1_W - HOOK_SIDE2_W;
   translate (v = [xoff + base_xoff, - ARM_BASE_W / 2 + ARM_WALL_T, HOOK_ZOFF])
      cube (size = [HOOK_BASE_W, ARM_BASE_W - ARM_WALL_T * 2, HOOK_BASE_T]);
   // Side 1
   translate (v = [xoff, - ARM_BASE_W / 2 + ARM_WALL_T, HOOK_ZOFF])
      cube (size = [HOOK_SIDE1_W, HOOK_SIDE1_T, HOOK_SIDE1_H]);
   // Side 2
   translate (v = [xoff + side2_xoff, ARM_BASE_W / 2 - ARM_WALL_T * 2,
                   HOOK_ZOFF])
      intersection () {
         cube (size = [HOOK_SIDE2_W, HOOK_SIDE2_T, HOOK_SIDE2_H]);
         rotate (a = [0, HOOK_SIDE2_A, 0])
            cube (size = [HOOK_SIDE2_W, HOOK_SIDE2_T, HOOK_SIDE2_H * 2]);
      }
   // Top
   translate (v = [xoff, - ARM_BASE_W / 2 + ARM_WALL_T,
              HOOK_ZOFF + HOOK_SIDE1_H - HOOK_TOP_T])
      cube (size = [HOOK_TOP_W, HOOK_TOP_H, HOOK_TOP_T]);
}


// Stick everything together.
module motor_mount () {
   motor_cyl ();
   legs (MOTOR_CYL_R + MOTOR_CYL_WALL / 2, 135.0);
   legs (MOTOR_CYL_R + MOTOR_CYL_WALL / 2, 225.0);
   arm_wall (xoff = MOTOR_CYL_R,
             yoff = - ARM_BASE_W / 2);
   arm_wall (xoff = MOTOR_CYL_R,
             yoff = ARM_BASE_W / 2 - ARM_WALL_T);
   base_bars (xoff = MOTOR_CYL_R + MOTOR_CYL_WALL + ARM_BASE_XOFF);
   wire_hook (xoff = MOTOR_CYL_R + MOTOR_CYL_WALL + HOOK_XOFF1);
   rotate (a = [0, 0, 180])
      wire_hook (xoff = -MOTOR_CYL_R - MOTOR_CYL_WALL - HOOK_XOFF2
                        - HOOK_SIDE1_W);
}


motor_mount ();
