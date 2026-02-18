shift = 1;
tolerance = .2;

tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 2;
holder_count = 5;
holder_angle_min = 10;
holder_angle_max = 100;
holder_connector_inner_width = 8;
holder_connector_outer_width = 14;
holder_connector_offset = 12;
holder_connector_radius = 2;
holder_width = tile_width + 2 * holder_edge + 4 * tolerance;
holder_height = tile_height + 3 * holder_edge + 8 * tolerance;
holder_depth = tile_depth / 2 + holder_edge + 2 * tolerance;

base_radius = 4;
base_spacing = 4;
base_width = holder_count * (holder_width + base_spacing);
base_height = holder_connector_offset;
base_depth = 30;

color("teal") base();
color("olive") {
  for (i = [0:holder_count - 1]) {
    translate([(i + .5) * (holder_width + base_spacing), 0, holder_connector_offset * cos(holder_angle_min)]) rotate([i * -(holder_angle_max - holder_angle_min) / max(holder_count - 1, 1), 0, 0]) holder();
  }
}

module base() {
  difference() {
    union() {
      translate([base_width / 2, 0, 0]) {
        difference() {
          base_hull([base_width, base_depth, base_height], base_radius);
          base_hull([base_width + shift, base_depth, base_height], base_radius / 2);
          translate([0, base_depth / 2, -(base_radius + shift) / 2]) cube([base_width + shift, base_depth + 4 * base_radius + shift, base_radius + shift], center=true);
        }
      }
      translate([0, 0, cos(holder_angle_min) * holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=24);
    }

    for (i = [0:holder_count - 1]) {
      translate([(i + .5) * (holder_width + base_spacing), 0, cos(holder_angle_min) * holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=3 * holder_connector_radius, h=holder_connector_inner_width + 2 * tolerance, center=true, $fn=24);
      translate([(i + .5) * (holder_width + base_spacing), 0, cos(holder_angle_min) * holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + tolerance, h=holder_connector_outer_width + 2 * tolerance, center=true, $fn=24);
    }
  }
}

module base_hull(dimensions, radius) {
  translate([0, -sin(holder_angle_min) * dimensions[2], 0]) {
    hull() {
      translate([0, 0, 0]) rotate([90, 0, 90]) cylinder(r=radius, h=dimensions[0], center=true, $fn=24);
      translate([0, sin(holder_angle_min) * dimensions[2], cos(holder_angle_min) * dimensions[2]]) rotate([90, 0, 90]) cylinder(r=radius, h=dimensions[0], center=true, $fn=24);
      translate([0, sin(holder_angle_min) * dimensions[2] + sin(holder_angle_max) * dimensions[1], cos(holder_angle_min) * dimensions[2] + cos(holder_angle_max) * dimensions[1]]) rotate([90, 0, 90]) cylinder(r=radius, h=dimensions[0], center=true, $fn=24);
      translate([0, sin(holder_angle_min) * dimensions[2] + sin(holder_angle_max) * dimensions[1] + sin(holder_angle_min) * (cos(holder_angle_min) * dimensions[2] + cos(holder_angle_max) * dimensions[1]), 0]) rotate([90, 0, 90]) cylinder(r=radius, h=dimensions[0], center=true, $fn=24);
    }
  }
}

module holder() {
  rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_outer_width, center=true, $fn=24);

  rotate([-holder_angle_min, 0, 0]) {
    difference() {
      union() {
        hull() {
          rotate([-holder_angle_min / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
          translate([0, -2 * holder_connector_radius, -holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
          translate([0, -2 * holder_connector_radius, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
        }

        difference() {
          union() {
            translate([0, -2 * holder_connector_radius - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle_min) * 2 * holder_connector_radius]) cube([holder_width, holder_depth, holder_height], center=true);
            // bottom bit (todo)
            translate([0, -2 * holder_connector_radius - holder_depth / 2 + cos(holder_angle_min) * holder_depth / 2, -holder_connector_offset - sin(holder_angle_min) * 2 * holder_connector_radius + sin(holder_angle_min) * holder_depth / 2]) rotate([holder_angle_min, 0, 0]) translate([0, -holder_depth / 2+.28, 0]) cube([holder_width, cos(holder_angle_min) * holder_depth-.56, sin(holder_angle_min) * holder_depth], center=true);
            translate([0, -2 * holder_connector_radius - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle_min) * 2 * holder_connector_radius]) {
              hull() {
                // bottom bit (todo)
                translate([0, -holder_depth / 2, -(holder_height / 2 - holder_depth) - .56]) rotate([0, 90, 0]) cylinder(r=holder_depth, h=holder_width, center=true, $fn=24);
                translate([0, -holder_depth / 2, -(holder_height / 2 - 4 * holder_depth)]) rotate([0, 90, 0]) cylinder(r=holder_depth, h=holder_width, center=true, $fn=24);
              }
            }
          }

          translate([0, -2 * holder_connector_radius, holder_height / 2 - holder_connector_offset - sin(holder_angle_min) * 2 * holder_connector_radius]) cube([holder_width + shift, 2 * tolerance, holder_height + shift], center=true);
        }

        translate([0, -2 * holder_connector_radius - tolerance, holder_height - holder_connector_offset - sin(holder_angle_min) * 2 * holder_connector_radius - (holder_depth - tolerance)]) rotate([0, 90, 0]) cylinder(r=holder_depth - tolerance, h=holder_width, center=true, $fn=24);
      }

      translate([0, -2 * holder_connector_radius - holder_depth / 2, holder_height / 2 - holder_connector_offset - sin(holder_angle_min) * 2 * holder_connector_radius]) {
        translate([0, -holder_edge + tile_depth / 4, -holder_depth / 4]) cube([holder_width - 2 * holder_edge, holder_edge + tile_depth / 2, holder_height - 2 * holder_edge - holder_depth / 2], center=true);
        translate([0, -holder_depth / 2, holder_height / 2 - holder_edge - holder_depth / 2]) rotate([0, 90, 0]) cylinder(r=holder_depth / 2, h=holder_width - 2 * holder_edge, center=true, $fn=24);
        translate([0, -(holder_depth + shift), -holder_height / 2 + 2 * holder_depth + 4 * holder_edge]) cube([holder_width - 4 * holder_edge, holder_depth + shift, 4 * holder_depth], center=true);
        translate([holder_width / 2, 0, holder_height / 2]) rotate([90, 0, 0]) cylinder(r=2 * holder_width / 3, h=3 * holder_depth + shift, center=true, $fn=24);
        hull() {
          translate([-(holder_width / 2 - 3 * holder_edge), -(holder_depth + shift), -holder_height / 2 + 4 * holder_edge]) rotate([90, 0, 0]) cylinder(r=holder_edge, h=holder_depth + shift, center=true, $fn=24);
          translate([(holder_width / 2 - 3 * holder_edge), -(holder_depth + shift), -holder_height / 2 + 4 * holder_edge]) rotate([90, 0, 0]) cylinder(r=holder_edge, h=holder_depth + shift, center=true, $fn=24);
        }
      }
    }
  }
}
