$fn = 50;

buildingLength = 140;
buildingHeight = 40;
buildingWidth = 46;
buildingWall = 3;
buildingLightHeight = 2;
buildingLightWidth = 8;
buildingRoofHeight = 6;
buildingRoofWidth = 12;
buildingInsetDepth = 1;
buildingLinkLength = 10;
buildingLinkOffset = 45;
buildingLinkWidth = 2;
buildingLinkDepth = 6;
buildingWindowSize = 12;

topTrackLength = 60;
topTrackWidth = 40;
topTrackLinkLength = 8;
topTrackLinkOffset = 20;
topTrackLinkWidth = 2;
topTrackLinkDepth = 4;

difference() {
  union() {
    renderBuilding();
    rotate([0, 0, 90]) {
      renderBuilding();
    }
  }
  union() {
    renderWindows();
    renderBuildingHole();
    rotate([0, 0, 90]) {
      renderWindows();
      renderBuildingHole();
    }
  }
  renderTrackLinks();
}

difference() {
  union() {
    renderRoof();
    rotate([0, 0, 90]) {
      renderRoof();
    }
  }
  renderTrackLinks();
}

module renderBuilding() {
  union() {
    cube([buildingWidth, buildingLength, buildingHeight], center=true);
    translate([0, 0, buildingHeight / 2]) {
      rotate([90, 0, 0]) {
        cylinder(h=buildingLength, d=buildingWidth, center=true);
      }
    }
    renderBuildingLinks();
  }
}

module renderBuildingLinks() {
  for (y = [-1:1]) {
    if (y != 0) {
      for (x = [-1:1]) {
        if (x != 0) {
          translate([x * -(buildingWidth - buildingLinkWidth) / 2 + x * (buildingWall - buildingLinkWidth), y * buildingLinkOffset, -buildingHeight / 2]) {
            cube([buildingLinkWidth, buildingLinkLength, buildingLinkDepth], center=true);
          }
        }
      }
    }
  }
}

module renderBuildingHole() {
  union() {
    translate([0, 0, -1]) {
      cube([buildingWidth - buildingWall * 2, buildingLength + 1, buildingHeight + 1], center=true);
      translate([0, 0, buildingHeight / 2]) {
        rotate([90, 0, 0]) {
          cylinder(h=buildingLength + 1, d=buildingWidth - buildingWall * 2, center=true);
        }
      }
    }
  }
}

module renderRoof() {
  union() {
    translate([0, 0, buildingHeight]) {
      cube([buildingRoofWidth, buildingLength, buildingRoofHeight], center=true);
    }
    for (i = [-2:2]) {
      translate([0, i * buildingLength / 5, buildingHeight - buildingRoofHeight / 2]) {
        cylinder(h=buildingLightHeight, d=buildingLightWidth, center=true);
      }
    }
  }
}

module renderTrackLinks() {
  spacing = .4;
  insetLength = topTrackLinkLength + spacing;
  insetWidth = topTrackLinkWidth + spacing / 2;
  insetDepth = topTrackLinkDepth + spacing;
  translate([0, 0, buildingHeight + buildingRoofHeight / 2]) {
    rotate([0, 0, 315]) {
      for (y = [-1:1]) {
        if (y != 0) {
          for (x = [-1:1]) {
            if (x != 0) {
              translate([x * topTrackWidth / 2, y * (topTrackLinkOffset - insetLength / 4 + insetWidth / 4), -insetDepth / 2 + 1]) {
                cube([insetWidth, insetLength / 2 + insetWidth / 2, insetDepth + 1], center=true);
              }

              translate([x * (topTrackWidth - insetLength / 2) / 2, y * topTrackLinkOffset, -insetDepth / 2 + 1]) {
                cube([insetLength / 2, insetWidth, insetDepth + 1], center=true);
              }
            }
          }
        }
      }
    }
  }
}

module renderWindows() {
  translate([-buildingWidth / 2, 4 * buildingLength / 12, buildingHeight / 3]) {
    cube([buildingWindowSize, buildingWindowSize * 2, buildingWindowSize], center=true);
  }

  translate([-buildingWidth / 2, -3 * buildingLength / 12, buildingHeight / 3]) {
    cube(buildingWindowSize, center=true);
  }

  translate([-buildingWidth / 2, -5 * buildingLength / 12, buildingHeight / 3]) {
    cube(buildingWindowSize, center=true);
  }

  translate([buildingWidth / 2, -4 * buildingLength / 12, buildingHeight / 3]) {
    cube([buildingWindowSize, buildingWindowSize * 2, buildingWindowSize], center=true);
  }

  translate([buildingWidth / 2, 3 * buildingLength / 12, buildingHeight / 3]) {
    cube(buildingWindowSize, center=true);
  }

  translate([buildingWidth / 2, 5 * buildingLength / 12, buildingHeight / 3]) {
    cube(buildingWindowSize, center=true);
  }
}
