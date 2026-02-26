include <const.scad>

tile();

module tile() {
  hull() {
    translate([-(tile_width / 2 - tile_radius), -(tile_height / 2 - tile_radius), 0]) cylinder(r=tile_radius, h=tile_depth, center=true, $fn=24);
    translate([tile_width / 2 - tile_radius, -(tile_height / 2 - tile_radius), 0]) cylinder(r=tile_radius, h=tile_depth, center=true, $fn=24);
    translate([tile_width / 2 - tile_radius, tile_height / 2 - tile_radius, 0]) cylinder(r=tile_radius, h=tile_depth, center=true, $fn=24);
    translate([-(tile_width / 2 - tile_radius), tile_height / 2 - tile_radius, 0]) cylinder(r=tile_radius, h=tile_depth, center=true, $fn=24);
  }
}
