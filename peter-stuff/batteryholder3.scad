
difference() {
	cube(size = [64,64,12],
	center = false);
	for ( x = [8 : 16 : 64] )
		for (y = [ 8 : 16 : 64] )
			translate (v = [x,y,2])
				cylinder (h = 15, r = 6, center = false);
}