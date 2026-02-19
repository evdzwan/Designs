include <const.scad>

base();

module base() {
  difference() {
    union() {
      difference() {
        translate([0, base_radius, 0]) {
          difference() {
            // body
            union() {
              base_hull(radius=base_radius);
              translate([0, -(2 * holder_connector_radius + tolerance), 0]) rotate([-holder_angle_min, 0, 0]) translate([0, 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([holder_angle_min, 0, 0]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=24);
            }

            // connector slots
            for (i = [0:holder_count - 1]) {
              translate([(i + .5) * (holder_width + holder_spacing), -(2 * holder_connector_radius + tolerance), 0]) rotate([-holder_angle_min, 0, 0]) translate([0, 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=2 * (base_radius + tolerance) + tolerance, h=holder_connector_inner_width + 2 * tolerance, center=true, $fn=24);
              translate([(i + .5) * (holder_width + holder_spacing), -(2 * holder_connector_radius + tolerance), 0]) rotate([-holder_angle_min, 0, 0]) translate([0, 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + 3 * tolerance / 2, h=holder_connector_outer_width + 2 * tolerance, center=true, $fn=24);
            }

            // indicator slots
            for (i = [0:holder_count - 1]) {
              translate([(i + .5) * (holder_width + holder_spacing), 4 * foot_radius - base_radius + foot_width + base_radius / 2, 0]) translate([0, -base_radius / 2, 0]) rotate([-2 * holder_angle_min, 0, 0]) translate([0, base_radius / 2, 0]) cube([tile_width + 4 * tolerance, base_radius, 2 * holder_connector_offset], center=true);
            }
          }
        }

        // foot slots
        base_foot(offset=0, direction=1);
        base_foot(offset=base_width, direction=-1);

        // link slot
        base_link(offset=0, tolerance=tolerance);
      }

      // link
      base_link(offset=base_width, tolerance=0);
    }

    // floor cut-out
    translate([-shift / 2, -shift / 2, -(base_radius + shift)]) cube([base_width + 3 * base_link_radius + shift, base_depth + 3 * base_radius + shift, base_radius + shift]);
  }
}

module base_foot(offset, direction) {
  hull() {
    translate([offset + direction * (2 * foot_radius), 2 * foot_radius, -shift]) cylinder(r=foot_radius + tolerance, h=foot_height + shift, $fn=24);
    translate([offset + direction * (2 * foot_radius + foot_width / 2), 2 * foot_radius + foot_width / 2, -shift]) cylinder(r=foot_radius + tolerance, h=foot_height + shift, $fn=24);
  }
  hull() {
    translate([offset + direction * (2 * foot_radius), 2 * foot_radius + foot_width, -shift]) cylinder(r=foot_radius + tolerance, h=foot_height + shift, $fn=24);
    translate([offset + direction * (2 * foot_radius + foot_width / 2), 2 * foot_radius + foot_width / 2, -shift]) cylinder(r=foot_radius + tolerance, h=foot_height + shift, $fn=24);
  }
}

module base_hull(radius) {
  hull() {
    rotate([0, 90, 0]) cylinder(r=radius, h=base_width, $fn=24);
    translate([0, -(2 * holder_connector_radius + tolerance), 0]) rotate([-holder_angle_min, 0, 0]) translate([0, 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([holder_angle_min, 0, 0]) rotate([0, 90, 0]) cylinder(r=radius, h=base_width, $fn=24);
    translate([0, -(2 * holder_connector_radius + tolerance) + sin(holder_angle_max) * base_depth, cos(holder_angle_max) * base_depth]) rotate([-holder_angle_min, 0, 0]) translate([0, 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([holder_angle_min, 0, 0]) rotate([0, 90, 0]) cylinder(r=radius, h=base_width, $fn=24);
    translate([0, base_depth + holder_connector_radius, 0]) rotate([0, 90, 0]) cylinder(r=radius, h=base_width, $fn=24);
  }
}

module base_link(offset, tolerance) {
  hull() {
    translate([offset, 2 * foot_radius + foot_width / 2, -shift]) cylinder(r=base_link_radius + tolerance / 2, h=base_link_height + tolerance + shift, $fn=24);
    translate([offset + 2 * base_link_radius, 2 * foot_radius + foot_width / 2, -shift]) cylinder(r=base_link_radius + tolerance / 2, h=base_link_height + tolerance + shift, $fn=24);
  }
  hull() {
    translate([offset + 2 * base_link_radius, 2 * foot_radius + foot_width / 2 - base_link_radius, -shift]) cylinder(r=base_link_radius + tolerance / 2, h=3 * base_link_height / 2 + tolerance + shift, $fn=24);
    translate([offset + 2 * base_link_radius, 2 * foot_radius + foot_width / 2 + base_link_radius, -shift]) cylinder(r=base_link_radius + tolerance / 2, h=3 * base_link_height / 2 + tolerance + shift, $fn=24);
  }
}
