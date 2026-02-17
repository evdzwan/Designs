include <const.scad>

foot();

module foot() {
  intersection() {
    cylinder(r=foot_radius, h=2 * foot_radius, $fn=48);
    translate([0, 0, -2 * foot_radius + 7 * foot_height / 3]) sphere(r=2 * foot_radius, $fn=48);
  }
}
