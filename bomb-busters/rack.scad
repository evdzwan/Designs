tolerance = .2;
shift = 1;

tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_count = 5;
holder_angle = 10;
holder_connector_radius = 2;
holder_connector_offset = 8;
holder_width = tile_width + 2 * holder_edge + 2 * tolerance;
holder_height = 25;
holder_depth = tile_depth + 3 * holder_edge + 2 * tolerance;

base_link = 4;
base_foot = 2;
base_slot = 22 + 2 * tolerance;
base_spacing = 2;
base_rod_radius = 1;
base_rod_offset = cos(holder_angle) * (holder_connector_radius + holder_connector_offset);
base_width = holder_count * (holder_width + base_spacing);
base_height = 2;
base_depth = holder_height;

color("teal") base();
color("violet") {
  for (i = [0:holder_count - 1]) {
    translate([(i + .5) * (holder_width + base_spacing), 0, base_rod_offset]) rotate([-holder_angle, 0, 0]) holder();
  }
}

module base() {
  translate([0, 0, base_rod_offset]) rotate([0, 90, 0]) cylinder(r=base_rod_radius, h=base_width, $fn=6);
  difference() {
    cube([base_width, base_depth, base_height]);
    translate([3 * base_link / 4, base_depth / 2, base_height / 2]) scale(1 + tolerance / 2) link();

    for (i = [0:holder_count - 1]) {
      translate([(i + .5) * (holder_width + base_spacing), 0, cos(holder_angle) * holder_connector_radius]) rotate([-holder_angle, 0, 0]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + 2 * tolerance, h=holder_width + 2 * tolerance, center=true, $fn=6);
    }

    for (i = [0:holder_count - 1]) {
      translate([(i + .5) * (holder_width + base_spacing), base_depth - base_slot / 2 + shift, base_height]) cube([tile_width + 4 * tolerance, base_slot + shift, 4 * tolerance], center=true);
    }

    translate([3 * base_foot, 3 * base_foot, -shift]) cylinder(r=base_foot, h=base_height / 2 + shift, $fn=24);
    translate([3 * base_foot, base_depth - 3 * base_foot, -shift]) cylinder(r=base_foot, h=base_height / 2 + shift, $fn=24);
    translate([base_width - 3 * base_foot, 3 * base_foot, -shift]) cylinder(r=base_foot, h=base_height / 2 + shift, $fn=24);
    translate([base_width - 3 * base_foot, base_depth - 3 * base_foot, -shift]) cylinder(r=base_foot, h=base_height / 2 + shift, $fn=24);
  }

  difference() {
    hull() {
      translate([0, 0, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=base_width, $fn=6);
      translate([0, base_rod_offset / 2, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=base_width, $fn=6);
      translate([0, 0, base_rod_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=base_width, $fn=6);
    }

    for (i = [0:holder_count - 1]) {
      hull() {
        translate([(i + .5) * (holder_width + base_spacing), 0, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + shift, h=holder_width + 2 * tolerance, center=true, $fn=6);
        translate([(i + .5) * (holder_width + base_spacing), base_rod_offset / 2, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + shift, h=holder_width + 2 * tolerance, center=true, $fn=6);
        translate([(i + .5) * (holder_width + base_spacing), 0, base_rod_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + shift, h=holder_width + 2 * tolerance, center=true, $fn=6);
      }
    }
  }

  difference() {
    translate([base_width + 3 * base_link / 4, base_depth / 2, base_height / 2]) link();
    translate([base_width + base_link / 2 + base_spacing / 2 - tolerance, base_depth / 2, base_height]) cube([base_link, base_link + shift, 4 * tolerance], center=true);
  }
}

module holder() {
  difference() {
    union() {
      hull() {
        rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_width, center=true, $fn=6);
        translate([0, 0, -holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_width, center=true, $fn=6);
      }

      translate([0, -holder_depth / 2, holder_height / 2 - (holder_connector_offset + holder_connector_radius)]) cube([holder_width, holder_depth, holder_height], center=true);
      translate([0, -holder_depth / 2, -(holder_connector_offset + holder_connector_radius)]) rotate([holder_angle, 0, 0]) cube([holder_width, cos(holder_angle) * holder_depth, sin(holder_angle) * holder_depth], center=true);
    }

    rotate([0, 90, 0]) cylinder(r=base_rod_radius + tolerance, h=holder_width + shift, center=true, $fn=24);
    translate([0, -holder_depth / 2, holder_height / 2 - (holder_connector_offset + holder_connector_radius)]) {
      translate([0, -holder_edge / 2, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - 3 * holder_edge, holder_height], center=true);
      translate([0, -2 * holder_edge, 3 * holder_edge]) cube([holder_width - 4 * holder_edge, holder_depth, holder_height], center=true);
    }
  }
}

module link() {
  translate([-base_link / 4, 0, 0]) {
    cube([base_link, base_link / 2, base_height], center=true);
    hull() {
      translate([base_link / 4, -base_link / 4, 0]) cylinder(d=base_link / 2, h=base_height, center=true, $fn=24);
      translate([base_link / 4, base_link / 4, 0]) cylinder(d=base_link / 2, h=base_height, center=true, $fn=24);
    }
  }
}
