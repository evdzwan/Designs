use <peg.scad>

renderGear(radius=20, height=4, pegRadius=2, type="spiral", $fn=20);

module renderGear(radius, height, pegRadius, type, wallThickness = 2, toothLength = 4) {
  union() {
    renderTeeth(radius, height, toothLength);

    difference() {
      translate([0, 0, height / 2]) {
        intersection() {
          union() {
            if (type == "cross") {
              renderCrossInset(radius, height, wallThickness);
            } else if (type == "hash") {
              renderHashInset(radius, height, wallThickness);
            } else if (type == "spiral") {
              renderSpiralInset(radius, height, wallThickness);
            }
          }

          cylinder(r=radius - toothLength / 2 - wallThickness, h=height, center=true);
        }
      }

      cylinder(r=pegRadius, h=height);
    }

    difference() {
      cylinder(r=radius - toothLength / 2, h=height + 1);
      cylinder(r=radius - toothLength / 2 - wallThickness, h=height + 1);
    }

    difference() {
      cylinder(r=pegRadius + wallThickness, h=height);
      renderPegCross(pegRadius, height);
    }
  }
}

module renderCrossInset(radius, height, thickness) {
  for (a = [0:1]) {
    rotate([0, 0, a * 90]) cube([thickness, radius * 2, height], center=true);
  }
}

module renderHashInset(radius, height, thickness) {
  for (a = [0:1]) {
    for (i = [-floor(radius / (thickness * 4)):floor(radius / (thickness * 4))]) {
      rotate([0, 0, a * 90]) translate([i * thickness * 4, 0, 0]) cube([thickness, radius * 2, height], center=true);
    }
  }
}

module renderSpiralInset(radius, height, thickness, tendons = 3, curve = 60, steps = 10) {
  for (a = [0:tendons - 1]) {
    for (i = [0:steps - 2]) {
      angleFrom = a * (360 / tendons) + i * (curve / steps);
      angleTo = a * (360 / tendons) + (i + 1) * (curve / steps);

      radiusFrom = i * (radius / steps);
      radiusTo = (i + 1) * (radius / steps);

      hull() {
        translate([radiusFrom * cos(angleFrom), radiusFrom * sin(angleFrom), 0]) cylinder(d=thickness, h=height, center=true, $fn=steps);
        translate([radiusTo * cos(angleTo), radiusTo * sin(angleTo), 0]) cylinder(d=thickness, h=height, center=true, $fn=steps);
      }
    }
  }
}

module renderTeeth(radius, height, length) {
  intersection() {
    union() {
      count = ceil((radius + length / 2) - 2);
      for (a = [0:count]) {
        rotate([0, 0, a * 360 / count]) {
          linear_extrude(height) {
            polygon(
              [
                [-radius / 1.5, 0],
                [0, radius + length / 2],
                [radius / 1.5, 0],
              ]
            );
          }
        }
      }
    }

    translate([0, 0, height / 2]) {
      difference() {
        cylinder(r=radius + length / 2 - 1, h=height, center=true);
        cylinder(r=radius - length / 2, h=height + 1, center=true);
      }
    }
  }
}
