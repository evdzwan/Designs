include <const.scad>
use <tile.scad>

divider_foot = 1;
divider_width = base_width;
divider_height = tile_height + divider_foot;
divider_depth = 1;

divider();

color("teal") {
  for (i = [0:tile_count - 1]) {
    translate([(i + .5) * (holder_width + base_spacing), divider_foot + tile_height / 2, divider_depth + tile_depth / 2]) tile();
  }
}

module divider() {
  difference() {
    union() {
      cube([divider_width, divider_height, divider_depth]);

      intersection() {
        cube([divider_width, divider_height, base_spacing]);
        for (i = [0:tile_count]) {
          translate([i * (holder_width + base_spacing), 0, -2 * base_spacing - 2 * tolerance]) rotate([0, 90, 90]) cylinder(r=3 * base_spacing, h=divider_height, $fn=24);
        }
      }
    }

    for (i = [0:tile_count]) {
      translate([i * (holder_width + base_spacing), -shift / 2, -2 * base_spacing - divider_depth - 2 * tolerance]) rotate([0, 90, 90]) cylinder(r=3 * base_spacing, h=divider_height + shift, $fn=24);
    }
  }

  translate([0, 0, divider_depth]) cube([divider_width, divider_foot, 4 * divider_depth]);
  translate([0, divider_foot, 4 * divider_depth]) cube([divider_width, 2 * divider_depth, divider_depth]);
}
