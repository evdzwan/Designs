use <../shapes.scad>
use <holder.scad>
use <tile.scad>
use <link.scad>
use <rod.scad>

base(count=2);

module base(count) {
  tile = tileSize();
  tileSpacing = 1;
  holderOffset = 14;
  holderSpacing = 4;
  tolerance = .2;
  edge = 2;
  foot = 2;
  width = count * (tile[0] + tileSpacing + holderSpacing + edge * 2) + holderSpacing;

  // base
  color("teal") {
    intersection() {
      difference() {
        union() {
          cube([width, 28, 4]);
          difference() {
            hull() {
              translate([0, holderOffset, holderOffset]) rotate([90, 0, 90]) cylinder(r=8, h=width, $fn=50);
              translate([0, holderOffset - 10, holderOffset - 8]) rotate([90, 0, 90]) cylinder(r=4, h=width, $fn=50);
              translate([0, holderOffset - 10, holderOffset - 10]) rotate([90, 0, 90]) cylinder(r=4, h=width, $fn=50);
              translate([0, holderOffset + 10, holderOffset]) rotate([90, 0, 90]) cylinder(r=4, h=width, $fn=50);
              translate([0, holderOffset + 10, holderOffset - 10]) rotate([90, 0, 90]) cylinder(r=4, h=width, $fn=50);
            }

            translate([-.5, holderOffset, holderOffset]) rotate([0, 90, 0]) cylinder(r=4, h=width + 1, $fn=6);
            for (i = [0:count - 1]) {
              translate([i * (tile[0] + tileSpacing + holderSpacing + edge * 2) + holderSpacing - tolerance, -.5, 0]) {
                rotate([90, 0, 90]) {
                  linear_extrude(height=tile[0] + tileSpacing + holderSpacing + tolerance * 2) {
                    polygon(
                      [
                        [0, 10],
                        [5, 8],
                        [5, 0],
                        [24, 0],
                        [24, 17.8],
                        [28 + 1, 17.8],
                        [28 + 1, 28],
                        [0, 28],
                      ]
                    );
                  }
                }
              }
            }
          }

          *translate([0, holderOffset, holderOffset]) parts();
        }

        for (i = [0:count - 1]) {
          translate([i * (tile[0] + tileSpacing + holderSpacing + edge * 2) + holderSpacing + edge, 28 - 4 + 1, -1]) {
            rotate([90, 0, 90]) {
              linear_extrude(height=tile[0] + tileSpacing) {
                polygon(
                  [
                    [0, 0],
                    [4, 0],
                    [4, 16],
                    [0, 3],
                  ]
                );
              }
            }
          }
        }

        translate([foot * 2, foot * 2, -.5]) cylinder(r=foot, h=1 + .5, $fn=50);
        translate([foot * 2, 25 - foot * 2, -.5]) cylinder(r=foot, h=1 + .5, $fn=50);
        translate([width - foot * 2, foot * 2, -.5]) cylinder(r=foot, h=1 + .5, $fn=50);
        translate([width - foot * 2, 25 - foot * 2, -.5]) cylinder(r=foot, h=1 + .5, $fn=50);
      }
      
      roundedCube([width, 28, 28], radius=2, $fn=50);
    }
  }

  module parts() {
    // rod
    rotate([-90, 0, 0]) color("magenta") rod(count);

    // temp parts
    for (i = [0:count - 1]) {
      translate([i * (tile[0] + tileSpacing + holderSpacing + edge * 2) + holderSpacing, 0, 0]) {
        angle = i * 80 / (count - 1);

        rotate([-10 - angle, 0, 0]) {
          color("olive") holder();
          translate([.1, 0, 0]) rotate([0, 90, 0]) color("cyan") link();
        }
      }
    }
  }
}
