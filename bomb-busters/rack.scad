tolerance = .2;
shift = 1;

tile_count = 7;
tile_width = 14;
tile_height = 45;

holder_width = tile_width;
holder_height = tile_height;
holder_depth = 5;
holder_connector = 8;
rod_diameter = 2;

base_tile_spacing = 1;
base_width = tile_count * (holder_width + base_tile_spacing) + base_tile_spacing;
base_height = 5;
base_depth = holder_height;

// ga voor print in place

$fn = 20;
color("teal") base();
for (i = [0:tile_count - 1]) {
  color("magenta") translate([i * (holder_width + base_tile_spacing) + holder_width / 2 + base_tile_spacing, base_height / 2, base_height / 2]) rotate([-10 - (i / (tile_count - 1)) * 80, 0, 0]) holder();
}

module base() {
  difference() {
    // body
    cube([base_width, base_depth, base_height]);

    // holder slots
    for (i = [0:tile_count - 1]) {
      translate([i * (holder_width + base_tile_spacing) + holder_width / 2 + base_tile_spacing, (base_height - shift) / 2, base_height / 2]) cube([holder_connector + 5 * tolerance, base_height + 4 * tolerance + shift, base_height + shift], center=true);
    }
  }

  translate([base_width / 2, base_height / 2, base_height / 2]) rotate([90, 0, 90]) cylinder(d=rod_diameter, h=base_width, center=true);
}

module holder() {
  translate([0, 0, -holder_depth / 2]) {
    translate([0, 0, holder_depth / 2]) cube([holder_connector, holder_depth, holder_depth], center=true);
    translate([0, -holder_depth, holder_height / 2]) cube([holder_width, holder_depth, holder_height], center=true);
  }
}
