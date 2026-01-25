icon($fn=90);
*iconHole($fn=90);

module icon(diameter = 30, height = 2) {
  radius = (diameter - height * 2) / 2;
  union() {
    difference() {
      // base
      cylinder(r=radius, h=height / 2);

      // shape
      rotate([0, 0, -45]) cube([2 * diameter / 3, height, height + 1], center=true);
      rotate([0, 0, 45]) cube([2 * diameter / 3, height, height + 1], center=true);
    }

    // pins
    translate([-radius, 0, 0]) cylinder(d1=height, d2=0, h=height / 2);
    translate([radius, 0, 0]) cylinder(d1=height, d2=0, h=height / 2);
    translate([0, -radius, 0]) cylinder(d1=height, d2=0, h=height / 2);
    translate([0, radius, 0]) cylinder(d1=height, d2=0, h=height / 2);
  }
}

module iconHole(diameter = 30, height = 2, tolerance = .4) {
  radius = (diameter - height * 2 + tolerance) / 2;
  translate([0, 0, -(height + tolerance)]) {
    translate([0, 0, height / 2 + tolerance]) cylinder(d1=diameter - height * 2 + tolerance, d2=diameter + tolerance, h=height / 2 + .1);
    cylinder(r=radius, h=height + tolerance + .1);

    // pins
    translate([-radius, 0, 0]) cylinder(d1=height + tolerance, d2=0, h=height / 2);
    translate([radius, 0, 0]) cylinder(d1=height + tolerance, d2=0, h=height / 2);
    translate([0, -radius, 0]) cylinder(d1=height + tolerance, d2=0, h=height / 2);
    translate([0, radius, 0]) cylinder(d1=height + tolerance, d2=0, h=height / 2);
  }
}
