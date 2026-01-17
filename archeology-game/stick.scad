stick(size=[10, 100], magnet=[6, 3], $fn=20);

module stick(size, magnet, tolerance = .2) {
  difference() {
    union() {
      cylinder(d=size[0] * 1.6, h=size[1] / 2, $fn=6);
      cylinder(d=size[0], h=size[1]);
    }
    translate([0, 0, size[1] - magnet[1] - 1]) cylinder(d=magnet[0] + tolerance, h=magnet[1] + tolerance);
  }
}
