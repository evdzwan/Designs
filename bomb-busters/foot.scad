include <const.scad>

foot();

module foot() {
  intersection() {
    cylinder(r=foot_radius, h=2 * foot_height, $fn=48);
    translate([0, 0, -2 * foot_radius + 3 * foot_height / 2]) sphere(r=2 * foot_radius, $fn=48);
  }
}
