tolerance = .2;
shift = 1;

tile_count = 2;
tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_spacing = 2;
holder_connector_inner_radius = 1;
holder_connector_outer_radius = 2 * holder_connector_inner_radius;
holder_connector_offset = 4;
holder_angle_max = 100;
holder_angle_min = 10;
holder_width = tile_width + 2 * holder_edge + 2 * tolerance;
holder_height = tile_height + 2 * holder_edge + 2 * tolerance;
holder_depth = tile_depth + holder_edge + 2 * tolerance;

base_width = tile_count * (holder_width + holder_spacing);

color("teal") base();
color("magenta") {
  for (i = [0:tile_count - 1]) {
    translate([(i + .5) * (holder_width + holder_spacing), holder_connector_outer_radius, holder_connector_outer_radius]) rotate([-holder_angle_min - i * (holder_angle_max - holder_angle_min) / max(tile_count - 1, 1), 0, 0]) holder();
  }
}

module base() {
  translate([0, holder_connector_outer_radius, holder_connector_outer_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_inner_radius, h=base_width, $fn=6);
  difference() {
    cube([base_width, 2 * holder_connector_outer_radius, 2 * holder_connector_outer_radius]);
    for (i = [0:tile_count - 1]) {
      translate([(i + .5) * (holder_width + holder_spacing), holder_connector_outer_radius, holder_connector_outer_radius]) cube([holder_width + 2 * tolerance, 2 * holder_connector_outer_radius + shift, 2 * holder_connector_outer_radius + shift], center=true);
    }
  }
}

module holder() {
  difference() {
    union() {
      rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=holder_width, center=true, $fn=6);
      translate([0, -holder_depth / 2, holder_height / 2 - holder_connector_offset]) cube([holder_width, holder_depth, holder_height], center=true);
    }

    rotate([0, 90, 0]) cylinder(r=holder_connector_inner_radius + tolerance, h=holder_width + shift, center=true, $fn=24);
    translate([0, -holder_depth / 2 - holder_edge, holder_height / 2 - holder_connector_offset]) cube([holder_width - 2 * holder_edge, holder_depth, holder_height - 2 * holder_edge], center=true);
  }
}
