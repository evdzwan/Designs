include <coffee-can-top-module.scad>
$fn = 50;

translate([0, 0, 55]) {
  rotate([0, 180, 180]) {
    renderTop(60, 40, 10, 4);
  }
}
