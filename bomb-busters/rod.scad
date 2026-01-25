include <const.scad>

rod(count=7);

module rod(count) {
  rotate([90, 0, 90]) cylinder(r=rod_radius - tolerance / 2, h=count * holder_width + base_edge, $fn=6);
}
