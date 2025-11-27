include <coffee-can-bottom-module.scad>
include <coffee-can-middle-module.scad>
include <coffee-can-top-module.scad>
$fn = 50;

$radius = 60;
$height = 40;
$indent = 10;
$margin = 5;
$border = 4;

translate([$radius + $margin, $radius + $margin, 0]) {
  renderBottom($radius, $height, $indent, $border);
}

translate([$radius + $margin, ($radius + $margin) * 3, 0]) {
  renderMiddle($radius, $height, $indent, $border);
}

translate([($radius + $margin) * 3, ($radius + $margin) * 3, 0]) {
  renderMiddle($radius, $height, $indent, $border);
}

translate([($radius + $margin) * 3, $radius + $margin, 55]) {
  rotate([0, 180, 180]) {
    renderTop($radius, $height, $indent, $border);
  }
}
