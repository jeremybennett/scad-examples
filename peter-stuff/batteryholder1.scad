
difference() {
	cube(size = [140,140,20],
	center = false);
	for ( x = [10 : 20 : 130] )
		for (y = [ 10 : 20 : 130] )
			translate (v = [x,y,5])
				cylinder (h = 15, r = 8, center = false);
}