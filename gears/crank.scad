renderCrank(holeRadius=3.6, height=5, double=false, $fn=50);

module renderCrank(holeRadius, height, double = false) {
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
      }
    }
  }

  for (a = [0:(double ? 1 : 0)]) {
    rotate([0, 0, 45 + 180 * a]) {
      translate([holeRadius * 2 + height * 1.5, 0, height / 2]) cube([height * 3, height * .75, height], center=true);
      translate([holeRadius * 2 + height * 3, 0, 0]) cylinder(r=height / 2, h=height * 3);
    }
  }
}
