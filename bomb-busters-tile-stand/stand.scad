holeCount = 14;
holeDepth = 4;
holeSpacing = 2;
holeWidth = 10;

standBorder = 4;
standSize = 20;

difference() {
  renderBody();
  renderFrontHoles();
  renderRearHoles();
}

module renderBody() {
  translate([0, holeCount * (holeWidth + holeSpacing) - holeSpacing + standBorder * 2, 0]) {
    rotate([90, 0, 0]) {
      linear_extrude(height=holeCount * (holeWidth + holeSpacing) - holeSpacing + standBorder * 2) {
        polygon(
          [
            [0, 0],
            [standSize - standBorder, 0],
            [standSize - standBorder, standBorder],
            [standBorder, standSize - standBorder],
            [0, standSize - standBorder],
          ]
        );
      }
    }
  }
}

module renderFrontHoles() {
  for (i = [0:holeCount - 1]) {
    translate([10, i * (holeWidth + holeSpacing) + standBorder, standBorder / 2]) rotate([0, -30, 0]) cube([holeDepth, holeWidth, standSize]);
    translate([11, i * (holeWidth + holeSpacing) + standBorder, standBorder]) rotate([0, -30, 0]) cube([holeDepth, holeWidth, standSize]);
  }
}

module renderRearHoles() {
  for (i = [0:holeCount - 1]) {
    translate([-3.6, i * (holeWidth + holeSpacing) + standBorder, -standBorder]) rotate([0, -15, 0]) cube([holeDepth * 2, holeWidth, standSize]);
  }
}
