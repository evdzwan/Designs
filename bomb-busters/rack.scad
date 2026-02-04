tolerance = .2;
shift = 1;

tile_count = 5;
tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_width = tile_width + 2 * holder_edge + 4 * tolerance;
holder_height = tile_height + 2 * holder_edge + 8 * tolerance;
holder_depth = tile_depth + 2 * holder_edge + 4 * tolerance;
holder_connector_radius = 2;
holder_spacing = 2;

base_edge = 2;
base_width = tile_count * (holder_width + holder_spacing) - holder_spacing + 2 * base_edge;
base_height = 2 * holder_connector_radius;
base_depth = holder_height - 2 * holder_connector_radius;
base_link = 2;

foot_height = 1;
foot_radius = 2;

// 1 kant iets hoger, connector dus ook (10 graden verhaal)
// 10graden op onderkant voor platte aansluiting
// afronding top hoek + 1mm extra

color("teal") base();
for (i = [0:tile_count - 1]) {
  holder_angle = 0; //-10 - i * 80 / max(tile_count - 1, 1);
  color("magenta") translate([i * (holder_width + holder_spacing) + holder_width / 2 + base_edge, 0, 2 * holder_connector_radius]) rotate([holder_angle, 0, 0]) holder();
}

module base() {
  difference() {
    union() {
      cube([base_width, base_depth, base_height - tolerance]);
      translate([0, 0, 2 * holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=2 * holder_connector_radius, h=base_width, $fn=6);
    }

    for (i = [0:tile_count - 1]) {
      // holder slots
      translate([i * (holder_width + holder_spacing) + holder_width / 2 + base_edge, 0, 2 * holder_connector_radius]) cube([holder_width + 2 * tolerance, 4 * holder_connector_radius + 2 * tolerance, 4 * holder_connector_radius + shift], center=true);

      // indicator slots
      translate([i * (holder_width + holder_spacing) + holder_width / 2 + base_edge, base_depth, base_height / 2]) cube([tile_width + 4 * tolerance, 4 * holder_connector_radius + 4 * tolerance, base_height + shift], center=true);
    }

    // link slot
    translate([base_width - base_link, base_depth / 2 - base_link, -shift]) cube([base_link + shift, 2 * base_link, base_link + shift]);
    translate([base_width - 2 * base_link - tolerance, base_depth / 2 - 3 * base_link / 2, -shift / 2]) cube([base_link + 2 * tolerance, 3 * base_link, base_height - tolerance + shift]);

    // left foot slot
    hull() {
      translate([base_edge + 3 * foot_radius, 3 * holder_connector_radius + 3 * foot_radius, 0]) cylinder(r=foot_radius + tolerance, h=foot_height + tolerance, $fn=20);
      translate([base_edge + 3 * foot_radius, base_depth - (3 * holder_connector_radius + 3 * foot_radius), 0]) cylinder(r=foot_radius + tolerance, h=foot_height + tolerance, $fn=20);
    }

    // right foot slot
    hull() {
      translate([base_width - (base_edge + 3 * foot_radius), 3 * holder_connector_radius + 3 * foot_radius, 0]) cylinder(r=foot_radius + tolerance, h=foot_height + tolerance, $fn=20);
      translate([base_width - (base_edge + 3 * foot_radius), base_depth - (3 * holder_connector_radius + 3 * foot_radius), 0]) cylinder(r=foot_radius + tolerance, h=foot_height + tolerance, $fn=20);
    }
  }

  // link
  translate([-base_link, base_depth / 2 - base_link, 0]) cube([base_link, 2 * base_link, base_link - tolerance]);
  translate([-2 * base_link, base_depth / 2 - 3 * base_link / 2, 0]) cube([base_link, 3 * base_link, base_height - tolerance]);

  for (i = [0:tile_count - 1]) {
    translate([i * (holder_width + holder_spacing) + holder_width / 2 + base_edge, 0, 2 * holder_connector_radius]) {
      translate([-(holder_width + 2 * tolerance) / 2, 0, 0]) rotate([0, 90, 0]) sphere(r=holder_connector_radius - 2 * tolerance, $fn=6);
      translate([(holder_width + 2 * tolerance) / 2, 0, 0]) rotate([0, 90, 0]) sphere(r=holder_connector_radius - 2 * tolerance, $fn=6);
    }
  }
}

module holder() {
  difference() {
    union() {
      translate([0, -(holder_depth) / 2, (holder_height - 4 * holder_connector_radius) / 2]) cube([holder_width, holder_depth, holder_height], center=true);
      rotate([0, 90, 0]) cylinder(r=2 * holder_connector_radius, h=holder_width, center=true, $fn=6);
    }

    translate([0, -(holder_depth) / 2, (holder_height - 4 * holder_connector_radius) / 2]) {
      cube([holder_width - 2 * holder_edge, holder_depth - 2 * holder_edge, holder_height - 2 * holder_edge], center=true);
      translate([0, -(holder_depth - 2 * holder_edge + shift) / 2, (holder_height / 3 + shift) / 2]) cube([holder_width + shift, 2 * holder_edge + shift, 2 * holder_height / 3 + shift], center=true);
      translate([0, -(holder_depth - 2 * holder_edge + shift) / 2, (-2 * holder_height / 3 + 4 * holder_edge + shift) / 2]) cube([holder_width - 4 * holder_edge, 2 * holder_edge + shift, holder_height / 3 - 4 * holder_edge + shift], center=true);
      translate([holder_width / 2, 0, holder_height / 2]) rotate([90, 0, 0]) cylinder(r=2 * holder_width / 3, h=holder_depth + shift, center=true, $fn=20);
    }

    translate([-holder_width / 2, 0, 0]) rotate([0, 90, 0]) sphere(r=holder_connector_radius + tolerance, $fn=6);
    translate([holder_width / 2, 0, 0]) rotate([0, 90, 0]) sphere(r=holder_connector_radius + tolerance, $fn=6);
  }
}
