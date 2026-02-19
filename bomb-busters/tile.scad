include <const.scad>

tile();

module tile() {
  cube([tile_width, tile_depth, tile_height], center=true);
}
