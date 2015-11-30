module brace () {
   difference () {
	   // The main rod
	   translate (v = [0,4,4])
	   	cube (size = [65,8,8], center = true);	
	   // Carve out the speaker slot
	   translate (v = [0,34,6])
		   cylinder (h = 5, r = 32.5, center = true);
	   // Right screw hole
	   translate (v = [28.5,4,4])
		   cylinder (h = 10, r = 1.75, center = true,
						 $fn = 12);
	   // Left screw hole
	   translate (v = [-28.5,4,4])
		   cylinder (h = 10, r = 1.75, center = true);
	   // Right screw countersink
	   translate (v = [28.5,4,0.3175])
		   cylinder (h = 0.625, r1 = 3, r2 = 1.75,
                   center = true);
	   translate (v = [28.5,4,-0.8])
		   cylinder (h = 2, r = 3, center = true);
	   // Left screw countersink
	   translate (v = [-28.5,4,0.3175])
		   cylinder (h = 0.625, r1 = 3, r2 = 1.75,
                   center = true);
	   translate (v = [-28.5,4,-0.8])
		   cylinder (h = 2, r = 3, center = true);
   }
}

rotate (a = [90, 0, 0]) brace ();
