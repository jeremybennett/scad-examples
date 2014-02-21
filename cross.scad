module cross () {
	union () {
		// The vertical
		cube (size = [10, 40, 5], center = true);
		// The horizontal
		translate (v = [0, 5, 0])
			cube (size = [30, 10, 5], center = true);
	}
}

difference () {
	cross ();
	translate (v = [0, 15, 0])
		cylinder (h = 7, r = 1.5, $fn = 12, center = true);
}
