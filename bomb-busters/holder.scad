include <const.scad>

holder();

module holder() {
  translate([0, 0, cos(holder_angle) * holder_connector_offset]) {
    rotate([-holder_angle, 0, 0]) {
      holder_connector_depth = 2 * holder_connector_radius + tolerance;

      difference() {
        union() {
          difference() {
            union() {
              rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=2 * holder_connector_width, center=true, $fn=24);

              hull() {
                rotate([0, 90, 0]) cylinder(r=2 * holder_connector_radius, h=holder_connector_width, center=true, $fn=24);
                translate([0, -holder_connector_depth, holder_connector_depth]) rotate([0, 90, 0]) cylinder(r=2 * holder_connector_radius, h=holder_connector_width, center=true, $fn=24);
                translate([0, -holder_connector_depth, -holder_connector_depth]) rotate([0, 90, 0]) cylinder(r=2 * holder_connector_radius, h=holder_connector_width, center=true, $fn=24);
              }

              translate([0, -holder_connector_depth - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle) * holder_connector_depth]) {
                // main body
                cube([holder_width, holder_depth, holder_height], center=true);

                // foot
                hull() {
                  translate([0, -holder_depth / 2, holder_edge - sin(holder_angle) * holder_depth - holder_height / 2]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, center=true, $fn=24);
                  translate([0, -holder_depth / 2, 6 * holder_edge - holder_height / 2]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, center=true, $fn=24);
                  translate([-holder_width / 2, 0, -sin(holder_angle) * holder_depth / 2 - holder_height / 2]) rotate([holder_angle, 0, 0]) cube([holder_width, holder_depth / 2, holder_depth / 2]);
                }

                // head
                hull() {
                  translate([0, holder_depth / 2, holder_height / 2 - holder_edge]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, center=true, $fn=24);
                  translate([0, holder_depth / 2, holder_height / 2 - 2 * holder_edge]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, center=true, $fn=24);
                }
              }
            }

            translate([0, -holder_connector_depth - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle) * holder_connector_depth]) {
              // tile slot
              hull() {
                translate([-(holder_width / 2 - holder_edge - tile_radius), holder_depth / 2 - holder_edge, -(holder_height / 2 - holder_edge - tile_radius)]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=tile_depth + 8 * tolerance, $fn=24);
                translate([holder_width / 2 - holder_edge - tile_radius, holder_depth / 2 - holder_edge, -(holder_height / 2 - holder_edge - tile_radius)]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=tile_depth + 8 * tolerance, $fn=24);
                translate([holder_width / 2 - holder_edge - tile_radius, holder_depth / 2 - holder_edge, holder_height / 2 - holder_edge - tile_radius]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=tile_depth + 8 * tolerance, $fn=24);
                translate([-(holder_width / 2 - holder_edge - tile_radius), holder_depth / 2 - holder_edge, holder_height / 2 - holder_edge - tile_radius]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=tile_depth + 8 * tolerance, $fn=24);
              }

              // foot slot
              hull() {
                translate([-(holder_width / 2 - holder_edge - 2 * tile_radius), holder_depth / 2 - holder_edge, -(holder_height / 2 - holder_edge - 4 * tile_radius)]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=holder_depth + holder_edge, $fn=24);
                translate([holder_width / 2 - holder_edge - 2 * tile_radius, holder_depth / 2 - holder_edge, -(holder_height / 2 - holder_edge - 4 * tile_radius)]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=holder_depth + holder_edge, $fn=24);
                translate([holder_width / 2 - holder_edge - 2 * tile_radius, holder_depth / 2 - holder_edge, holder_height / 2 - holder_edge - 4 * tile_radius]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=holder_depth + holder_edge, $fn=24);
                translate([-(holder_width / 2 - holder_edge - 2 * tile_radius), holder_depth / 2 - holder_edge, holder_height / 2 - holder_edge - 4 * tile_radius]) rotate([90, 0, 0]) cylinder(r=tile_radius, h=holder_depth + holder_edge, $fn=24);
              }
            }
          }

          translate([0, -holder_connector_depth - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle) * holder_connector_depth]) {
            difference() {
              translate([0, holder_depth / 2 - 3 * holder_edge / 2, holder_height / 2 - 3 * holder_edge / 2]) cube([holder_width, holder_edge, holder_edge], center=true);
              translate([0, holder_depth / 2 - 2 * holder_edge, holder_height / 2 - 2 * holder_edge]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width + shift, center=true, $fn=24);
            }
          }
        }

        translate([0, -holder_connector_depth - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle) * holder_connector_depth]) {
          // top cut-out
          translate([holder_width / 2, 0, holder_height / 2]) rotate([90, 0, 0]) cylinder(r=2 * holder_width / 3, h=holder_depth + 2 * holder_edge + shift, center=true, $fn=48);
        }
      }
    }
  }
}
