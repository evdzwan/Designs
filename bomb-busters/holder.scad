include <const.scad>

holder();

module holder() {
  rotate([-holder_angle_min, 0, 0]) {
    translate([-holder_width / 2, -(holder_depth + 2 * holder_connector_radius + tolerance), -holder_connector_offset]) {
      difference() {
        union() {
          // link
          hull() {
            translate([(holder_width - holder_connector_inner_width) / 2, holder_depth, holder_connector_offset - (2 * holder_connector_radius + tolerance)]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, $fn=24);
            translate([(holder_width - holder_connector_inner_width) / 2, holder_depth + 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, $fn=24);
            translate([(holder_width - holder_connector_inner_width) / 2, holder_depth, holder_connector_offset + (2 * holder_connector_radius + tolerance)]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, $fn=24);
          }

          // connector
          translate([(holder_width - holder_connector_outer_width) / 2, holder_depth + 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_outer_width, $fn=24);

          // body
          cube([holder_width, holder_depth, holder_height]);

          // foot
          hull() {
            translate([0, 0, holder_edge - sin(holder_angle_min) * holder_depth]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, $fn=24);
            translate([0, 0, 6 * holder_edge]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, $fn=24);
            translate([0, holder_depth / 2, -sin(holder_angle_min) * holder_depth / 2]) rotate([10, 0, 0]) cube([holder_width, holder_depth / 2, holder_depth / 2]);
          }

          // head
          hull() {
            translate([0, holder_depth, holder_height - holder_edge]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, $fn=24);
            translate([0, holder_depth, holder_height - 2 * holder_edge]) rotate([0, 90, 0]) cylinder(r=holder_edge, h=holder_width, $fn=24);
          }
        }

        // tile inset
        translate([holder_edge, -4 * tolerance, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - holder_edge, holder_height - 2 * holder_edge - tile_depth]);

        // foot inset
        hull() {
          translate([2 * holder_edge, -holder_edge, 3 * holder_edge]) rotate([90, 0, 0]) cylinder(d=holder_edge, h=holder_depth, center=true, $fn=24);
          translate([holder_width - 2 * holder_edge, -holder_edge, 3 * holder_edge]) rotate([90, 0, 0]) cylinder(d=holder_edge, h=holder_depth, center=true, $fn=24);
          translate([holder_width - 2 * holder_edge, -holder_edge, holder_height / 2]) rotate([90, 0, 0]) cylinder(d=holder_edge, h=holder_depth, center=true, $fn=24);
          translate([2 * holder_edge, -holder_edge, holder_height / 2]) rotate([90, 0, 0]) cylinder(d=holder_edge, h=holder_depth, center=true, $fn=24);
        }

        // top chamfer
        translate([holder_edge, 0, holder_height - holder_edge - tile_depth]) rotate([0, 90, 0]) cylinder(r=tile_depth, h=holder_width - 2 * holder_edge, $fn=24);

        // top cut-out
        translate([holder_width, -shift / 2, holder_height]) rotate([-90, 0, 0]) cylinder(r=2 * holder_width / 3, h=holder_depth + holder_edge + shift, $fn=24);
      }
    }
  }
}
