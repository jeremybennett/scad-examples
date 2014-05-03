// Wedges for a Samsung monitor
rotate_extrude ()
	difference () {
		scale (v = [0.193, 0.250, 1])
			circle (d = 100);
		translate (v = [-13, 0,0])
			square (size = 26, center = true);
	}
