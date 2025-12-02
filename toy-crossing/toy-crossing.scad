$fn = 50;

baseWidth = 46;
baseHeight = 11.2;
baseLength = 140;
baseRadius = 1;

buildingLength = 130;
buildingHeight = 25;
buildingWidth = 46;
buildingWall = 3;

linkOffset = 12;
linkWidth = 6;
linkSize = 11;

trackWidth = 7;
trackDepth = 4;
trackOffset = 7;

difference() {
  union() {
    renderTrack();
    rotate([0, 0, 270]) {
      renderTrack();
    }
  }

  union() {
    renderTrackInsets(baseLength);
    rotate([0, 0, 270]) {
      renderTrackInsets(baseLength);
    }
  }

  union() {
    renderTrackChamfers();
    rotate([0, 0, 270]) {
      renderTrackChamfers();
    }
  }
}

difference() {
  union() {
    renderBuilding();
    rotate([0, 0, 270]) {
      renderBuilding();
    }
  }

  union() {
    renderBuildingInsets();
    rotate([0, 0, 270]) {
      renderBuildingInsets();
    }
  }
}

difference() {
  translate([0, 0, baseHeight + buildingHeight + buildingWidth / 2]) {
    rotate([0, 0, 45]) {
      renderUpperTrack(40, 60);
    }
  }
  translate([0, 0, baseHeight + buildingHeight + buildingWidth / 2]) {
    rotate([0, 0, 45]) {
      renderTrackInsets(60);
    }
  }
}

module renderBuilding() {
  translate([0, 0, (buildingHeight + baseHeight) / 2]) {
    cube([buildingWidth, buildingLength, buildingHeight], center=true);
    translate([0, 0, buildingHeight / 2]) {
      rotate([90, 0, 0]) {
        cylinder(h=buildingLength, d=buildingWidth, center=true);
      }
    }
  }
}

module renderBuildingChamfers() {
  length = (baseLength - baseWidth) / 2;
  translate([0, -baseLength / 2 + length, 0]) {
    renderBuildingChamferLeft(length);
  }
  translate([0, baseLength / 2, 0]) {
    renderBuildingChamferLeft(length);
  }
  translate([0, -baseLength / 2 + length, 0]) {
    renderBuildingChamferRight(length);
  }
  translate([0, baseLength / 2, 0]) {
    renderBuildingChamferRight(length);
  }
}

module renderBuildingChamferLeft(length) {
  translate([0, 0, baseHeight / 2]) {
    rotate([90, 0, 0]) {
      linear_extrude(length) {
        polygon(
          [
            [-baseWidth / 2, 0],
            [-baseWidth / 2 + baseRadius, 0],
            [-baseWidth / 2, baseRadius],
          ]
        );
      }
    }
  }
}

module renderBuildingChamferRight(length) {
  translate([0, 0, baseHeight / 2]) {
    rotate([90, 0, 0]) {
      linear_extrude(length) {
        polygon(
          [
            [baseWidth / 2, 0],
            [baseWidth / 2, baseRadius],
            [baseWidth / 2 - baseRadius, 0],
          ]
        );
      }
    }
  }
}

module renderBuildingInsets() {
  translate([0, 0, (buildingHeight + baseHeight) / 2]) {
    cube([buildingWidth - buildingWall * 2, buildingLength, buildingHeight], center=true);
    translate([0, 0, buildingHeight / 2]) {
      rotate([90, 0, 0]) {
        cylinder(h=buildingLength, d=buildingWidth - buildingWall * 2, center=true);
      }
    }

    translate([buildingLength / 4, 44, buildingHeight / 2 - 8]) {
      rotate([0, 90, 0]) {
        cylinder(h=buildingLength / 4, d=12, center=true);
      }
    }

    translate([buildingLength / 4, -35, buildingHeight / 2 - 8]) {
      rotate([0, 90, 0]) {
        cylinder(h=buildingLength / 4, d=12, center=true);
      }
    }

    translate([buildingLength / 4, -53, buildingHeight / 2 - 8]) {
      rotate([0, 90, 0]) {
        cylinder(h=buildingLength / 4, d=12, center=true);
      }
    }

    translate([-buildingLength / 4, -44, buildingHeight / 2 - 8]) {
      rotate([0, 90, 0]) {
        cylinder(h=buildingLength / 4, d=12, center=true);
      }
    }

    translate([-buildingLength / 4, 35, buildingHeight / 2 - 8]) {
      rotate([0, 90, 0]) {
        cylinder(h=buildingLength / 4, d=12, center=true);
      }
    }

    translate([-buildingLength / 4, 53, buildingHeight / 2 - 8]) {
      rotate([0, 90, 0]) {
        cylinder(h=buildingLength / 4, d=12, center=true);
      }
    }
  }
}

