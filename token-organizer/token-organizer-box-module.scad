module renderBox(size, height, bottom, radius, insetHeight) {
  spacing = .4;
  slotSize = size - radius * 2 - spacing * 2;

  union() {
    difference() {
      renderHull(size, height, radius, insetHeight);
      translate([0, 0, bottom]) {
        scale([.9, .9, 1]) {
          renderHull(size, height, radius, insetHeight);
        }
      }

      translate([0, 0, height / 2 - insetHeight / 2 + .5]) {
        scale([.9, .9, 1]) {
          cube([size, size - radius * 2, insetHeight + 1], center=true);
          cube([size - radius * 2, size, insetHeight + 1], center=true);
        }
      }
    }

    translate([0, 0, -(height / 2 + insetHeight / 2)]) {
      scale([.9, .9, 1]) {
        cube([slotSize + radius * 2, slotSize, insetHeight], center=true);
        cube([slotSize, slotSize + radius * 2, insetHeight], center=true);

        for (y = [-1:1]) {
          if (y != 0) {
            for (x = [-1:1]) {
              if (x != 0) {
                translate([x * slotSize / 2, y * slotSize / 2, 0]) {
                  cylinder(r1=radius, r2=radius * 1.5, h=insetHeight, center=true);
                }
              }
            }
          }
        }
      }
    }
  }

  module renderHull(size, height, radius, insetHeight) {
    union() {
      cube([size - radius * 2, size - radius * 2, height], center=true);

      for (y = [-1:1]) {
        if (y != 0) {
          for (x = [-1:1]) {
            if (x != 0) {
              translate([x * (size - 2 * radius) / 2, y * (size - 2 * radius) / 2, 0]) {
                cylinder(h=height, r=radius, center=true);
              }

              translate([x * (size - 2 * radius) / 2, 0, 0]) {
                cube([radius * 1.5, size - 2 * radius, height], center=true);
              }

              translate([0, y * (size - 2 * radius) / 2, 0]) {
                cube([size - 2 * radius, radius * 1.5, height], center=true);
              }
            }
          }
        }
      }
    }
  }
}
