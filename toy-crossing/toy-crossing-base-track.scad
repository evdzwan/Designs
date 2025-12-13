$fn = 100;

trackWidth = 40;
trackHeight = 12.2;
trackLength = 150;
trackChamfer = 1;

buildingLength = 140;
buildingWidth = 46;
buildingInsetDepth = 1;
buildingLinkLength = 8;
buildingLinkOffset = 45;
buildingLinkWidth = 2;
buildingLinkDepth = 4;

linkOffset = 12;
linkWidth = 7;
linkSize = 12;

railWidth = 7;
railOffset = 4;
railDepth = 4;

difference() {
  union() {
    renderTrack();
    renderBuildingLinks();
    rotate([0, 0, 90]) {
      renderTrack();
      renderBuildingLinks();
    }
  }

  union() {
    renderRails();
    rotate([0, 0, 90]) {
      renderRails();
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
    renderBottomChamfers();
    renderTopChamfers();
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

module renderBottomChamfers() {
  renderLeftFront();
  renderLeftRear();
  rotate([0, 0, 180]) {
    renderLeftFront();
    renderLeftRear();
  }

  renderRightFront();
  renderRightRear();
  rotate([0, 0, 180]) {
    renderRightFront();
    renderRightRear();
  }

  module renderLeftFront() {
    length = (trackLength - buildingLength) / 2;
    translate([-trackWidth / 2, -trackLength / 2 + length, -trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length) {
          polygon(
            [
              [0, trackChamfer],
              [trackChamfer, 0],
              [0, 0],
            ]
          );
        }
      }
    }
  }

  module renderLeftRear() {
    length = (trackLength - buildingWidth) / 2;
    translate([-buildingWidth / 2, -trackLength / 2 + length + trackChamfer, -trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length + trackChamfer) {
          polygon(
            [
              [0, trackChamfer],
              [trackChamfer, 0],
              [0, 0],
            ]
          );
        }
      }
    }
  }

  module renderRightFront() {
    length = (trackLength - buildingLength) / 2;
    translate([trackWidth / 2, -trackLength / 2 + length, -trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length) {
          polygon(
            [
              [0, trackChamfer],
              [0, 0],
              [-trackChamfer, 0],
            ]
          );
        }
      }
    }
  }

  module renderRightRear() {
    length = (trackLength - buildingWidth) / 2;
    translate([buildingWidth / 2, -trackLength / 2 + length + trackChamfer, -trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length + trackChamfer) {
          polygon(
            [
              [0, trackChamfer],
              [0, 0],
              [-trackChamfer, 0],
            ]
          );
        }
      }
    }
  }
}

module renderTopChamfers() {
  renderLeft();
  rotate([0, 0, 180]) {
    renderLeft();
  }

  renderRight();
  rotate([0, 0, 180]) {
    renderRight();
  }

  module renderLeft() {
    length = (trackLength - trackWidth) / 2;
    translate([-trackWidth / 2, -trackLength / 2 + length + trackChamfer, trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length + trackChamfer) {
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
  }

  module renderRight() {
    length = (trackLength - trackWidth) / 2;
    translate([trackWidth / 2, -trackLength / 2 + length + trackChamfer, trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(length + trackChamfer) {
          polygon(
            [
              [0, 0],
              [0, -trackChamfer],
              [-trackChamfer, 0],
            ]
          );
        }
      }
    }
  }
}

module renderBuildingLinks() {
  for (y = [-1:1]) {
    if (y != 0) {
      for (x = [-1:1]) {
        if (x != 0) {
          translate([y * buildingLinkOffset, x * (buildingWidth / 2 - (buildingWidth - trackWidth) / 4 - buildingLinkWidth / 4), trackHeight / 2 - buildingInsetDepth]) {
            linear_extrude(buildingLinkDepth) {
              polygon(
                [
                  [-buildingLinkLength / 2, -buildingLinkWidth / 2],
                  [buildingLinkLength / 2, -buildingLinkWidth / 2],
                  [buildingLinkLength / 2, buildingLinkWidth / 2],
                  [-buildingLinkLength / 2, buildingLinkWidth / 2],
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
