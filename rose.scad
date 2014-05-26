// Watering Can Rose 3D Design

// Copyright (c) 2014 by Jeremy Bennett <jeremy.bennett@embecosm.com>

// Watering Can Rose 3D Design is licensed under a Creative Commons
// Attribution-ShareAlike 3.0 Unported License.

// You should have received a copy of the license along with this work.  If not, 
// see <http://creativecommons.org/licenses/by-sa/3.0/>.

// -----------------------------------------------------------------------------

// Connector at top of rose

// We add a tiny taper to help grip the thread, so we will have a slightly
// larger id at the top.

// @param id  Inside diameter
// @param od  Outside diameter
// @param hc  Height of the connector
// @param hr  Height of the rose (above which we sit)
module connector (id, od, hc, hr) {
	iota = hr / 100;
	taper = 0.4;							// Amount ID is bigger at top
	difference () {
		translate (v = [0, 0, hr - iota])
			cylinder (d1 = od, d2 = od + taper, h = hc + iota, center = false);
		translate (v = [0, 0, hr - iota * 2])
			cylinder (d1 = id, d2 = id + taper, h = hc + iota * 3, center = false);
	}
}


// Cone for the rose

// @param id1  Inside diameter at the bottom
// @param id2  Inside diameter at the top
// @param od1  Outside diameter at the bottom
// @param od2  Outside diameter at the top
// @param hr   Height of the rose
module cone (id1, id2, od1, od2, hr) {
	iota = hr / 100;
	difference () {
		cylinder (d1 = od1, d2 = od2, h = hr, center = false);
		cylinder (d1 = id1, d2 = id2, h = hr + iota, center = false);
	}
}


// Holes for the rose

// @param rim  The radius of the rim limit
// @param hd   Diameter of the hole
// @param bt   Base thickness
module spray_holes (rim, hd, bt) {
	iota = rim / 100;
	ht = bt + iota * 2;					// Hole thickness to ensure cuts through
	for (x = [0 : hd * 2 : rim])
		for (y = [0 : hd * 2 : rim])
			assign (r = x * x + y * y)
				if (r < (rim * rim)) {
					translate (v = [x, y, -iota])
						cylinder (d = hd, h = ht, center = false);
					if (x != 0)
						translate (v = [-x, y, -iota])
							cylinder (d = hd, h = ht, center = false);	
					if (y != 0)
						translate (v = [x, -y, -iota])
						cylinder (d = hd, h = ht, center = false);	
					if ((x != 0) && (y != 0))
						translate (v = [-x, -y, -iota])
							cylinder (d = hd, h = ht, center = false);	
				}
}

// Watering can rose.

// @param hr  Height of the rose
// @param ra  Rose angle
// @param id  Inner diameter of the connector
// @param ch  Connector height
module rose (hr, ra, id, hc) {
	iota = hr / 100;
	t = 2;									// Wall thickness
	bt = 1;								// Base thickness
	hd = 2.5;                        // Hole diameter
	od = id + t * 2;						// Outside diameter of the connector
	dr = 2 * hr / tan (ra);				// Diameter of the rose (excl connector)
	difference () {
		intersection () {
			union () {
				connector (id = id, od = od, hc = hc, hr = hr);
				cone (id1 = id + dr, id2 = id, od1 = od + dr, od2 = od, hr = hr);
				cylinder (d = id + dr, h = bt, center = false);	// The base
			};
			translate (v = [0, 0, -iota] )
				cylinder (d = (id + od) / 2 + dr, h = hr + hc + iota * 2,
				          center = false);
		};
		spray_holes (rim = (id + dr) / 2 - hd, hd = hd, bt = bt);
	}
}

// Internal diameter of connector is 15.67mm, depth of connector is 4mm.

// Although we want 15.67, we think plastic spread means we come out about 0.3
// smaller.
rose (hr = 48, ra = 70, id = 16.00, hc = 4.0);