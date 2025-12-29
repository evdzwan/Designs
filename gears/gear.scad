$fn = 50;

renderGear(radius=20, height=4, type="spiral");

module renderGear(radius, height, type) {
  pegHeight = 3;
  holeRadius = 2;
  toothLength = 4;
  teethCount = ceil((radius + toothLength / 2) - 2);
  wallThickness = 2;

  intersection() {
    union() {
      for (a = [0:teethCount])
        rotate([0, 0, a * 360 / teethCount])
          linear_extrude(height)
            polygon(
              [
                [-radius / 1.5, 0],
                [0, radius + toothLength / 2],
                [radius / 1.5, 0],
              ]
            );
    }

    translate([0, 0, height / 2])
      difference() {
        cylinder(r=radius + toothLength / 2 - 1, h=height, center=true);
        cylinder(r=radius - toothLength / 2, h=height + 1, center=true);
      }
  }

  translate([0, 0, height / 2]) {
    difference() {
      union() {
        intersection() {
          union() {
            if (type == "cross") {
              for (a = [0:1])
                rotate([0, 0, a * 90]) cube([wallThickness, radius * 2, height], center=true);
            } else if (type == "hash") {
              for (a = [0:1])
                for (i = [-floor(radius / (wallThickness * 4)):floor(radius / (wallThickness * 4))])
                  rotate([0, 0, a * 90]) translate([i * wallThickness * 4, 0, 0]) cube([wallThickness, radius * 2, height], center=true);
            } else if (type == "spiral") {
              tendons = 3;
              steps = 10;
              curve = 60;

              for (a = [0:tendons - 1]) {
                for (i = [0:steps - 2]) {
                  angleFrom = a * (360 / tendons) + i * (curve / steps);
                  angleTo = a * (360 / tendons) + (i + 1) * (curve / steps);

                  radiusFrom = i * (radius / steps);
                  radiusTo = (i + 1) * (radius / steps);

                  hull() {
                    translate([radiusFrom * cos(angleFrom), radiusFrom * sin(angleFrom), 0]) cylinder(d=wallThickness, h=height, center=true, $fn=steps);
                    translate([radiusTo * cos(angleTo), radiusTo * sin(angleTo), 0]) cylinder(d=wallThickness, h=height, center=true, $fn=steps);
                  }
                }
              }
            }
          }

          cylinder(r=radius - toothLength / 2 - wallThickness, h=height, center=true);
        }

        difference() {
          cylinder(r=radius - toothLength / 2, h=height, center=true);
          cylinder(r=radius - toothLength / 2 - wallThickness, h=height + 1, center=true);
        }

        cylinder(r=holeRadius + wallThickness, h=height, center=true);
        translate([0, 0, height / 2])
          difference() {
            rotate_extrude()
              polygon(
                [
                  [0, 0],
                  [holeRadius, 0],
                  [holeRadius, pegHeight - 1],
                  [holeRadius - 1, pegHeight],
                  [0, pegHeight],
                ]
              );

            difference() {
              union() {
                translate([0, 0, pegHeight / 2]) cube([.6, holeRadius * 2, pegHeight + 1], center=true);
                translate([0, 0, pegHeight / 2]) cube([holeRadius * 2, .6, pegHeight + 1], center=true);
              }

              cylinder(r=holeRadius - .6, h=pegHeight + 2);
            }
          }
      }

      translate([0, 0, -height / 2])
        rotate_extrude()
          polygon(
            [
              [0, -1],
              [holeRadius + .2, -1],
              [holeRadius + .2, pegHeight - 1 + .2],
              [holeRadius - 1 + .2, pegHeight + .2],
              [0, pegHeight + .2],
            ]
          );
    }

    difference() {
      union() {
        translate([0, 0, -(height - pegHeight) / 2]) cube([.4, (holeRadius + .2) * 2, pegHeight], center=true);
        translate([0, 0, -(height - pegHeight) / 2]) cube([(holeRadius + .2) * 2, .4, pegHeight], center=true);
      }
      translate([0, 0, -height / 2 - .5]) cylinder(r=holeRadius - .2, h=pegHeight + 1);
    }
  }
}
