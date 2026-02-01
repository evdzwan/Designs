include <const.scad>

$fn = 20;
color("teal") holder();

module holder() {
  difference() {
    union() {
      // connector
      difference() {
        union() {
          hull() {
            rotate([90, 0, 90]) cylinder(r=holder_connector_radius - 4 * tolerance, h=holder_connector_width, center=true);
            translate([0, -holder_connector_radius - 4 * tolerance, -2 * holder_connector_radius]) rotate([90, 0, 90]) cylinder(d=holder_edge, h=holder_connector_width, center=true);
            translate([0, -holder_connector_radius - 4 * tolerance, 2 * holder_connector_radius]) rotate([90, 0, 90]) cylinder(d=holder_edge, h=holder_connector_width, center=true);
          }

          translate([-(holder_connector_width - tolerance) / 2, 0, 0]) sphere(r=holder_connector_inset, $fn=8);
          translate([(holder_connector_width - tolerance) / 2, 0, 0]) sphere(r=holder_connector_inset, $fn=8);
        }

        translate([0, -holder_edge / 2, 0]) cube([holder_connector_width - holder_edge, holder_connector_radius + 2 * holder_edge, 4 * holder_connector_radius], center=true);
      }

      // body
      translate([-holder_width / 2, -holder_depth - (holder_connector_radius - base_radius) - tolerance / 2, -holder_connector_offset]) {
        cube([holder_width, holder_depth, holder_height]);

        // head
        translate([0, holder_depth, holder_height - 2 * holder_head]) {
          rotate([90, 0, 90]) {
            linear_extrude(holder_width) {
              polygon(
                [
                  [0, 0],
                  [holder_head, holder_head],
                  [holder_head, 2 * holder_head],
                  [0, 2 * holder_head],
                ]
              );
            }
          }
        }

        // foot
        rotate([90, 0, 90]) {
          linear_extrude(holder_width) {
            polygon(
              [
                [0, 0],
                [-holder_foot, 0],
                [-holder_foot, holder_foot],
                [0, 2 * holder_foot],
              ]
            );
          }
        }
      }
    }

    // tile slot
    translate([-holder_width / 2, -holder_depth - (holder_connector_radius - base_radius) - tolerance / 2, -holder_connector_offset]) {
      translate([holder_edge, holder_edge, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - 2 * holder_edge, holder_height - 2 * holder_edge]);
      translate([-shift / 2, -shift, holder_height / 3]) cube([holder_width + shift, holder_depth - 2 * holder_edge + shift, 2 * holder_height / 3 + shift]);
      translate([2 * holder_edge, -holder_foot - shift / 2, 2 * holder_foot + holder_edge]) cube([holder_width - 4 * holder_edge, holder_foot + holder_edge + shift, holder_height / 3 - (2 * holder_foot + holder_edge) + shift]);
      translate([holder_width, holder_depth + holder_foot + shift / 2, holder_height]) rotate([90, 0, 0]) cylinder(r=2 * holder_width / 3, h=holder_foot + 2 * holder_edge + shift);
    }
  }
}
