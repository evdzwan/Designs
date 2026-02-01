include <const.scad>
use <holder.scad>

$fn = 20;
color("teal") base();
*for(i=[0:holder_count - 1]) {
  holder_angle = holder_angle_min + (i / (holder_count - 1)) * (holder_angle_max - holder_angle_min);
  color("magenta") translate([i * (holder_width + 2 * tolerance) + holder_width / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([-holder_angle, 0, 0]) holder();
}

module base() {
  difference() {
    union() {
      // main body
      difference() {
        base_hull();
        translate([-base_scale_diff * base_width, base_scale_diff * (sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth)), 0]) scale([1 + 2 * base_scale_diff, 1 - 2 * base_scale_diff, 1 - 2 * base_scale_diff]) base_hull();
        translate([-shift / 2, -base_radius - shift / 2, -base_radius - shift]) cube([base_width + shift, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth) + 2 * base_radius + shift, base_radius + shift]);
      }

      // connector bar
      translate([0, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);

      // foot
      translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth) + base_radius / 2, 0]) {
        rotate([90, 0, 90]) {
          linear_extrude(base_width) {
            polygon(
              [
                [base_foot / 2, 0],
                [-sin(holder_angle_min) * base_foot, base_foot],
                [0, 0],
              ]
            );
          }
        }
      }
    }

    // connector slots
    for (i = [0:holder_count - 1]) {
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=2 * holder_connector_radius, h=holder_connector_width + tolerance, center=true);
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (holder_connector_width + tolerance) / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) sphere(r=holder_connector_inset);
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2 + (holder_connector_width + tolerance) / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) sphere(r=holder_connector_inset);
    }

    // foot slots
    for (i = [-1:1]) {
      translate([i * (base_width - 3 * foot_width) / 2 + base_width / 2, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth) + base_foot / 4 - tolerance / 2, -shift]) {
        hull() {
          translate([-(foot_width + tolerance) / 2, 0, 0]) cylinder(r=foot_radius + tolerance / 2, h=2 * tolerance + shift);
          translate([(foot_width + tolerance) / 2, 0, 0]) cylinder(r=foot_radius + tolerance / 2, h=2 * tolerance + shift);
        }
      }
    }

    // indicator slots
    for (i = [0:holder_count - 1]) {
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * (base_depth - tile_indicator_height / 2), cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * (base_depth - (tile_indicator_height + 2 * tolerance) / 2) + base_radius]) rotate([-holder_angle_min, 0, 0]) cube([tile_width + 2 * tolerance, tile_indicator_height + 2 * tolerance, 2 * tile_depth], center=true);
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + base_radius, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth + base_radius]) rotate([-holder_angle_min, 0, 0]) cylinder(d=tile_width / 2, h=2 * tile_depth, center=true, $fn=10);
    }
  }
}

module base_hull() {
  hull() {
    translate([0, 0, 0]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
    translate([0, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
    translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
    translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth), 0]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
  }
}
