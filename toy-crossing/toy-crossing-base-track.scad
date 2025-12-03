$fn = 50;

trackWidth = 40;
trackHeight = 12.2;
trackLength = 150;
trackChamfer = 1;

buildingLength = 140;
buildingWidth = 46;
buildingInsetDepth = 1;
buildingLinkLength = 10;
buildingLinkOffset = 45;
buildingLinkWidth = 2;
buildingLinkDepth = 6;

linkOffset = 12;
linkWidth = 6;
linkSize = 11;

railWidth = 7;
railOffset = 4;
railDepth = 4;

difference() {
  union() {
    renderTrack();
    rotate([0, 0, 90]) {
      renderTrack();
    }
  }

  union() {
    renderRails();
    rotate([0, 0, 90]) {
      renderRails();
    }
  }

  union() {
    renderBuildingLinks();
    rotate([0, 0, 90]) {
      renderBuildingLinks();
    }
  }
}

module renderTrack() {
  difference() {
    union() {
      cube([trackWidth, trackLength, trackHeight], center=true);
      translate([0, 0, -buildingInsetDepth / 2]) {
        cube([buildingWidth, buildingLength, trackHeight - buildingInsetDepth], center=true);
      }
      renderMaleLink();
    }
    renderFemaleLink();
    renderChamfers();
  }
}

module renderFemaleLink() {
  translate([0, trackLength / 2 - linkOffset, -trackHeight / 2 - .5]) {
    linear_extrude(trackHeight + 1) {
      circle(d=linkSize + 1);
      translate([0, linkOffset / 2, 0]) {
        square([linkWidth + 1, linkOffset + 1], center=true);
      }
    }
  }
}

module renderMaleLink() {
  translate([0, -trackLength / 2 - linkOffset, -trackHeight / 2]) {
    linear_extrude(trackHeight) {
      circle(d=linkSize);
      translate([0, linkOffset / 2, 0]) {
        square([linkWidth, linkOffset], center=true);
      }
    }
  }
}

module renderChamfers() {
  length = (trackLength - trackWidth) / 2 + trackChamfer;
  union() {
    translate([-trackWidth / 2, -trackLength / 2 + length, trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length + 1) {
          polygon(
            [
              [0, 0],
              [trackChamfer, 0],
              [0, -trackChamfer],
            ]
          );
        }
      }
    }
    translate([trackWidth / 2, -trackLength / 2 + length, trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length + 1) {
          polygon(
            [
              [-trackChamfer, 0],
              [0, 0],
              [0, -trackChamfer],
            ]
          );
        }
      }
    }
  }
}

module renderBuildingLinks() {
  spacing = .4;
  insetLength = buildingLinkLength + spacing;
  insetWidth = buildingLinkWidth + spacing / 2;
  insetDepth = buildingLinkDepth + spacing;
  for (y = [-1:1]) {
    if (y != 0) {
      for (x = [-1:1]) {
        if (x != 0) {
          translate([y * buildingLinkOffset, x * (buildingWidth / 2 - insetWidth / 2 - (1 - spacing / 2)), trackHeight / 2 - insetDepth]) {
            linear_extrude(insetDepth + 1) {
              polygon(
                [
                  [-insetLength / 2, -insetWidth / 2],
                  [insetLength / 2, -insetWidth / 2],
                  [insetLength / 2, insetWidth / 2],
                  [-insetLength / 2, insetWidth / 2],
                ]
              );
            }
          }
        }
      }
    }
  }
}

module renderRails() {
  union() {
    translate([-(trackWidth - railWidth) / 2 + railOffset, 0, 0]) {
      renderRail();
    }
    translate([(trackWidth - railWidth) / 2 - railOffset, 0, 0]) {
      renderRail();
    }
  }
}

module renderRail() {
  translate([0, trackLength / 2 + .5, railDepth * 1.5]) {
    rotate([90, 0, 0]) {
      linear_extrude(trackLength + 1) {
        polygon(
          [
            [-railWidth / 2 - 1, railDepth],
            [-railWidth / 2 + 1, -railDepth],
            [railWidth / 2 - 1, -railDepth],
            [railWidth / 2 + 1, railDepth],
          ]
        );
      }
    }
  }
}
