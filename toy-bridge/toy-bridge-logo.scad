include <../text.scad>
$fn = 50;

logo(size=6, thickness=1);
translate([20, 0, 0]) {
  logo(size=5, thickness=.8);
}
