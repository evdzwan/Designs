$fn = 50;

handle = 5;
connector = 3.2;
radius = 2.4;
gap = 10;

for (a = [0:3]) {
  rotate([0, 0, a * 90]) {
    translate([gap, 0, 0]) cylinder(r=1, h=connector);
    translate([gap, 0, connector]) cylinder(r=radius, h=gap);
    translate([gap, 0, connector + gap]) sphere(r=radius);
    translate([gap, 0, connector + gap]) rotate([0, 270, 0]) cylinder(r=radius, h=gap);
  }
}

translate([gap, 0, connector + gap]) rotate([0, 90, 0]) cylinder(r=radius, h=gap * 2);
translate([gap * 3, 0, connector + gap]) sphere(r=radius);
translate([gap * 3, 0, connector + gap]) {
  difference() {
    cylinder(r=radius, h=gap);
    difference() {
      translate([0, 0, 3]) cylinder(r=radius + .4, h=handle);
      translate([0, 0, 3]) cylinder(r=radius - .4, h=handle);
    }
  }
}
translate([gap * 3, 0, connector + gap * 2]) sphere(r=radius);
