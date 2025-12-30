renderPeg(radius=2, partHeight=4, $fn=20);

module renderPeg(radius, partHeight) {
  height = partHeight * 2 + 1;

  union() {
    difference() {
      intersection() {
        rotate_extrude() {
          polygon(
            [
              [0, 0],
              [radius, 0],
              [radius, 1],
              [radius - .4, 1],
              [radius - .4, height - 1],
              [radius, height - 1],
              [radius, height],
              [0, height],
            ]
          );
        }

        union() {
          for (a = [0:1]) {
            rotate([0, 0, a * 90]) translate([0, 0, height / 2]) cube([.8 * radius, radius * 2, height], center=true);
          }
        }
      }

      for (a = [0:1]) {
        for (y = [0:1]) {
          rotate([0, 0, a * 90]) translate([0, 0, y * (height - partHeight) + partHeight / 2]) cube([.2 * radius, radius * 2, partHeight], center=true);
        }
      }
    }

    translate([0, 0, partHeight]) cylinder(r=radius, h=1);
  }
}

module renderPegHole(radius, height) {
  rotate_extrude() {
    polygon(
      [
        [0, 0],
        [radius + .2, 0],
        [radius + .2, 1.2],
        [radius - .2, 1.2],
        [radius - .2, height - 1.2],
        [radius + .2, height - 1.2],
        [radius + .2, height],
        [0, height],
      ]
    );
  }
}

module renderPegCross(radius, height) {
  intersection() {
    renderPegHole(radius, height);
    union() {
      for (a = [0:1]) {
        rotate([0, 0, a * 90]) translate([0, 0, height / 2]) cube([.8 * (radius + .2), (radius + .2) * 2, height], center=true);
      }
    }
  }
}
