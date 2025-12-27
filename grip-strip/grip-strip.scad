$fn = 100;

cube([30, 10, .6], center=true);
translate([-15, 0, 0]) cylinder(d=10, h=.6, center=true);
translate([15, 0, 0]) cylinder(d=10, h=.6, center=true);
