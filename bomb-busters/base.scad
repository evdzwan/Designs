include <const.scad>

base();

module base() {
  difference() {
    union() {
      // main body
      hull() {
        translate([0, 0, cos(holder_angle) * holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, center=true, $fn=24);
        translate([0, -sin(holder_angle) * holder_connector_offset, 0]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, center=true, $fn=24);
        translate([0, cos(holder_angle) * base_depth, cos(holder_angle) * holder_connector_offset - sin(holder_angle) * base_depth]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, center=true, $fn=24);
        translate([0, cos(holder_angle) * base_depth + sin(holder_angle) * holder_connector_offset, 0]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, center=true, $fn=24);
      }

      // link
      translate([base_width / 2, cos(holder_angle) * base_depth / 2, 0]) {
        hull() {
          cylinder(r=link_radius, h=2 * link_height, center=true, $fn=24);
          translate([2 * link_radius, 0, 0]) cylinder(r=link_radius, h=2 * link_height, center=true, $fn=24);
        }

        hull() {
          translate([2 * link_radius, -link_radius, 0]) cylinder(r=link_radius, h=3 * link_height, center=true, $fn=24);
          translate([2 * link_radius, link_radius, 0]) cylinder(r=link_radius, h=3 * link_height, center=true, $fn=24);
        }
      }
    }

    // floor cut-out
    translate([0, cos(holder_angle) * base_depth / 2, -(base_radius + shift) / 2]) cube([base_width + 6 * link_radius + shift, cos(holder_angle) * base_depth + 2 * sin(holder_angle) * holder_connector_offset + 2 * base_radius + shift, base_radius + shift], center=true);

    // connector slots
    for (i = [0:tile_count - 1]) {
      translate([-base_width / 2 + (i + .5) * (holder_width + base_spacing), 0, cos(holder_angle) * holder_connector_offset]) {
        rotate([0, 90, 0]) cylinder(r=2 * base_radius + 4 * tolerance, h=holder_connector_width + 2 * tolerance, center=true, $fn=24);
        rotate([0, 90, 0]) cylinder(r=holder_connector_radius + 2 * tolerance, h=2 * holder_connector_width + 2 * tolerance, center=true, $fn=24);
      }
    }

    // indicator region
    hull() {
      translate([-(base_width / 2 - base_spacing), cos(holder_angle) * base_depth, cos(holder_angle) * holder_connector_offset - sin(holder_angle) * base_depth + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth / 2, center=true, $fn=24);
      translate([base_width / 2 - base_spacing, cos(holder_angle) * base_depth, cos(holder_angle) * holder_connector_offset - sin(holder_angle) * base_depth + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth / 2, center=true, $fn=24);
      translate([base_width / 2 - base_spacing, cos(holder_angle) * (base_depth - (indicator_height + 4 * tolerance + base_radius / 2)), cos(holder_angle) * holder_connector_offset - sin(holder_angle) * (base_depth - (indicator_height + 4 * tolerance + base_radius / 2)) + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth / 2, center=true, $fn=24);
      translate([-(base_width / 2 - base_spacing), cos(holder_angle) * (base_depth - (indicator_height + 4 * tolerance + base_radius / 2)), cos(holder_angle) * holder_connector_offset - sin(holder_angle) * (base_depth - (indicator_height + 4 * tolerance + base_radius / 2)) + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth / 2, center=true, $fn=24);
    }

    // indicator slots
    for (i = [0:tile_count - 1]) {
      translate([-base_width / 2 + (i + .5) * (holder_width + base_spacing), 0, 0]) {
        hull() {
          translate([-(indicator_width / 2 + 2 * tolerance), cos(holder_angle) * (base_depth - base_radius / 4), cos(holder_angle) * holder_connector_offset - sin(holder_angle) * (base_depth - base_radius / 4) + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth, center=true, $fn=24);
          translate([indicator_width / 2 + 2 * tolerance, cos(holder_angle) * (base_depth - base_radius / 4), cos(holder_angle) * holder_connector_offset - sin(holder_angle) * (base_depth - base_radius / 4) + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth, center=true, $fn=24);
          translate([indicator_width / 2 + 2 * tolerance, cos(holder_angle) * (base_depth - base_radius / 4 - (indicator_height + 4 * tolerance)), cos(holder_angle) * holder_connector_offset - sin(holder_angle) * (base_depth - base_radius / 4 - (indicator_height + 4 * tolerance)) + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth, center=true, $fn=24);
          translate([-(indicator_width / 2 + 2 * tolerance), cos(holder_angle) * (base_depth - base_radius / 4 - (indicator_height + 4 * tolerance)), cos(holder_angle) * holder_connector_offset - sin(holder_angle) * (base_depth - base_radius / 4 - (indicator_height + 4 * tolerance)) + base_radius]) rotate([-holder_angle, 0, 0]) cylinder(r=indicator_radius, h=indicator_depth, center=true, $fn=24);
        }
      }
    }

    // foot slots
    translate([0, cos(holder_angle) * base_depth / 2, 0]) {
      for (i = [-1:1]) {
        if (i != 0) {
          foot_offset = (cos(holder_angle) * base_depth + 2 * sin(holder_angle) * holder_connector_offset + 2 * base_radius - 4 * foot_radius) / 2;

          hull() {
            translate([i * (base_width / 2 - 2 * foot_radius - foot_offset), 0, 0]) cylinder(r=foot_radius + tolerance, h=2 * foot_height, center=true, $fn=24);
            translate([i * (base_width / 2 - 2 * foot_radius), -foot_offset, 0]) cylinder(r=foot_radius + tolerance, h=2 * foot_height, center=true, $fn=24);
          }

          hull() {
            translate([i * (base_width / 2 - 2 * foot_radius - foot_offset), 0, 0]) cylinder(r=foot_radius + tolerance, h=2 * foot_height, center=true, $fn=24);
            translate([i * (base_width / 2 - 2 * foot_radius), foot_offset, 0]) cylinder(r=foot_radius + tolerance, h=2 * foot_height, center=true, $fn=24);
          }
        }
      }
    }

    // link slot
    translate([-base_width / 2, cos(holder_angle) * base_depth / 2, 0]) {
      hull() {
        cylinder(r=link_radius + tolerance / 2, h=2 * link_height + tolerance, center=true, $fn=24);
        translate([2 * link_radius, 0, 0]) cylinder(r=link_radius + tolerance / 2, h=2 * link_height + tolerance, center=true, $fn=24);
      }

      hull() {
        translate([2 * link_radius, -link_radius, 0]) cylinder(r=link_radius + tolerance / 2, h=3 * link_height + tolerance, center=true, $fn=24);
        translate([2 * link_radius, link_radius, 0]) cylinder(r=link_radius + tolerance / 2, h=3 * link_height + tolerance, center=true, $fn=24);
      }
    }
  }
}
