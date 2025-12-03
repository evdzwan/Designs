$fn = 50;

baseHeight = 2;
baseSupport = 6;

trackWidth = 40;
trackHeight = 12.2;
trackLength = 150;
trackChamfer = 1;

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

linkOffset = 12;
linkWidth = 6;
linkSize = 11;

railWidth = 7;
railOffset = 4;
railDepth = 4;

topTrackLength = 60;
topTrackLinkLength = 8;
topTrackLinkOffset = 20;
topTrackLinkWidth = 2;
topTrackLinkDepth = 4;

renderBaseTrackPart();
translate([0, 0, (buildingHeight + trackHeight) / 2 - buildingInsetDepth]) {
  renderBuildingPart();
  translate([0, 0, buildingHeight + buildingRoofHeight - topTrackLinkDepth + baseHeight / 2]) {
    rotate([0, 0, 135]) {
      renderTopTrackPart();
    }
  }
}

module renderBuildingPart() {
  color("magenta") {
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
  }
}

module renderBaseTrackPart() {
  color("cyan") {
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
  }
}

module renderTopTrackPart() {
  color("olive") {
    difference() {
      renderTopTrack();
      renderTopRails();
    }

    renderTopBase();
    renderTopTrackLinks();
    renderTopGrips();
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
              translate([x * trackWidth / 2, y * (topTrackLinkOffset - insetLength / 4 + insetWidth / 4), -insetDepth / 2 + 1]) {
                cube([insetWidth, insetLength / 2 + insetWidth / 2, insetDepth + 1], center=true);
              }

              translate([x * (trackWidth - insetLength / 2) / 2, y * topTrackLinkOffset, -insetDepth / 2 + 1]) {
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

module renderTopBase() {
  translate([0, -baseSupport / 2, baseHeight / 2]) {
    cube([trackWidth, topTrackLength + baseSupport, baseHeight], center=true);
  }
}

module renderTopTrack() {
  translate([0, 0, trackHeight / 2 + baseHeight]) {
    difference() {
      union() {
        cube([trackWidth, topTrackLength, trackHeight], center=true);
        renderTopMaleLink();
      }
      renderTopFemaleLink();
      renderTopChamfers();
    }
  }
}

module renderTopChamfers() {
  union() {
    translate([-trackWidth / 2, topTrackLength / 2, trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(topTrackLength + 1) {
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
    translate([trackWidth / 2, topTrackLength / 2, trackHeight / 2]) {
      rotate([90, 0, 0]) {
        linear_extrude(topTrackLength + 1) {
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

module renderTopFemaleLink() {
  translate([0, topTrackLength / 2 - linkOffset, -trackHeight / 2 - .5]) {
    linear_extrude(trackHeight + 1) {
      circle(d=linkSize + 1);
      translate([0, linkOffset / 2, 0]) {
        square([linkWidth + 1, linkOffset + 1], center=true);
      }
    }
  }
}

module renderTopMaleLink() {
  translate([0, -topTrackLength / 2 - linkOffset, -trackHeight / 2]) {
    linear_extrude(trackHeight) {
      circle(d=linkSize);
      translate([0, linkOffset / 2, 0]) {
        square([linkWidth, linkOffset], center=true);
      }
    }
  }
}

module renderTopGrips() {
  translate([0, 0, trackHeight / 2 + baseHeight]) {
    for (y = [-1:1]) {
      if (y != 0) {
        for (x = [-1:1]) {
          if (x != 0) {
            translate([x * trackWidth / 2, y * (topTrackLinkOffset - topTrackLinkLength / 4 + topTrackLinkWidth / 4), -baseHeight / 2]) {
              cube([topTrackLinkWidth, topTrackLinkLength / 2 + topTrackLinkWidth / 2, baseHeight + trackHeight], center=true);
            }
          }
        }
      }
    }
  }
}

module renderTopTrackLinks() {
  union() {
    for (y = [-1:1]) {
      if (y != 0) {
        for (x = [-1:1]) {
          if (x != 0) {
            translate([x * trackWidth / 2, y * (topTrackLinkOffset - topTrackLinkLength / 4 + topTrackLinkWidth / 4), -topTrackLinkDepth / 2]) {
              cube([topTrackLinkWidth, topTrackLinkLength / 2 + topTrackLinkWidth / 2, topTrackLinkDepth], center=true);
            }

            translate([x * (trackWidth - topTrackLinkLength / 2) / 2, y * topTrackLinkOffset, -topTrackLinkDepth / 2]) {
              cube([topTrackLinkLength / 2, topTrackLinkWidth, topTrackLinkDepth], center=true);
            }
          }
        }
      }
    }
  }
}

module renderTopRails() {
  union() {
    translate([-(trackWidth - railWidth) / 2 + railOffset, 0, trackHeight - railDepth]) {
      renderTopRail();
    }
    translate([(trackWidth - railWidth) / 2 - railOffset, 0, trackHeight - railDepth]) {
      renderTopRail();
    }
  }
}

module renderTopRail() {
  translate([0, topTrackLength / 2 + .5, railDepth * 1.5]) {
    rotate([90, 0, 0]) {
      linear_extrude(topTrackLength + 1) {
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
