
include <coffee-can-bottom-module.scad>
include <coffee-can-middle-module.scad>
include <coffee-can-top-module.scad>
$fn = 50;

$radius = 60;
$height = 40;
$indent = 10;
$border = 4;

color("#F00") {
  renderBottom($radius, $height, $indent, $border);
}

translate([0, 0, $border]) {
  color("#0F0") {
    renderMiddle($radius, $height, $indent, $border);
  }

  translate([0, 0, $border + $height]) {
    color("#FF0") {
      renderMiddle($radius, $height, $indent, $border);
    }

    translate([0, 0, $border + $height]) {
      color("#0FF") {
        renderTop($radius, $height, $indent, $border);
      }
    }
  }
}
