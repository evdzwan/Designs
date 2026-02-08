include <const.scad>
use <holder.scad>
use <foot.scad>
use <base.scad>

color("teal") base();
color("violet") {
  for (i = [0:holder_count - 1]) {
    translate([(i + .5) * (holder_width + base_spacing), 0, base_rod_offset]) rotate([-holder_angle, 0, 0]) holder();
  }
}
*color("crimson") {
  translate([3 * foot_radius, 3 * foot_radius, foot_height - tolerance]) rotate([180, 0, 0]) foot();
  translate([3 * foot_radius, base_depth - 3 * foot_radius, foot_height - tolerance]) rotate([180, 0, 0]) foot();
  translate([base_width - 3 * foot_radius, 3 * foot_radius, foot_height - tolerance]) rotate([180, 0, 0]) foot();
  translate([base_width - 3 * foot_radius, base_depth - 3 * foot_radius, foot_height - tolerance]) rotate([180, 0, 0]) foot();
}
