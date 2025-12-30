use <../shapes.scad>
use <peg.scad>

renderBase(size=[1, 1], gap=20, pegRadius=2, height=4, $fn=20);

module renderBase(size, gap, pegRadius, height, connectorSize = 6) {
  holes = [size[0] * 3, size[1] * 3];
  dimensions = [holes[0] * gap, holes[1] * gap, height];

  translate([-dimensions[0] / 2, -dimensions[1] / 2, 0]) {
    difference() {
      roundedCube(dimensions, radius=height);
      for (y = [0:holes[1] - 1]) {
        for (x = [0:holes[0] - 1]) {
          translate([(x + .5) * gap, (y + .5) * gap, 0]) renderPegHole(pegRadius, height);
        }
      }

      for (y = [0:holes[1] - 2]) {
        for (x = [0:holes[0] - 2]) {
          translate([(x + 1) * gap, (y + 1) * gap, 0]) cylinder(r=(gap - pegRadius) / 2, h=height);
        }
      }

      for (x = [0:size[0] - 1]) {
        translate([(x * 3 + 1.5) * gap, 0, 0]) rotate([0, 0, 90]) renderConnector(connectorSize + .2, height);
      }

      for (y = [0:size[1] - 1]) {
        translate([0, (y * 3 + 1.5) * gap, 0]) renderConnector(connectorSize + .2, height);
      }
    }

    for (x = [0:size[0] - 1]) {
      translate([(x * 3 + 1.5) * gap, dimensions[1], 0]) rotate([0, 0, 90]) renderConnector(connectorSize, height);
    }

    for (y = [0:size[1] - 1]) {
      translate([dimensions[0], (y * 3 + 1.5) * gap, 0]) renderConnector(connectorSize, height);
    }
  }
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
