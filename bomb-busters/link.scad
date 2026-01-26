include <const.scad>
use <tile.scad>

link();

module link() {
  difference() {
    union() {
      cylinder(r=link_outerradius - tolerance, h=link_indent - tolerance, $fn=50);
      cylinder(r=link_outerradius - tolerance / 2, h=holder_width - tolerance, $fn=6);
    }

    translate([0, 0, -shift / 2]) cylinder(r=link_innerradius, h=holder_width - tolerance + shift, $fn=50);
  }
}
