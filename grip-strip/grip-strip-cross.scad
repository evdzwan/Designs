$fn = 100;

hull() {
  translate([-25, 0, 0]) cylinder(d=10, h=.6, $fn=50);
  translate([25, 0, 0]) cylinder(d=10, h=.6, $fn=50);
}

rotate([0, 0, 90]) {
  hull() {
    translate([-25, 0, 0]) cylinder(d=10, h=.6, $fn=50);
    translate([25, 0, 0]) cylinder(d=10, h=.6, $fn=50);
  }
}
