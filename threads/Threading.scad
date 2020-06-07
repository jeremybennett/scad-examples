// Threading.scad - library for threadings
// Autor: Rudolf Huttary, Berlin 2016

// SPDX-License-Identifier: CC-BY-NC-4.0

use <Naca_sweep.scad> // http://www.thingiverse.com/thing:900137

// examples
showexample = 2;   // choose your example number

// example(showexample)
// {
// // #1 ACME thread
//   threading(pitch = 2, d=20, windings = 5, angle = 29);
//
// // #2 threaded rod 20°
//   threading(pitch = 2, d=20, windings = 30, angle = 20, full = true);
//
// // #3 nut for threaded rod 20°
//   Threading(pitch = 2, d=20, windings = 10, angle = 20);
//
// // #4 nut for threaded rod 20°, own diameter 25 mm, hires
//   Threading(D = 25, pitch = 2, d=20, windings = 10, angle = 20, $fn=100);
//
// // #5 triple helix threaded rod
//   threading(pitch = 2, d=20, windings = 30, helices = 3, angle = 20, full = true);
//
// // #6 toothed rod (no pitch)
//    threading(helices = 0, angle = 20, full = true);
//
// // #7 toothed cube (no pitch)
//    threading(helices = 0, angle = 60, full = true, $fn=4);
//
// // #8 M8 hex bolt
//    union(){
//      threading(pitch = 1.25, d=8, windings=20, full=true); cylinder(d=14.6, h=4, $fn=6);}
// // #9 M8 hex bolt - left hand thread
//    union(){
//      threading(pitch = 1.25, d=8, windings=20, full=true, left = true); cylinder(d=14.6, h=4, $fn=6);}
// // #10 M8 hex nut
//    Threading(D=14.6, pitch = 1.25, d=8, windings=5,  edges=6);
// // #11 M8 four socket nut
//    Threading(D=16, pitch = 1.25, d=8, windings=5, edges=4);
// }

module example(number=0)
{
  if(number>0 && number<=$children) children(number-1);
    help();
}

module help_Threading() help();
module help_threading() help();

module help()
{
  helpstr =
  "<h4>Thread library - by Rudolf Huttary (2016)</h4>
    <h5>modules</h5>
    &nbsp;help();        <i> show help in console</i><br>
    &nbsp;threading(pitch = 1, d = 6, windings = 10, helices = 1, angle = 60, edges=40, full = false, left = false); <br>
    &nbsp;Threading(D = 0, pitch = 1, r = 6, windings = 10, helices = 1, angle = 60, left = false);
    <h5>parameters</h5>
    &nbsp;D = {0=auto};   <i>Cyl diameter Threading()</i><br>
    &nbsp;d = 6;         <i> outer diameter thread()</i><br>
    &nbsp;windings = 10; <i> number of windings</i><br>
    &nbsp;helices = 1;   <i> number of threads</i><br>
    &nbsp;angle = 60;    <i> open angle, bolts: 60°, ACME: 29°, toothed Racks: 20°</i><br>
    &nbsp;edges = 40;    <i> resolution of outer cylinder </i><br>
    &nbsp;left = false;  <i> left handed threading </i><br>
    &nbsp;$fn = 360/$fa; <i> segments per winding</i><br>
    ";
  echo (helpstr);
}

//Threading(R=12, pitch = pitch, r=radius, windings= windings, angle = angle);

module Threading(D = 0, pitch = 1, d = 12, windings = 10, helices = 1, angle = 60, edges=40, left = false)
{
  R = D==0?d/2+pitch/PI:D/2;
  translate([0,0,-pitch])
  difference()
  {
    translate([0,0,pitch])
    cylinder (r=R, h =pitch*(windings-helices), $fn = edges);
    threading(pitch, d, windings, helices, angle, true, left, $fn = $fn);
  }
}

module threading(pitch = 1, d = 12, windings = 10, helices = 1, angle = 60, full = false, left=false)
{  // tricky: glue two 180° pieces together to get a proper manifold
  r = d/2;
  ccw = left?1:-1;
  Steps = $fn?$fn/2:180/$fa;
  Pitch = pitch*helices;
  if(full) cylinder(r = r-.5-pitch/PI, h=pitch*(windings+helices), $fn=$fn);
  translate([0,0,(helices*.5+windings)*pitch])
  {
    sweep(gen_dat());   // half screw
    rotate([0, 0, 180]) translate([0, 0, Pitch/2])
    sweep(gen_dat());   // half screw
  }
  function gen_dat() = let(ang = 180, bar = R_(180, -90, 0, Ty_(-r+.5, vec3D(pitch/PI* Rack(windings, angle)))))
        [for (i=[0:Steps]) Tz_(-i/2/Steps*Pitch, Rz_(ccw*i*ang/Steps, bar))];

  function Rack(w, angle) =
     concat([[0, 2]],
            [for (i=[0:windings-1], j=[0:3])
              let(t = [ [0, 1], [2*tan(angle/2), -1], [PI/2, -1], [2*tan(angle/2)+PI/2, 1]])
              [t[j][0]+i*PI, t[j][1]]], [[w*PI, 1], [w*PI, 2]]);

  function rev(L) = let(N=len(L)) [for(x = [1:N]) x[N-i]];
//    function rev(L) = L;
}
