include <../shapes.scad>
$fn = 50;

height = 5;
connectorSize = 4;
radius = 4;
sizeX = 2;
sizeY = 1;

holeGap = 20;
holeRadius = 3;
holeChamfer = .6;
holesX = sizeX * 3;
holesY = sizeY * 3;

dimX = holesX * holeGap;
dimY = holesY * holeGap;

difference() {
  translate([-dimX / 2, -dimY / 2, 0]) {
    difference() {
      roundedCube([dimX, dimY, height], radius);

      for (y = [0:holesY - 1]) {
        for (x = [0:holesX - 1]) {
          translate([x * holeGap + holeGap / 2, y * holeGap + holeGap / 2, 0]) {
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
          }
        }
      }
    }
  }

  for (x = [0:sizeX - 1]) {
    translate([-dimX / 2 + (x + .5) * dimX / sizeX, -dimY / 2, 0]) rotate([0, 0, 90]) renderConnector(connectorSize + .1);
  }

  for (y = [0:sizeY - 1]) {
    translate([-dimX / 2, -dimY / 2 + (y + .5) * dimY / sizeY, 0]) renderConnector(connectorSize + .1);
  }
}

for (x = [0:sizeX - 1]) {
  translate([-dimX / 2 + (x + .5) * dimX / sizeX, dimY / 2, 0]) rotate([0, 0, 90]) renderConnector(connectorSize);
}

for (y = [0:sizeY - 1]) {
  translate([dimX / 2, -dimY / 2 + (y + .5) * dimY / sizeY, 0]) renderConnector(connectorSize);
}

module renderConnector(size) {
  linear_extrude(height) {
    polygon(
      [
        [0, -(size * 2 - 2)],
        [0, size * 2 - 2],
        [size, size * 2],
        [size, -size * 2],
      ]
    );
  }
}
