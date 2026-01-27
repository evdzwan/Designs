include <const.scad>
use <../shapes.scad>

holder();

module holder() {
  difference() {
    // base
    translate([0, -holder_connectorradius + 2 * holder_edge, -holder_connectorradius]) {
      rotate([90, 0, 0]) {
        roundedCube([holder_width, holder_height, holder_depth], radius=holder_radius, $fn=4);
        translate([0, 0, -2 * holder_connectorradius + 2 * holder_edge]) {
          intersection() {
            roundedCube([holder_width, 2 * holder_connectorradius + holder_edge, 2 * holder_connectorradius], radius=holder_radius, $fn=4);
            union() {
              translate([0, holder_connectorradius, holder_connectorradius]) rotate([90, 0, 90]) cylinder(r=holder_connectorradius, h=holder_width, $fn=6);
              translate([0, 0, holder_connectorradius]) roundedCube([holder_width, holder_connectorradius, holder_connectorradius], radius=holder_radius, $fn=4);
            }
          }
        }
      }
    }

    // link hole
    translate([-shift / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=link_outerradius, h=holder_width + shift, $fn=6);
    translate([-shift, 0, 0]) rotate([0, 90, 0]) cylinder(r=link_outerradius, h=link_indent + shift, $fn=50);

    // tile hole
    translate([0, -(holder_connectorradius + holder_depth) + 2 * holder_edge, -holder_connectorradius]) {
      translate([holder_edge, holder_edge, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - 2 * holder_edge, holder_height - 2 * holder_edge]);
      translate([-shift / 2, -shift / 2, 2 * holder_connectorradius]) cube([holder_width + shift, 1.5 * holder_edge + shift, holder_height - 2 * holder_edge]);
      translate([2 * holder_edge, -shift / 2, 2 * holder_edge]) cube([holder_width - 4 * holder_edge, holder_edge + shift, 2 * (holder_connectorradius - holder_edge) + shift]);
      translate([holder_width, -shift / 2, holder_height]) rotate([0, 90, 90]) cylinder(r=holder_width - 4 * holder_edge, h=holder_depth + shift, $fn=50);
    }
  }

  // spacers
  difference() {
    translate([-tolerance / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=(holder_connectorradius + link_outerradius) / 2 - tolerance, h=tolerance, $fn=50);
    translate([-tolerance / 2 - shift / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=link_outerradius, h=tolerance + shift, $fn=50);
  }
  difference() {
    translate([holder_width - tolerance / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=(holder_connectorradius + link_outerradius) / 2 - tolerance, h=tolerance, $fn=50);
    translate([holder_width - tolerance / 2 - shift / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=link_outerradius, h=tolerance + shift, $fn=50);
  }
}
