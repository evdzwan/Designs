include <const.scad>

foot();

module foot() {
  foot_offset = (cos(holder_angle) * base_depth + 2 * sin(holder_angle) * holder_connector_offset + 2 * base_radius - 4 * foot_radius) / 2;

  hull() {
    translate([foot_offset, 0, 0]) foot_node();
    translate([0, -foot_offset, 0]) foot_node();
  }
  
  hull() {
    translate([foot_offset, 0, 0]) foot_node();
    translate([0, foot_offset, 0]) foot_node();
  }
}

module foot_node() {
  intersection() {
    union() {
      cylinder(r=foot_radius, h=foot_height, $fn=24);
      translate([0, 0, -5.8]) sphere(r=2 * foot_radius, $fn=24);
    }

    cylinder(r=foot_radius, h=3 * foot_height, $fn=24);
  }
}
