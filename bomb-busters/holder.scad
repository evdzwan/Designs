include <const.scad>

rotate([-holder_angle, 0, 0]) holder();

module holder() {
  difference() {
    union() {
      // connector
      hull() {
        rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_width, center=true, $fn=6);
        translate([0, 0, -holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_width, center=true, $fn=6);
      }

      // body
      translate([0, -holder_depth / 2, holder_height / 2 - (holder_connector_offset + holder_connector_radius)]) cube([holder_width, holder_depth, holder_height], center=true);
      translate([0, -holder_depth / 2, -(holder_connector_offset + holder_connector_radius)]) rotate([holder_angle, 0, 0]) cube([holder_width, cos(holder_angle) * holder_depth, sin(holder_angle) * holder_depth], center=true);
    }

    // rod hole
    rotate([0, 90, 0]) cylinder(r=base_rod_radius + tolerance, h=holder_width + shift, center=true, $fn=24);

    // inset
    translate([0, -holder_depth / 2, holder_height / 2 - (holder_connector_offset + holder_connector_radius)]) {
      translate([0, -holder_edge / 2, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - 3 * holder_edge, holder_height], center=true);
      translate([0, -2 * holder_edge, 3 * holder_edge]) cube([holder_width - 4 * holder_edge, holder_depth, holder_height], center=true);
    }
  }
}
