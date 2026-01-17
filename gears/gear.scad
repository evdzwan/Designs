renderGear(radius=20, holeRadius=3.6, toothRadius=2, height=5, type="spiral", $fn=50);

module renderGear(radius, holeRadius, toothRadius, height, type) {
  wallThickness = 1;

  difference() {
    renderBody(radius, toothRadius, height);
    renderConnectorHole(holeRadius, height);
    renderPatternHole(holeRadius * 2 + wallThickness, radius - toothRadius - wallThickness, height);
  }

  renderConnector(holeRadius, height);
  renderPattern(holeRadius * 2 + wallThickness, radius - toothRadius - wallThickness, height, type);
}

module renderConnector(holeRadius, height) {
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

        polygon(
          [
            [holeRadius + 1.2, 0],
            [holeRadius * 2 - .2, 0],
            [holeRadius * 2 - .2, height * 2],
            [holeRadius + 1.2, height * 2],
          ]
        );
      }
    }
  }
}

module renderConnectorHole(holeRadius, height) {
  translate([0, 0, -.5]) {
    difference() {
      cylinder(r=holeRadius * 2, h=height + 1);
      difference() {
        cylinder(r=holeRadius + 1, h=height + 1);
        cylinder(r=holeRadius, h=height + 1);
      }
    }
  }
}

module renderBody(radius, toothRadius, height) {
  teeth = ceil(2 * PI * radius / (toothRadius * 4));

  union() {
    difference() {
      cylinder(r=radius, h=height);
      for (i = [0:teeth - 1]) {
        rotate([0, 0, (i + .5) * (360 / teeth)]) translate([radius, 0, -.5]) cylinder(r=toothRadius, h=height + 1);
      }
    }

    for (i = [0:teeth - 1]) {
      rotate([0, 0, i * (360 / teeth)]) translate([radius - .2, 0, 0]) cylinder(r=toothRadius, h=height);
    }
  }
}

module renderPattern(innerRadius, outerRadius, height, type) {
  if (innerRadius > 2 && outerRadius >= 2) {
    intersection() {
      if (type == "cross") {
        renderCrossInset(outerRadius, height);
      } else if (type == "mesh") {
        renderMeshInset(outerRadius, height);
      } else if (type == "spiral") {
        renderSpiralInset(outerRadius, height);
      }

      difference() {
        translate([0, 0, -.5]) cylinder(r=outerRadius, h=height + 1);
        translate([0, 0, -.5]) cylinder(r=innerRadius, h=height + 1);
      }
    }
  }
}

module renderPatternHole(innerRadius, outerRadius, height) {
  difference() {
    translate([0, 0, -.5]) cylinder(r=outerRadius, h=height + 1);
    translate([0, 0, -.5]) cylinder(r=innerRadius, h=height + 1);
  }
}

module renderCrossInset(radius, height, thickness = 4) {
  union() {
    for (a = [0:1]) {
      rotate([0, 0, a * 90]) translate([0, 0, height / 2]) cube([thickness, radius * 2, height], center=true);
    }
  }
}

module renderMeshInset(radius, height, thickness = 1) {
  union() {
    for (a = [0:1]) {
      for (i = [-ceil(radius / (thickness * 6)) - 1:ceil(radius / (thickness * 6))]) {
        rotate([0, 0, a * 90]) translate([(i + .5) * thickness * 5, 0, height / 2]) cube([thickness, radius * 2, height], center=true);
      }
    }
  }
}

module renderSpiralInset(radius, height, thickness = 4, tendons = 3, curve = 60, steps = 10) {
  union() {
    for (a = [0:tendons - 1]) {
      for (i = [0:steps]) {
        angleFrom = a * (360 / tendons) + i * (curve / steps);
        angleTo = a * (360 / tendons) + (i + 1) * (curve / steps);

        radiusFrom = i * (radius / steps);
        radiusTo = (i + 1) * (radius / steps);

        hull() {
          translate([radiusFrom * cos(angleFrom), radiusFrom * sin(angleFrom), 0]) cylinder(d=thickness, h=height, $fn=steps);
          translate([radiusTo * cos(angleTo), radiusTo * sin(angleTo), 0]) cylinder(d=thickness, h=height, $fn=steps);
        }
      }
    }
  }
}
