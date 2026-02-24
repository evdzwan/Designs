include <const.scad>

tile();

module tile() {
  cube([tile_width, tile_height, tile_depth], center=true);
}
