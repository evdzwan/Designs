include <token-organizer-separator-module.scad>

module renderBox(x, y, z, r, t, i, s) {
  translate([0, 0, i]) {
    difference() {
      renderBase(x, y, z, r);
      translate([r / 2, r / 2, r / 2]) renderBase(x - r, y - r, z, r);
      translate([x / 2, y / 2, r / 2 - r / 4]) rotate([0, 0, 45]) renderSeparator(sqrt(x * x + y * y) + s * 2, t + s * 2, z - r / 2 + r / 4, r, s);
      translate([x / 2, y / 2, r / 2 - r / 4]) rotate([0, 0, 315]) renderSeparator(sqrt(x * x + y * y) + s * 2, t + s * 2, z - r / 2 + r / 4, r, s);
    }

    translate([r - s, r - s, -i]) renderBase(x - (r - s) * 2, y - (r - s) * 2, i, r);
  }
}

module renderBase(x, y, z, r) {
  union() {
    translate([r, r, 0]) cube([x - r * 2, y - r * 2, z]);

    translate([r, r, 0]) cylinder(r=r, h=z);
    translate([x - r, r, 0]) cylinder(r=r, h=z);
    translate([x - r, y - r, 0]) cylinder(r=r, h=z);
    translate([r, y - r, 0]) cylinder(r=r, h=z);

    translate([r, 0, 0]) cube([x - r * 2, r, z]);
    translate([r, y - r, 0]) cube([x - r * 2, r, z]);
    translate([0, r, 0]) cube([r, y - r * 2, z]);
    translate([x - r, r, 0]) cube([r, y - r * 2, z]);
  }
}
