include <token-organizer-box-module.scad>
include <token-organizer-separator-module.scad>
$fn = 50;

boxSizeX = 100;
boxSizeY = 100;
boxSizeZ = 30;
boxRadius = 5;
spacing = .4;

color("olive") {
  renderBox(boxSizeX, boxSizeY, boxSizeZ, boxRadius, spacing);
}
color("cyan") {
  rotate([0, 0, 45]) {
    renderSeparator(boxSizeX, boxSizeY, boxSizeZ, boxRadius, spacing);
  }
}
color("magenta") {
  rotate([0, 0, 315]) {
    translate([0, 0, boxSizeZ + boxRadius / 2 - spacing]) {
      scale([1, 1, -1]) {
        renderSeparator(boxSizeX, boxSizeY, boxSizeZ, boxRadius, spacing);
      }
    }
  }
}
