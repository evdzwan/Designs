include <const.scad>
use <../shapes.scad>
use <holder.scad>
use <link.scad>
use <rod.scad>

base();

module base() {
  difference() {
    // body
    intersection() {
      roundedCube([base_width, base_depth, base_height + base_rodoffset + rod_radius + base_rodspacing], radius=base_radius, $fn=4);
      difference() {
        union() {
          cube([base_width, base_depth, base_height]);
          hull() {
            translate([0, base_depth / 2, base_height + base_rodoffset]) rotate([0, 90, 0]) cylinder(r=rod_radius + base_rodspacing, h=base_width, $fn=50);
            translate([0, rod_radius, rod_radius]) rotate([0, 90, 0]) cylinder(r=rod_radius, h=base_width, $fn=50);
            translate([0, base_depth - rod_radius, base_height + base_rodoffset - 1]) rotate([0, 90, 0]) cylinder(r=rod_radius, h=base_width, $fn=50);
            translate([0, base_depth - rod_radius, rod_radius]) cube([base_width, rod_radius, rod_radius]);
          }
        }

        translate([base_edge / 2, base_depth / 2, base_height + base_rodoffset]) rotate([0, 90, 0]) cylinder(r=rod_radius, h=base_width - base_edge, $fn=6);
        translate([3 * base_edge / 4, base_depth / 2, base_height + base_rodoffset + rod_radius]) rotate([0, 90, 0]) cylinder(r=rod_radius, h=base_width - 1.5 * base_edge, $fn=6);
        translate([base_edge, base_edge, base_height]) cube([base_width - 2 * base_edge, base_depth - 2 * base_edge, base_rodoffset + rod_radius + base_rodspacing + shift]);
        translate([base_edge, base_edge / 2, base_height + base_edge]) rotate([-base_holderanglemin, 0, 0]) cube([base_width - base_edge * 2, base_edge, base_edge]);
        translate([base_edge, base_depth - base_edge, base_height + base_edge / 2 + base_rodoffset + tolerance]) rotate([-base_holderanglemin, 0, 0]) translate([0, -base_edge / 2, 0]) cube([base_width - base_edge * 2, base_edge * 2, base_edge]);
      }
    }

    // feet holes
    translate([3 * foot_radius, 3 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=50);
    translate([1.5 * foot_radius, base_depth - 1.5 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=50);
    translate([base_width - 3 * foot_radius, 3 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=50);
    translate([base_width - 1.5 * foot_radius, base_depth - 1.5 * foot_radius, -shift]) cylinder(r=foot_radius, h=foot_height + shift, $fn=50);

    // tile slots
    translate([base_edge + holder_edge + tolerance, 0, 0]) {
      for (i = [0:tile_count - 1]) {
        hull() {
          translate([i * holder_width, base_depth, 0]) rotate([0, 90, 0]) cylinder(d=base_indent, h=holder_width - 2 * holder_edge, $fn=6);
          translate([i * holder_width, base_depth, 8]) rotate([0, 90, 0]) cylinder(d=base_indent, h=holder_width - 2 * holder_edge, $fn=6);
          translate([i * holder_width, base_depth - base_indent * 1.5, 0]) cube([holder_width - 2 * holder_edge, base_indent, base_indent]);
        }
      }
    }
  }

  *parts();
}

module parts() {
  translate([base_edge / 2 + tolerance, base_depth / 2, base_height + base_rodoffset]) {
    color("magenta") rotate([90, 0, 0]) rod();
    translate([base_edge / 2, 0, 0]) {
      for (i = [0:tile_count - 1]) {
        rotate([-(base_holderanglemin + i * (base_holderanglemax - base_holderanglemin) / (tile_count - 1)), 0, 0]) {
          color("cyan") translate([i * holder_width + tolerance / 2, 0, 0]) rotate([0, 90, 0]) link();
          color("olive") translate([i * holder_width, 0, 0]) holder();
        }
      }
    }
  }
}
