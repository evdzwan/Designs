include <clip-module.scad>
$fn = 10;

for (x = [1:4]) {
  for (y = [1:8]) {
    translate([10 + x * 50, 10 + y * 20, 0]) {
      renderClip(4);
    }
  }
}
