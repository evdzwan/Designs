$fn = 100;

difference() {
  cylinder(d1=60, d2=60, h=5);
  for (a = [0:3]) {
    rotate([0, 0, a * 120]) translate([22, 0, 1]) cylinder(d=3, h=6);
  }
}
