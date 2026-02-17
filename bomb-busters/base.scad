include <const.scad>

base();

module base() {
  // connector rod
  translate([0, 0, base_rod_offset]) rotate([0, 90, 0]) cylinder(r=base_rod_radius, h=base_width, $fn=6);
  difference() {
    // body  
    cube([base_width, base_depth, base_height]);

    // link slot
    translate([3 * base_link / 4, base_depth / 2, base_height / 2]) scale(1 + tolerance / 4) link();

    // holder slots
    for (i = [0:holder_count - 1]) {
      translate([(i + .5) * (holder_width + base_spacing), 0, cos(holder_angle) * holder_connector_radius]) rotate([-holder_angle, 0, 0]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + 2 * tolerance, h=holder_width + 2 * tolerance, center=true, $fn=6);
    }

    // indicator slots
    for (i = [0:holder_count - 1]) {
      translate([(i + .5) * (holder_width + base_spacing), base_depth - base_slot / 2 + shift, base_height]) cube([tile_width + 4 * tolerance, base_slot + shift, 6 * tolerance], center=true);
    }

    // feet slots
    translate([2 * foot_radius, 2 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=24);
    translate([2 * foot_radius, base_depth - 2 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=24);
    translate([base_width - 2 * foot_radius, 2 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=24);
    translate([base_width - 2 * foot_radius, base_depth - 2 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=24);
  }

  // connector
  difference() {
    hull() {
      translate([0, 0, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=base_width, $fn=6);
      translate([0, base_rod_offset / 2, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=base_width, $fn=6);
      translate([0, 0, base_rod_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius, h=base_width, $fn=6);
    }

    // holder slots
    for (i = [0:holder_count - 1]) {
      hull() {
        translate([(i + .5) * (holder_width + base_spacing), 0, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + shift, h=holder_width + 2 * tolerance, center=true, $fn=6);
        translate([(i + .5) * (holder_width + base_spacing), base_rod_offset / 2, holder_connector_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + shift, h=holder_width + 2 * tolerance, center=true, $fn=6);
        translate([(i + .5) * (holder_width + base_spacing), 0, base_rod_offset]) rotate([0, 90, 0]) cylinder(r=holder_connector_radius + shift, h=holder_width + 2 * tolerance, center=true, $fn=6);
      }
    }
  }

  // link
  difference() {
    translate([base_width + 3 * base_link / 4, base_depth / 2, base_height / 2]) link();
    translate([base_width + base_link / 2 + base_spacing / 2, base_depth / 2, base_height]) cube([base_link, base_link + shift, 6 * tolerance], center=true);
  }
}

module link() {
  translate([-base_link / 4, 0, 0]) {
    // neck
    cube([base_link, base_link / 2, base_height], center=true);

    // head
    hull() {
      translate([base_link / 4, -base_link / 4, 0]) cylinder(d=base_link / 2, h=base_height, center=true, $fn=24);
      translate([base_link / 4, base_link / 4, 0]) cylinder(d=base_link / 2, h=base_height, center=true, $fn=24);
    }
  }
}
