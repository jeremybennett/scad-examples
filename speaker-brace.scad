difference () {
	// The main rod
	translate (v = [0,4,4])
		cube (size = [65,8,8], center = true);	
	// Carve out the speaker slot
	translate (v = [0,32.5,6])
		cylinder (h = 5, r = 32.5, center = true);
	// Right screw hole
	translate (v = [28.5,5,4])
		cylinder (h = 10, r = 1.75, center = true);
	// Left screw hole
	translate (v = [-28.5,5,4])
		cylinder (h = 10, r = 1.75, center = true);
	// Right screw countersink
	translate (v = [28.5,4,4])
		cylinder (h = 0.875, r1 = 3.5, r2 = 1.75);
}
