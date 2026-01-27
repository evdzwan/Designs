include <const.scad>

rod();

module rod() {
  rotate([90, 0, 90]) cylinder(r=rod_radius - tolerance, h=tile_count * (holder_width + base_holderspacing + 2 * tolerance) + base_edge - base_holderspacing - 2 * tolerance, $fn=6);
}
