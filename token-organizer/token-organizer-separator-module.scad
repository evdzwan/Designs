module renderSeparator(x, y, z, r, s) {
  union() {
    difference() {
      translate([0, 0, z / 2]) cube([x - r * 1.75, y, z], center=true);
      translate([0, 0, z - z / 4]) cube([y + s * 2, y + s * 2, z / 2 + s * 2], center=true);
    }

    for (i = [-1:1]) {
      if (i != 0) {
        intersection() {
          translate([i * (x - r * 4) / 2, 0, z / 2]) cylinder(r=r - s * 2, h=z, center=true);
          translate([i * (x - r * 2) / 2, 0, z / 2]) cylinder(r=r - s * 2, h=z, center=true);
        }
      }
    }
  }
}
