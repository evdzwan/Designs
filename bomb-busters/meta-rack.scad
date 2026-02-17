shift = 1;

holder_count = 5;
holder_angle_min = 10;
holder_angle_max = 100;
holder_connector_inner_width = 8;
holder_connector_outer_width = 12;
holder_connector_radius = 2;
holder_width = 22;
holder_height = 60;
holder_depth = 2;

base_radius = 4;
base_spacing = 4;
base_width = holder_count * (holder_width + base_spacing);
base_height = 10;
base_depth = 40;

*color("teal") base();
color("olive") {
  for (i = [0:holder_count - 1]) {
    translate([(i + .5) * (holder_width + base_spacing), 0, base_height * cos(holder_angle_min)]) rotate([i * -(holder_angle_max - holder_angle_min) / max(holder_count - 1, 1), 0, 0]) holder();
  }
}

module base() {
  difference() {
    union() {
      translate([base_width / 2, 0, 0]) {
        difference() {
          base_hull([base_width, base_depth, base_height], base_radius);
          base_hull([base_width + shift, base_depth, base_height], base_radius / 2);
          translate([0, base_depth / 2, -(base_radius + shift) / 2]) cube([base_width + shift, base_depth + 3 * base_radius + shift, base_radius + shift], center=true);
        }
      }

      translate([0, 0, base_height * cos(holder_angle_min)]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=24);
    }

    for (i = [0:holder_count - 1]) {
      translate([(i + .5) * (holder_width + base_spacing), 0, base_height * cos(holder_angle_min)]) rotate([0, 90, 0]) cylinder(r=3 * holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
      translate([(i + .5) * (holder_width + base_spacing), 0, base_height * cos(holder_angle_min)]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_outer_width, center=true, $fn=24);
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
  rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_outer_width + base_spacing, center=true, $fn=24);

  rotate([-holder_angle_min, 0, 0]) {
    hull() {
      rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
      translate([0, -2 * holder_connector_radius, -holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
      translate([0, -2 * holder_connector_radius, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=holder_connector_inner_width, center=true, $fn=24);
    }

    translate([0, -2 * holder_connector_radius - holder_depth / 2, holder_height / 2 - base_height - sin(holder_angle_min) * 2 * holder_connector_radius]) cube([holder_width, holder_depth, holder_height], center=true);
  }
}
