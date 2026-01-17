bone(size=[20, 10, 5], magnet=[6, 3], $fn=20);

module bone(size, magnet, tolerance = .2) {
  difference() {
    hull() {
      translate([-size[0] / 2, 0, 0]) cylinder(d=8, h=5);
      translate([size[0] / 2, 0, 0]) cylinder(d=8, h=5);
    }

    translate([0, 0, size[2] / 2]) cylinder(d=magnet[0] + tolerance, h=magnet[1] + tolerance, center=true);
  }
}
