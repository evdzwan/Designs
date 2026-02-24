include <const.scad>
use <holder.scad>
use <base.scad>

base();
translate([-base_width / 2, 0, 0]) {
  for (i = [0:tile_count - 1]) {
    translate([(i + .5) * (holder_width + base_spacing), 0, 0]) holder();
  }
}
