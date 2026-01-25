include <const.scad>
use <../shapes.scad>

tile();

module tile() {
  roundedCube([tile_width, tile_height, tile_depth], radius=tile_radius, $fn=20);
}
