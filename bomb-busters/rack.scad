include <const.scad>
use <holder.scad>
use <base.scad>

color("teal") base();
color("magenta") {
  for (i = [0:holder_count - 1]) {
    angle = i * (holder_angle_max - holder_angle_min) / max(holder_count - 1, 1);
    translate([(i + .5) * (holder_width + holder_spacing), base_radius - (2 * holder_connector_radius + tolerance), 0]) rotate([-holder_angle_min, 0, 0]) translate([0, 2 * holder_connector_radius + tolerance, holder_connector_offset]) rotate([holder_angle_min - angle, 0, 0]) holder();
  }
}
