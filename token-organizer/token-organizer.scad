include <token-organizer-box-module.scad>
include <token-organizer-separator-module.scad>
$fn = 50;

color("magenta") {
  renderBox(size=100, height=30, bottom=2, radius=5, insetHeight=4);
}

color("cyan") {
  translate([0, 0, -1.1]) {
    rotate([0, 0, 45]) {
      renderSeparator(size=100, height=30, bottom=2, thickness=2, radius=5, insetHeight=4);
    }
  }
}

color("olive") {
  translate([0, 0, -1.1]) {
    rotate([0, 0, 315]) {
      scale([1, 1, -1]) {
        renderSeparator(size=100, height=30, bottom=2, thickness=2, radius=5, insetHeight=4);
      }
    }
  }
}
