// Sunshade upper clip
//
// Copyright (C) 2019 Jeremy Bennett <www.jeremybennett.com>
// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>
//
// SPDX-License-Identifier: CC-BY-SA-4.0

// A test disc for pole fit.

// The 3D printer is calibrated so that X-Y are around 2% too small, sizes are
// adjusted accordingly

POLE_R = 26.9 / 2.0;		// Actual 25.3, plus 0.5 gap each side
INNER_R = 53.0 / 2.0;		// 2% is about enough for easy play each side

difference () {
     cylinder (r = INNER_R, h = 3, center = true, $fn = 72);
     cylinder (r = POLE_R, h = 5, center = true, $fn = 72);
}
