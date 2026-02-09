include <const.scad>

tile();

module tile() {
  translate([0, -(2 * holder_edge + tile_depth / 2 + tolerance), tile_height / 2 - (holder_connector_offset + holder_connector_radius)]) cube([tile_width, tile_depth, tile_height], center=true);
}