module renderTrack() {
  difference() {
    cube([baseWidth, baseLength, baseHeight], center=true);
    translate([0, baseLength / 2 - linkOffset, -baseHeight / 2]) {
      linear_extrude(baseHeight) {
        circle(d=linkSize);
        translate([0, linkOffset / 2, 0]) {
          square([linkWidth, linkOffset], center=true);
        }
      }
    }
  }

  translate([0, -baseLength / 2 - linkOffset, -baseHeight / 2]) {
    linear_extrude(baseHeight) {
      circle(d=linkSize);
      translate([0, linkOffset / 2, 0]) {
        square([linkWidth, linkOffset], center=true);
      }
    }
  }
}

module renderTrackChamfers() {
  length = (baseLength - buildingLength) / 2;
  translate([0, -baseLength / 2 + length, 0]) {
    renderTrackChamferLeft(length);
  }
  translate([0, baseLength / 2, 0]) {
    renderTrackChamferLeft(length);
  }
  translate([0, -baseLength / 2 + length, 0]) {
    renderTrackChamferRight(length);
  }
  translate([0, baseLength / 2, 0]) {
    renderTrackChamferRight(length);
  }
}

module renderTrackChamferLeft(length) {
  translate([0, 0, baseHeight / 2]) {
    rotate([90, 0, 0]) {
      linear_extrude(length) {
        polygon(
          [
            [-baseWidth / 2, 0],
            [-baseWidth / 2 + baseRadius, 0],
            [-baseWidth / 2, -baseRadius],
          ]
        );
      }
    }
  }
}

module renderTrackChamferRight(length) {
  translate([0, 0, baseHeight / 2]) {
    rotate([90, 0, 0]) {
      linear_extrude(length) {
        polygon(
          [
            [baseWidth / 2, 0],
            [baseWidth / 2, -baseRadius],
            [baseWidth / 2 - baseRadius, 0],
          ]
        );
      }
    }
  }
}

module renderTrackInsets(length) {
  translate([-(baseWidth - trackWidth) / 2 + trackOffset, 0, 0]) {
    renderTrackInset(length);
  }

  translate([(baseWidth - trackWidth) / 2 - trackOffset, 0, 0]) {
    renderTrackInset(length);
  }
}

module renderTrackInset(length) {
  translate([0, length / 2, baseHeight / 2]) {
    rotate([90, 0, 0]) {
      linear_extrude(length) {
        polygon(
          [
            [-trackWidth / 2, 0],
            [-trackWidth / 2 + 1, -trackDepth],
            [trackWidth / 2 - 1, -trackDepth],
            [trackWidth / 2, 0],
          ]
        );
      }
    }
  }
}

module renderUpperTrack(width, length) {
  difference() {
    union() {
      cube([width, length, baseHeight], center=true);
      translate([0, -(linkOffset - linkWidth) / 4, -(baseHeight + buildingWall) / 2]) {
        cube([width, length + (linkOffset - linkWidth) / 2, buildingWall], center=true);
      }
    }
    translate([0, length / 2 - linkOffset, -baseHeight / 2]) {
      linear_extrude(baseHeight) {
        circle(d=linkSize);
        translate([0, linkOffset / 2, 0]) {
          square([linkWidth, linkOffset], center=true);
        }
      }
    }
  }

  translate([0, -length / 2 - linkOffset, -baseHeight / 2]) {
    linear_extrude(baseHeight) {
      circle(d=linkSize);
      translate([0, linkOffset / 2, 0]) {
        square([linkWidth, linkOffset], center=true);
      }
    }
  }
}
