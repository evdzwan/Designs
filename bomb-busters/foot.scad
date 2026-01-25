include <const.scad>

foot();

module foot() {
  intersection() {
    translate([0, 0, -2 * ((foot_radius - tolerance / 2) - foot_height)]) sphere(r=2 * (foot_radius - tolerance / 2), $fn=50);
    cylinder(r=foot_radius - tolerance / 2, h=2 * foot_height, $fn=50);
  }
}
