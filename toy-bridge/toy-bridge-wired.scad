$fn = 10;

translate([-35, 0, 0]) {
  renderBase();
}

translate([-35 - 8 / 2, 100, 0]) {
  renderArm(-1);
}

translate([-30, 0, 2]) {
  renderFrontCables(-1);
  renderRearCable(-1);
}

translate([35 - 8 / 2, 100, 0]) {
  renderArm(1);
}

translate([30, 0, 2]) {
  renderFrontCables(1);
  renderRearCable(1);
}

module renderArm(multiplier) {
  rotate([90 - 12 * multiplier, 0, 90]) {
    linear_extrude(8) {
      polygon(
        [
          [0, -2],
          [20, -2],
          [32, 5],
          [65, 6],
          [80, 12 - 2],
          [20, 12],
          [40, 12 + 45],
          [44, 12 + 70],
          [50, 12 + 76],
          [45, 12 + 98],
          [46, 12 + 108],
          [42, 12 + 115],
          [30, 12 + 45],
        ]
      );
    }
  }
}

module renderBase() {
  cube([70, 220, 12]);
}

module renderFrontCables(multiplier) {
  for (i = [0:5]) {
    translate([0, 10 + 10 * i, 0]) {
      rotate([-48 - i * .4, -9.7 * multiplier + .3 * i, 0]) {
        cylinder(h=180 - 17 * i, d=2);
      }
    }
  }
}

module renderRearCable(multiplier) {
  translate([0, 210, 0]) {
    rotate([37.4, -9 * multiplier, 0]) {
      cylinder(h=105, d=4);
    }
  }
}
