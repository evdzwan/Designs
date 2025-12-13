$fn = 50;

// spacing = .4;
// insetLength = topTrackLinkLength + spacing;
// insetWidth = topTrackLinkWidth + spacing / 2;
// insetDepth = topTrackLinkDepth + spacing;

baseHeight = 2;
baseSupport = 6;

trackChamfer = 1;
trackWidth = 40;
trackHeight = 12;

topTrackLength = 80;
topTrackLinkLength = 8;
topTrackLinkOffset = 20;
topTrackLinkWidth = 2;
topTrackLinkDepth = 4;

linkOffset = 12;
linkWidth = 7;
linkSize = 12;

railWidth = 7;
railOffset = 4;
railDepth = 4;

union() {
  difference() {
    union() {
      renderTopTrack();
      rotate([0, 0, 90]) {
        renderTopTrack();
      }
    }
    union() {
      renderTopRails();
      rotate([0, 0, 90]) {
        renderTopRails();
      }
    }
  }

  renderTopBase();
  rotate([0, 0, 90]) {
    renderTopBase();
  }

  renderTopTrackLinks();
  renderTopGrips();
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
