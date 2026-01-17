use <../shapes.scad>

renderBase(size=[1, 1], gap=10, height=10, holeRadius=3.6, $fn=50);

module renderBase(size, gap, height, holeRadius) {
  holesFactor = 5;
  holes = [size[0] * holesFactor, size[1] * holesFactor];
  dimensions = [holes[0] * gap, holes[1] * gap, height];
  connectorSize = 5;

  translate([-dimensions[0] / 2, -dimensions[1] / 2, 0]) {
    difference() {
      union() {
        roundedCube(dimensions, radius=holeRadius);
        for (x = [0:size[0] - 1]) {
          translate([(x + .5) * gap * holesFactor, dimensions[1] + .2, 0]) rotate([0, 0, 90]) renderConnector(connectorSize - .2, height);
        }

        for (y = [0:size[1] - 1]) {
          translate([dimensions[0] + .2, (y + .5) * gap * holesFactor, 0]) renderConnector(connectorSize - .2, height);
        }
      }

      for (y = [0:holes[1] - 1]) {
        for (x = [0:holes[0] - 1]) {
          if (!(x == 0 && y % holesFactor == 2) && !(x % holesFactor == 2 && y == 0)) {
            translate([(x + .5) * gap, (y + .5) * gap, -.5]) cylinder(r=holeRadius, h=height + 1, $fn=6);
          }
        }
      }

      for (x = [0:size[0] - 1]) {
        translate([(x + .5) * gap * holesFactor, 0, -.5]) rotate([0, 0, 90]) renderConnector(connectorSize, height + 1);
      }

      for (y = [0:size[1] - 1]) {
        translate([0, (y + .5) * gap * holesFactor, -.5]) renderConnector(connectorSize, height + 1);
      }
    }
  }
}

module renderConnector(size, height) {
  translate([0, 0, height / 2]) cube([size, size * 1.6, height], center=true);
  translate([0, -size, 0]) roundedCube([size, size * 2, height], radius=size / 2);
}
