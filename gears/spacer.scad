renderSpacer(holeRadius=3.6, height=10, withPeg=false, $fn=50);

module renderSpacer(holeRadius, height, withPeg = false) {
  pegHeight = 5;

  difference() {
    cylinder(r=holeRadius * 2 + 1, h=height);
    translate([0, 0, -.5]) cylinder(r=holeRadius * 2, h=height + 1);
  }

  difference() {
    cylinder(r=holeRadius + 1, h=height);
    translate([0, 0, -.5]) cylinder(r=holeRadius, h=height + 1);
  }

  for (a = [0:1]) {
    rotate([0, 0, a * 180 + .5]) {
      rotate_extrude(angle=89) {
        polygon(
          [
            [holeRadius + 1, 0],
            [holeRadius * 2 + .2, 0],
            [holeRadius * 2 + .2, height],
            [holeRadius + 1, height],
          ]
        );

        if (withPeg) {
          polygon(
            [
              [holeRadius + 1 + .2, 0],
              [holeRadius * 2 - .2, 0],
              [holeRadius * 2 - .2, height + pegHeight],
              [holeRadius + 1 + .2, height + pegHeight],
            ]
          );
        }
      }
    }
  }
}
