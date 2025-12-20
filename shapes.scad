module roundedCube(size, radius, center = false) {
  translate([center ? -(size[0] / 2) : 0, center ? -(size[1] / 2) : 0, center ? -(size[2] / 2) : 0]) {
    translate([radius, radius, 0]) cube([size[0] - radius * 2, size[1] - radius * 2, size[2]]);

    for (y = [0:1]) {
      for (x = [0:1]) {
        translate([x * (size[0] - radius * 2) + radius, y * (size[1] - radius * 2) + radius, 0]) cylinder(r=radius, h=size[2]);
      }
    }

    for (i = [0:1]) {
      translate([i * (size[0] - radius), radius, 0]) cube([radius, size[1] - radius * 2, size[2]]);
      translate([radius, i * (size[1] - radius), 0]) cube([size[0] - radius * 2, radius, size[2]]);
    }
  }
}
