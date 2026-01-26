include <const.scad>

rod();

module rod() {
  rotate([90, 0, 90]) cylinder(r=rod_radius - tolerance / 2, h=tile_count * holder_width + base_edge, $fn=6);
}
