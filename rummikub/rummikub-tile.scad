$fn = 100;

tileHeight = 32;
tileWidth = 18;
tileThickness = 4;
tileRadius = 1;
holeInset = .8;
holeRadius = 7.2;
numberLinkSize = .6;
numberLinkSpacing = .1;
numberSize = 12;

color("beige") {
  renderTile();
}
color("red") {
  translate([0, tileHeight / 8, holeInset]) {
    renderNumber(1);
  }
}

module renderTile() {
  union() {
    difference() {
      minkowski() {
        cube([tileWidth - 2, tileHeight - 2, tileThickness - 2], center=true);
        sphere(r=1);
      }

      translate([0, tileHeight / 8, 0]) {
        cylinder(h=holeInset + .1, r=holeRadius - holeInset * 2);
        translate([0, 0, holeInset]) {
          cylinder(h=tileThickness / 2 - holeInset, r1=holeRadius - holeInset, r2=holeRadius);
          for (a = [1:7]) {
            rotate([0, 0, a * (360 / 7) + (180 / 7)]) {
              translate([0, holeRadius - holeInset, 0]) {
                cylinder(h=numberLinkSize + numberLinkSpacing, r1=numberLinkSize + numberLinkSpacing, r2=0);
              }
            }
          }
        }
      }
    }
  }
}

module renderNumber(value) {
  union() {
    difference() {
      union() {
        difference() {
          cylinder(h=tileThickness / 2 - holeInset, r1=holeRadius - holeInset, r2=holeRadius);
          translate([0, 0, -.1]) {
            cylinder(h=tileThickness / 2 - holeInset + .2, r1=holeRadius - holeInset * 3, r2=holeRadius - holeInset);
          }
          translate([0, 0, (tileThickness / 2 - holeInset) / 2]) {
            cylinder(h=tileThickness / 2 - holeInset + .1, r=holeRadius);
          }
        }

        linear_extrude(tileThickness / 4) {
          text(str(value), font="Century", size=numberSize, halign="center", valign="center");
        }
      }

      difference() {
        cylinder(h=tileThickness / 2 - holeInset, r1=holeRadius, r2=holeRadius + holeInset);
        cylinder(h=tileThickness / 2 - holeInset, r1=holeRadius - holeInset, r2=holeRadius);
      }
    }
    for (a = [1:7]) {
      rotate([0, 0, a * (360 / 7) + (180 / 7)]) {
        translate([0, holeRadius - holeInset, 0]) {
          cylinder(h=numberLinkSize, r1=numberLinkSize, r2=0);
        }
      }
    }
  }
}

// color("beige") {
//   renderTile();
// }
// translate([0, tileHeight / 8, 4])
//   color("red") {
//     renderNumber(9);
//   }

// module renderTile() {
//   difference() {
//     minkowski() {
//       cube([tileWidth - 2, tileHeight - 2, tileThickness - 2], center=true);
//       sphere(r=1);
//     }

//     translate([0, tileHeight / 8, tileThickness / 2 - holeDepth]) {
//       rotate_extrude() {
//         polygon(
//           [
//             [0, 0],
//             [holeRadius - holeInset * 2, 0],
//             [holeRadius - holeInset * 2, holeInset],
//             [holeRadius - holeInset, holeInset],
//             [holeRadius, holeDepth],
//             [0, holeDepth],
//           ]
//         );
//       }

//       for (a = [1:7]) {
//         rotate([0, 0, a * (360 / 7) + (180 / 7)]) {
//           translate([0, holeRadius - holeInset, holeInset]) {
//             cylinder(h=numberInset + .1, r1=numberInset + .1, r2=0);
//           }
//         }
//       }
//     }
//   }
// }

// module renderNumber(value) {
//   union() {
//     difference() {
//       union() {
//         rotate_extrude() {
//           polygon(
//             [
//               [holeRadius - holeInset * 2.5, 0],
//               [holeRadius - holeInset, 0],
//               [holeRadius - holeInset, holeDepth - holeInset],
//               [holeRadius - holeInset * 2.5, holeDepth - holeInset * 1.5],
//             ]
//           );
//         }

//         linear_extrude(holeDepth - holeInset * 1.5 + holeInset / 2) {
//           text(str(value), font="Century", size=12, halign="center", valign="center");
//         }
//       }

//       rotate_extrude() {
//         polygon(
//           [
//             [holeRadius - holeInset, 0],
//             [holeRadius, 0],
//             [holeRadius, holeDepth],
//             [holeRadius - holeInset, holeDepth],
//           ]
//         );
//       }
//     }

//     translate([0, 0, 0]) {
//       for (a = [1:7]) {
//         rotate([0, 0, a * (360 / 7) + (180 / 7)]) {
//           translate([0, holeRadius - holeInset, 0]) {
//             cylinder(h=numberInset, r1=numberInset, r2=0);
//           }
//         }
//       }
//     }
//   }
// }
