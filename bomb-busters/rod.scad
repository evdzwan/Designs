include <const.scad>

rod();

module rod() {
  rotate([90, 0, 90]) cylinder(r=rod_radius - tolerance, h=tile_count * (holder_width + 2 * tolerance) + base_edge - 2 * tolerance, $fn=6);
}
