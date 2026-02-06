tolerance = .2;
shift = 1;

tile_count = 5;
tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_connector_inner_radius = 1;
holder_connector_outer_radius = 2;
holder_width = tile_width + 2 * holder_edge + 2 * tolerance;
holder_height = tile_height + 2 * holder_edge + 4 * tolerance;
holder_depth = 2 * holder_connector_outer_radius;

base_holder_spacing = 2;
base_width = tile_count * (holder_width + base_holder_spacing);
base_height = 1;
base_depth = 30;

translate([0, base_height + holder_connector_outer_radius + tolerance, base_height + holder_connector_outer_radius + tolerance]) {
  color("teal") base();
  color("magenta") {
    for (i = [0:tile_count - 1]) {
      angle = 90; //i * 90 / max(tile_count - 1, 1);
      translate([(i + .5) * (holder_width + base_holder_spacing), 0, 0]) rotate([angle, 0, 0]) holder();
    }
  }
}

module base() {
  difference() {
    union() {
      translate([base_width / 2, 0, -tolerance / 2]) cube([base_width, 2 * holder_connector_outer_radius + 2 * tolerance, 2 * holder_connector_outer_radius + tolerance], center=true);
      translate([base_width / 2, base_depth / 2 - holder_connector_outer_radius, -(base_height + holder_connector_outer_radius / 4) - tolerance / 2]) cube([base_width, base_depth, base_height + tolerance], center=true);
    }

    for (i = [0:tile_count]) {
      translate([(i + .5) * (holder_width + base_holder_spacing), base_depth / 2 - holder_connector_outer_radius, 0]) cube([holder_width + 2 * tolerance, base_depth + shift, 2 * holder_connector_outer_radius + shift], center=true);
    }
  }

  rotate([0, 90, 0]) cylinder(r=holder_connector_inner_radius, h=base_width, $fn=6);
  translate([0, -holder_connector_outer_radius - tolerance, -(base_height + holder_depth / 2 + tolerance)]) cube([base_width, base_depth + tolerance, base_height]);
  translate([0, -(base_height + holder_connector_outer_radius + tolerance), -(base_height + holder_depth / 2 + tolerance)]) cube([base_width, base_height, base_height + 2 * holder_connector_outer_radius + tolerance]);
}

module holder() {
  difference() {
    union() {
      rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=holder_width, center=true, $fn=6);
      translate([0, holder_height / 2, 0]) {
        difference() {
          cube([holder_width, holder_height, holder_depth], center=true);
          cube([holder_width - 2 * holder_edge, holder_height - 2 * holder_edge, holder_depth - 2 * holder_edge], center=true);
          translate([0, (holder_height / 3 + shift) / 2, (2 * holder_edge + shift) / 2]) cube([holder_width + shift, 2 * holder_height / 3 + shift, holder_depth - holder_edge + shift], center=true);
          translate([0, 0, (2 * holder_edge + shift) / 2]) cube([holder_width - 6 * holder_edge, holder_height - 8 * holder_edge, holder_depth - holder_edge + shift], center=true);
          translate([holder_width / 2, holder_height / 2, 0]) cylinder(r=2 * holder_width / 3, h=holder_depth + shift, center=true, $fn=24);
        }
      }
    }

    rotate([0, 90, 0]) cylinder(r=holder_connector_inner_radius + tolerance, h=holder_width + shift, center=true, $fn=24);
  }
}
