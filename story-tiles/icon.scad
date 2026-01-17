icon($fn=90);
*iconHole($fn=90);

module icon(diameter = 30, height = 2) {
  difference() {
    // base
    cylinder(d=diameter - height * 2, h=height / 2);

    // shape
    rotate([0, 0, -45]) cube([2 * diameter / 3, height, height + 1], center=true);
    rotate([0, 0, 45]) cube([2 * diameter / 3, height, height + 1], center=true);
  }
}

module iconHole(diameter = 30, height = 2, tolerance = .4) {
  translate([0, 0, -(height + tolerance)]) {
    translate([0, 0, height / 2 + tolerance]) cylinder(d1=diameter - height * 2 + tolerance, d2=diameter + tolerance, h=height / 2 + .1);
    cylinder(d=diameter - height * 2 + tolerance, h=height + tolerance + .1);
  }
}
