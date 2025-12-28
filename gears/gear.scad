$fn = 50;

height = 5;
radius = 10;
holeGap = 20;
holeRadius = 3;
holeChamfer = .6;
teeth = radius - 2;

difference() {
  intersection() {
    for (a = [1:teeth]) {
      rotate([0, 0, a * 360 / teeth]) {
        linear_extrude(height) {
          polygon(
            [
              [-radius / 2, 0],
              [0, radius],
              [radius / 2, 0],
            ]
          );
        }
      }
    }

    cylinder(r=radius - 1, h=height);
  }

  rotate_extrude() {
    polygon(
      [
        [0, 0],
        [holeRadius + holeChamfer, 0],
        [holeRadius + holeChamfer, 1],
        [holeRadius, 2],
        [holeRadius, height - 2],
        [holeRadius + holeChamfer, height - 1],
        [holeRadius + holeChamfer, height],
        [0, height],
      ]
    );
  }

  if (radius >= 18) {
    for (a = [0:3]) {
      rotate([0, 0, a * 90]) translate([10, 0, 0]) cylinder(r=1, h=height);
    }
  }
}
