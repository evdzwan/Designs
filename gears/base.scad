include <../shapes.scad>
$fn = 50;

height = 5;
radius = 4;

holeGap = 20;
holeRadius = 3;
holeChamfer = .6;
holesX = 3;
holesY = 3;

translate([-holesX * holeGap / 2, -holesY * holeGap / 2, 0]) {
  difference() {
    roundedCube([holesX * holeGap, holesY * holeGap, height], radius);
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
