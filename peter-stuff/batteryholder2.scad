
difference() {
	cube(size = [144,144,15],
	center = false);
	for ( x = [8 : 16 : 144] )
		for (y = [ 8 : 16 : 144] )
			translate (v = [x,y,5])
				cylinder (h = 15, r = 6, center = false);
}