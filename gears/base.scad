use <../shapes.scad>
$fn = 50;

renderBase(holes=[4, 4], gap=20, height=4);

module renderBase(holes, gap, height) {
  dimensions = [holes[0] * gap, holes[1] * gap];
  connectorSize = 6;
  holeRadius = 2;

  translate([-dimensions[0] / 2, -dimensions[1] / 2, 0]) {
    difference() {
      roundedCube([dimensions[0], dimensions[1], height], radius=height);

      for (y = [0:holes[1] - 1])
        for (x = [0:holes[0] - 1])
          translate([(x + .5) * gap, (y + .5) * gap, -.5]) cylinder(r=holeRadius + .2, h=height + 2);

      translate([dimensions[0] / 2, 0, -.5]) rotate([0, 0, 90]) renderConnector(connectorSize + .2, height + 1);
      translate([0, dimensions[1] / 2, -.5]) renderConnector(connectorSize, height + 1);

      for (y = [1:holes[1] - 1])
        for (x = [1:holes[0] - 1])
          translate([x * gap, y * gap, -.5]) cylinder(r=gap / 2 - holeRadius, h=height + 1);
    }

    translate([dimensions[0] / 2, dimensions[1], 0]) rotate([0, 0, 90]) renderConnector(connectorSize, height);
    translate([dimensions[0], dimensions[1] / 2, 0]) renderConnector(connectorSize, height);
  }

  module renderConnector(size, height) {
    linear_extrude(height)
      polygon(
        [
          [0, -(size - 1)],
          [0, size - 1],
          [size, size],
          [size, -size],
        ]
      );
  }
}
