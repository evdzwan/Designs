$fn = 100;

difference() {
  cylinder(d1=68, d2=60, h=6);
  for (a = [0:3]) {
    rotate([0, 0, a * 120]) translate([25, 0, 1]) cylinder(d=3, h=6);
  }
}
