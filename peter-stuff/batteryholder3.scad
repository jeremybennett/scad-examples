
difference() {
	cube(size = [64,64,15],
	center = false);
	for ( x = [8 : 16 : 64] )
		for (y = [ 8 : 16 : 64] )
			translate (v = [x,y,5])
				cylinder (h = 15, r = 6, center = false);
}