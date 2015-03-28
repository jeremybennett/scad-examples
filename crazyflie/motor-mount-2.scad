// Crazyflie 2.0 motor mount

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// Unlike the original motor-mount, this is a conceptual equivalent, more
// suited for 3D printing on a Rep Rap.

// Stick the various parts together in the correct place.  Everything sits on
// or above the X-Y plane, with the motor mount cylinder centered on the
// origin.


// Tiny amount to ensure overlap for simple manifolds
EPS = 0.001;

// Wall thickness throughout
T = 0.8;

// Constants defining the components
MOTOR_CYL_D    = 7.2;           // Motor is 6.9, this allows for "bleed"
MOTOR_CYL_R    = MOTOR_CYL_D / 2;
MOTOR_CYL_H    = 9.1;           // Real cylinder extends 0.8 below
MOTOR_SLOT_W   = 1.4;
MOTOR_RIDGE_T  = 0.4;

LEG_H = 16.2;                   // Real leg extends 0.8 below
LEG_W =  3.5;

// PCB dimensions
ARM_W =  3.3;                   // PCB is actually 3.0
ARM_T =  1.7;                   // PCB is actually 1.4
ARM_L = 21.0;
BAR_W = ARM_L / 12;

// Hook
HOOK_H = 3.0;

// The motor cylinder

module motor_cyl () {
   $fn = 48;
   difference () {
      union () {
         // The main cylinder
         difference () {
            cylinder (r = MOTOR_CYL_R + T, h = MOTOR_CYL_H, center = false);
            cylinder (r = MOTOR_CYL_R,     h = MOTOR_CYL_H, center = false);
         }
         // The ridge 1 wall thickness and 1 wall thickness up from the bottom
         translate (v = [0, 0, MOTOR_CYL_H - T * 2])
            difference () {
               cylinder (r = MOTOR_CYL_R + EPS, h = R,  center = false);
               cylinder (r = MOTOR_CYL_R - T,   h = R , center = false);
            }
      }
      // Slot
      translate (v = [0, -MOTOR_SLOT_W / 2, 0])
         cube (size = [MOTOR_CYL_R *2, MOTOR_SLOT_W, MOTOR_CYL_H],
               center = false);
   }
}


// The legs. For now we do as a cube

// @param  off  Distance to translate along X axis before rotating
// @param  a    Angle to rotate around Z axis

module legs (off, a) {
   leg_t = (LEG_IN_T + LEG_OUT_T) / 2;
   rotate (a = [0, 0, a])
      translate (v = [off, - T / 2, 0])
         cube (size = [LEG_W, T, LEG_H], center = false);
}


// The basic ARM

// @param  xoff  Offset in X direction

module arm (xoff) {
   translate (v = [xoff, -ARM_W / 2 - T, 0]) {
      // Main bar
      difference () {
         cube (size = [ARM_L, ARM_W + T * 2, ARM_T + T], center = false);
         // Hollow for PCB
         translate (v = [0, T, T])
            cube (size = [ARM_L, ARM_W, ARM_T], center = false);
         // 4 Cutouts in base for flexibility
         translate (v = [0, T, 0])
            cube (size = [BAR_W, ARM_W, T], center = false);
         translate (v = [BAR_W * 3, T, 0])
            cube (size = [BAR_W * 2, ARM_W, T], center = false);
         translate (v = [BAR_W * 7, T, 0])
            cube (size = [BAR_W * 2, ARM_W, T], center = false);
         translate (v = [BAR_W * 11, T, 0])
            cube (size = [BAR_W, ARM_W, T], center = false);
      }
      // endstop is BAR_W in from the end
      translate (v = [BAR_W, T, 0])
         cube (size = [T, ARM_W, ARM_T], center = false);
   }
}


// Barrel for wire hooks

// Wire hooks across the top

// @param[in] xoff  Offset from X direction
// @param[in] ang   Angle to rotate the top slot

module wire_hook (xoff, ang) {
   translate (v = [xoff, 0, ARM_T + T])
      difference () {
         // Basic hollow cube
         translate (v = [0, -ARM_W / 2 - T, 0])
            cube (size = [BAR_W, ARM_W + T * 2, HOOK_H], center = false);
         translate (v = [0, -ARM_W / 2, T])
            cube (size = [BAR_W, ARM_W, HOOK_H - T -T], center = false);
         // Slot at bottom
         translate (v = [0, -ARM_W / 2 + T, 0])
            cube (size = [BAR_W, ARM_W - T * 2, T], center = false);
         // Slot at top for wire
         rotate (a = [0, 0, ang])
            translate (v = [-BAR_W, -T / 2, HOOK_H - T])
               cube (size = [BAR_W * 3, T, T], center = false);
      }
}


// Stick everything together.
module motor_mount () {
   motor_cyl ();
   // Legs are half in to the cylinder wall
   legs (MOTOR_CYL_R + T / 2, 135.0);
   legs (MOTOR_CYL_R + T / 2, 225.0);
   // This ensures arm intersects with cylinder
   arm (MOTOR_CYL_R);
   wire_hook (xoff = MOTOR_CYL_R + BAR_W * 3.5, ang =  15);
   wire_hook (xoff = MOTOR_CYL_R + BAR_W * 7.5, ang = -15);
}


motor_mount ();
