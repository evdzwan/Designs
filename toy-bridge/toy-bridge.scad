include <../text.scad>
$fn = 50;

baseWidth = 40;
baseHeight = 12;
baseLength = 210;
baseRadius = 1;
baseExtra = 15;
baseInset = 20;

trackWidth = 7;
trackDepth = 4;
trackOffset = 4;

linkOffset = 12;
linkWidth = 6;
linkSize = 11;

armOffset = 100;
armThickness = 8;

armHoleInnerSize = 1.8;
armHoleOuterSize = 2.4;

baseHoleInnerSize = 2;
baseHoleOuterSize = 3;

// base
difference() {
  renderBase();

  translate([-baseExtra / 2, 0, 0]) {
    renderBaseHoles();
  }

  translate([baseWidth + baseExtra / 2, 0, 0]) {
    renderBaseHoles();
  }

  translate([baseWidth + baseExtra / 2, armOffset + (baseLength - armOffset) / 3, baseHeight - baseRadius]) {
    rotate([0, 0, 90]) {
      logo(size=6, thickness=baseRadius);
    }
  }
}

// links
union() {
  translate([baseWidth / 2, -linkOffset, 0]) {
    renderLink();
  }

  translate([baseWidth / 2, baseLength + linkOffset, 0]) {
    rotate([0, 0, 180]) {
      renderLink();
    }
  }
}

// arms
difference() {
  union() {
    translate([-armThickness * 2, armOffset, 0]) {
      rotate([0, 12, 0]) {
        difference() {
          renderArm();
          renderArmHoles();
        }

        renderArmPin();
      }
    }

    translate([baseWidth + armThickness * 2, armOffset, 0]) {
      rotate([0, -12, 0]) {
        difference() {
          renderArm();
          renderArmHoles();
        }

        renderArmPin();
      }
    }
  }

  translate([-baseExtra * 2, 0, -baseHeight]) {
    cube([baseWidth + baseExtra * 4, baseLength, baseHeight]);
  }
}

module renderArm() {
  translate([-armThickness / 2, 0, 0]) {
    rotate([90, 0, 90]) {
      linear_extrude(armThickness) {
        polygon(
          [
            [0, -2],
            [20, -2],
            [32, 5],
            [65, 6],
            [80, baseHeight - 2],
            [20, baseHeight],
            [40, baseHeight + 45],
            [44, baseHeight + 70],
            [50, baseHeight + 76],
            [45, baseHeight + 98],
            [46, baseHeight + 108],
            [42, baseHeight + 115],
            [30, baseHeight + 45],
          ]
        );
      }
    }
  }
}

module renderArmHoles() {
  for (i = [1:6]) {
    height = i == 4 ? (baseHeight + 1) : i == 5 ? (baseHeight - 3) : (baseHeight - i);
    offset = i == 4 ? 5 : i == 5 ? 2 : 0;

    translate([0, 41.8 + offset + i * 0.7, baseHeight + 44 + i * 10]) {
      rotate([80, 0, 0]) {
        renderArmHole(height);

        if (i == 1 || i == 3 || i == 5) {
          translate([-armHoleInnerSize / 2, 0, 0]) {
            cube([armHoleInnerSize, 10, baseHeight / 2]);
          }
        }
      }
    }
  }

  translate([0, 49.2, baseHeight + 70]) {
    rotate([40, 0, 0]) {
      cylinder(h=10, d=5);
    }
  }
}

module renderArmHole(height) {
  rotate_extrude() {
    polygon(
      [
        [0, 0],
        [armHoleInnerSize, 0],
        [armHoleInnerSize, height / 2],
        [armHoleInnerSize, height / 2 + baseRadius],
        [armHoleInnerSize, height - baseRadius],
        [armHoleOuterSize, height],
        [0, height],
      ]
    );
  }
}

module renderArmPin() {
  translate([0, 42, baseHeight + 72.5]) {
    rotate([0, 0, 0]) {
      cylinder(h=armHoleOuterSize, d=1.6);
    }
  }
}

module renderBase() {
  translate([0, baseLength, 0]) {
    rotate([90, 0, 0]) {
      difference() {
        linear_extrude(baseLength) {
          polygon(
            [
              [-baseExtra + baseRadius, 0],
              [baseWidth + baseExtra - baseRadius, 0],
              [baseWidth + baseExtra, baseRadius],
              [baseWidth + baseExtra, baseHeight - baseRadius],
              [baseWidth + baseExtra - baseRadius, baseHeight],
              [baseWidth + baseRadius * 2, baseHeight],
              [baseWidth + baseRadius, baseHeight - baseRadius],
              [baseWidth, baseHeight - baseRadius],
              [baseWidth - baseRadius, baseHeight],
              [baseWidth - trackOffset, baseHeight],
              [baseWidth - trackOffset - 1, baseHeight - trackDepth],
              [baseWidth - trackOffset - trackWidth + 1, baseHeight - trackDepth],
              [baseWidth - trackOffset - trackWidth, baseHeight],
              [trackOffset + trackWidth, baseHeight],
              [trackOffset + trackWidth - 1, baseHeight - trackDepth],
              [trackOffset + 1, baseHeight - trackDepth],
              [trackOffset, baseHeight],
              [baseRadius * 2, baseHeight],
              [baseRadius, baseHeight - baseRadius],
              [0, baseHeight - baseRadius],
              [-baseRadius, baseHeight],
              [-baseExtra + baseRadius, baseHeight],
              [-baseExtra, baseHeight - baseRadius],
              [-baseExtra, baseRadius],
            ]
          );
        }

        // left insets
        for (i = [0:1]) {
          translate([0, 0, i * (baseLength - baseInset)]) {
            linear_extrude(baseInset) {
              polygon(
                [
                  [baseRadius, 0],
                  [-baseExtra, 0],
                  [-baseExtra, baseHeight],
                  [baseRadius, baseHeight],
                  [0, baseHeight - baseRadius],
                  [0, baseRadius],
                ]
              );
            }
          }
        }

        // right insets
        for (i = [0:1]) {
          translate([0, 0, i * (baseLength - baseInset)]) {
            linear_extrude(baseInset) {
              polygon(
                [
                  [baseWidth - baseRadius, 0],
                  [baseWidth + baseExtra, 0],
                  [baseWidth + baseExtra, baseHeight],
                  [baseWidth - baseRadius, baseHeight],
                  [baseWidth, baseHeight - baseRadius],
                  [baseWidth, baseRadius],
                ]
              );
            }
          }
        }
      }
    }
  }
}

module renderBaseHoles() {
  for (i = [1:6]) {
    translate([0, baseInset + i * 10, 0]) {
      renderBaseHole();

      if (i == 2 || i == 4) {
        translate([-baseHoleInnerSize / 2, 0, 0]) {
          cube([baseHoleInnerSize, 10, baseHeight / 2]);
        }
      }
    }
  }

  translate([0, baseLength - baseInset - 10, 0]) {
    renderBaseHole();
  }
}

module renderBaseHole() {
  rotate_extrude() {
    polygon(
      [
        [0, 0],
        [baseHoleOuterSize + 1, 0],
        [baseHoleOuterSize + 1, baseHeight / 2],
        [baseHoleInnerSize, baseHeight / 2 + baseRadius],
        [baseHoleInnerSize, baseHeight - baseRadius],
        [baseHoleOuterSize, baseHeight],
        [0, baseHeight],
      ]
    );
  }
}

module renderLink() {
  linear_extrude(baseHeight) {
    circle(d=linkSize);
    translate([0, linkOffset / 2, 0]) {
      square([linkWidth, linkOffset], center=true);
    }
  }
}
