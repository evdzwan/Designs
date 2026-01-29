include <const.scad>

$fn = 10;
color("teal") holder();

module holder() {
  difference() {
    union() {
      rotate([90, 0, 90]) cylinder(r=holder_connector_radius - tolerance, h=holder_connector_width, center=true);
      translate([-holder_connector_width / 2, 0, 0]) sphere(r=holder_connector_inset, $fn=8);
      translate([holder_connector_width / 2, 0, 0]) sphere(r=holder_connector_inset, $fn=8);
      translate([-holder_width / 2, -holder_depth - (holder_connector_radius - base_radius) - tolerance / 2, -holder_connector_offset]) {
        cube([holder_width, holder_depth, holder_height]);

        // head
        translate([0, holder_depth, holder_height - 3 * holder_head]) {
          rotate([90, 0, 90]) {
            linear_extrude(holder_width) {
              polygon(
                [
                  [0, 0],
                  [holder_head, 2 * holder_head],
                  [holder_head, 3 * holder_head],
                  [0, 3 * holder_head],
                ]
              );
            }
          }
        }

        // foot
        translate([0, 0, 0]) {
          rotate([90, 0, 90]) {
            linear_extrude(holder_width) {
              polygon(
                [
                  [0, 0],
                  [-holder_foot, 0],
                  [-holder_foot, holder_foot],
                  [0, 3 * holder_foot],
                ]
              );
            }
          }
        }
      }
    }

    // tile slot
    translate([-holder_width / 2, -holder_depth - (holder_connector_radius - base_radius) - tolerance / 2, -holder_connector_offset]) {
      translate([holder_edge, holder_edge, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - 2 * holder_edge, holder_height - 2 * holder_edge]);
      translate([-shift / 2, -shift, holder_height / 3]) cube([holder_width + shift, holder_depth - 2 * holder_edge + shift, 2 * holder_height / 3 - 3 * holder_edge]);

      translate([holder_edge, -shift / 2, holder_height - 3 * holder_edge - shift]) cube([holder_width - 2 * holder_edge, holder_edge + shift, 2 * holder_edge + shift]);
      translate([-shift / 2, -shift, holder_height - 3 * holder_edge - shift / 2]) cube([holder_width + shift, holder_edge + shift, 3 * holder_edge + shift]);

      translate([3 * holder_edge, -2 * holder_foot - shift / 2, 3 * holder_edge]) cube([holder_width - 6 * holder_edge, 2 * holder_foot + holder_edge + shift, holder_height / 3 - 3 * holder_edge + shift]);
    }
  }

  // edge chamfers
  translate([-holder_width / 2, -holder_depth - (holder_connector_radius - base_radius) - tolerance / 2, -holder_connector_offset]) {
    translate([holder_edge, holder_depth - holder_edge, holder_height - 2 * holder_edge]) {
      rotate([90, 0, 90]) {
        linear_extrude(holder_width - 2 * holder_edge) {
          polygon(
            [
              [0, 0],
              [-2 * holder_edge + tolerance / 2, 2 * holder_edge],
              [0, 2 * holder_edge],
            ]
          );
        }
      }
    }

    translate([0, holder_depth - 2 * holder_edge, holder_height - 5 * holder_edge]) {
      rotate([90, 0, 90]) {
        linear_extrude(holder_edge) {
          polygon(
            [
              [0, 0],
              [-2 * holder_edge + tolerance / 2, 2 * holder_edge],
              [0, 2 * holder_edge],
            ]
          );
        }
      }
    }

    translate([holder_width - holder_edge, holder_depth - 2 * holder_edge, holder_height - 5 * holder_edge]) {
      rotate([90, 0, 90]) {
        linear_extrude(holder_edge) {
          polygon(
            [
              [0, 0],
              [-2 * holder_edge + tolerance / 2, 2 * holder_edge],
              [0, 2 * holder_edge],
            ]
          );
        }
      }
    }
  }
}
