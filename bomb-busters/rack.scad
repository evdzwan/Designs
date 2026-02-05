tolerance = .2;
shift = 1;

tile_count = 5;
tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_spacing = 1;
holder_width = tile_width + 2 * holder_edge + 2 * tolerance;
holder_height = tile_height + 2 * holder_edge + 2 * tolerance;
holder_depth = tile_depth + holder_edge + 2 * tolerance;

for (i = [0:tile_count - 1]) {
  angle = i * 90 / max(tile_count - 1, 1);
  rotate([angle, 0, 0]) {
    translate([holder_width / 2, holder_height / 2, holder_depth / 2]) {
      color("teal") translate([i * (holder_width + holder_spacing), 0, 0]) holder();
      color("cyan") translate([i * (holder_width + holder_spacing), 0, (holder_depth - tile_depth) / 2]) tile();
    }
  }
}

module holder() {
  difference() {
    cube([holder_width, holder_height, holder_depth], center=true);
    translate([0, 0, holder_edge / 2 + shift / 2]) cube([holder_width - 2 * holder_edge, holder_height - 2 * holder_edge, holder_depth - holder_edge + shift], center=true);
  }
}

module tile() {
  cube([tile_width, tile_height, tile_depth], center=true);
}

// tolerance = .2;
// shift = 1;

// tile_count = 5;
// tile_width = 14;
// tile_height = 45;
// tile_depth = 2;

// holder_edge = 1;
// holder_angle_min = 10;
// holder_angle_max = 100;
// holder_connector_offset = 10;
// holder_connector_inner_radius = 2;
// holder_connector_outer_radius = 4;
// holder_depth = tile_depth + 4 * holder_edge + 4 * tolerance;
// holder_width = tile_width + 2 * holder_edge + 4 * tolerance;
// holder_height = tile_height + 2 * holder_edge + 8 * tolerance;

// base_radius = 2;
// base_spacing = 2;
// base_depth = 20;
// base_width = tile_count * (holder_width + base_spacing);

// color("teal") base();
// color("magenta") {
//   for (i = [0:tile_count - 1]) {
//     if (i == 0)
//       translate([(i + .5) * (holder_width + base_spacing), sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([-holder_angle_min, 0, 0]) holder();
//   }
// }

// module base() {
//   difference() {
//     hull() {
//       rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=6);
//       translate([0, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=6);
//       translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=6);
//       translate([0, base_depth, 0]) rotate([0, 90, 0]) cylinder(r=base_radius, h=base_width, $fn=6);
//     }

//     translate([-shift / 2, -base_radius - shift / 2, -base_radius - shift]) cube([base_width + shift, base_depth + 2 * base_radius + shift, base_radius + shift]);
//     for (i = [0:tile_count - 1]) {
//       translate([(i + .5) * (holder_width + base_spacing), sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([0, 90, 0]) cylinder(r=3 * holder_connector_outer_radius / 2, h=holder_width + 2 * tolerance, center=true, $fn=6);
//     }
//   }
// }

// module holder() {
//   rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=holder_width, center=true, $fn=6);
//   translate([0, -holder_depth / 2, holder_height / 2 - holder_connector_offset]) cube([holder_width, holder_depth, holder_height], center=true);
// }

// tolerance = .2;
// shift = 1;

// tile_count = 2;
// tile_width = 14;
// tile_height = 45;
// tile_depth = 2;

// holder_edge = 1;
// holder_width = tile_width + 2 * holder_edge + 4 * tolerance;
// holder_height = tile_height + 2 * holder_edge + 8 * tolerance;
// holder_depth = tile_depth + 4 * holder_edge + 4 * tolerance;
// holder_connector_inner_radius = 2;
// holder_connector_outer_radius = 4;
// holder_angle_min = 10;
// holder_angle_max = 100;
// holder_spacing = 2;

// base_edge = 1;
// base_width = tile_count * (holder_width + holder_spacing) - holder_spacing + 2 * base_edge;
// base_depth = (holder_height - holder_connector_outer_radius) * cos(holder_angle_min);
// base_link = 2;
// base_foot = 1.6;

// color("teal") base();
// color("magenta") {
//   for (i = [0:tile_count - 1]) {
//     angle = holder_angle_min; // + i * (holder_angle_max - holder_angle_min) / max(tile_count - 1, 1);
//     translate([base_edge + i * (holder_width + holder_spacing) + holder_width / 2, 0, 2 * holder_connector_outer_radius * cos(holder_angle_min)]) rotate([-angle, 0, 0]) holder();
//   }
// }

// module base() {
//   translate([0, 0, 2 * holder_connector_outer_radius * cos(holder_angle_min)]) {
//     rotate([0, 90, 0]) cylinder(r=holder_connector_inner_radius - tolerance / 2, h=base_width, $fn=6);
//     difference() {
//       hull() {
//         rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=base_width, $fn=6);
//         translate([0, 0, -2 * holder_connector_outer_radius * cos(holder_angle_min) + holder_connector_outer_radius]) rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=base_width, $fn=6);
//         translate([0, base_depth, -2 * holder_connector_outer_radius * cos(holder_angle_min)]) rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=base_width, $fn=6);
//       }

//       translate([-shift / 2, 0, -2 * holder_connector_outer_radius * cos(holder_angle_min) - holder_connector_outer_radius - shift]) cube([base_width + shift, base_depth + holder_connector_outer_radius, holder_connector_outer_radius + shift]);
//       for (i = [0:tile_count - 1]) {
//         translate([base_edge + i * (holder_width + holder_spacing) + holder_width / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r=2 * holder_connector_outer_radius - 3 * tolerance, h=holder_width + 2 * tolerance, center=true);
//       }

//       for (i = [0:tile_count - 1]) {
//         rotate([-100, 0, 0]) translate([base_edge + i * (holder_width + holder_spacing) + holder_width / 2, -holder_depth / 2, holder_height / 2 - 2 * holder_connector_outer_radius]) cube([holder_width + 2 * tolerance, holder_depth + 2 * tolerance, holder_height + 2 * tolerance], center=true);
//       }

//       translate([-shift / 2, base_depth + holder_connector_outer_radius / 2, -2 * holder_connector_outer_radius * cos(holder_angle_min) - shift]) cube([base_width + shift, holder_connector_outer_radius, holder_connector_outer_radius + shift]);
//       for (i = [0:tile_count - 1]) {
//         translate([base_edge + i * (holder_width + holder_spacing) + holder_width / 2, base_depth + (holder_connector_outer_radius / 2 + shift) / 2, -2 * holder_connector_outer_radius * cos(holder_angle_min) + holder_connector_outer_radius / 2 - shift]) cube([tile_width + 4 * tolerance, holder_connector_outer_radius + shift, 2 * holder_connector_outer_radius + shift], center=true);
//       }

//       translate([0, 0, -2 * holder_connector_outer_radius * cos(holder_angle_min)]) {
//         translate([base_depth / 4, 2 * base_depth / 10, -shift]) cylinder(r=2 * base_foot, h=base_foot / 2 + shift, $fn=24);
//         translate([base_depth / 4, 7 * base_depth / 10, -shift]) cylinder(r=2 * base_foot, h=base_foot / 2 + shift, $fn=24);
//       }

//       translate([base_width, 0, -2 * holder_connector_outer_radius * cos(holder_angle_min)]) {
//         translate([-base_depth / 4, 2 * base_depth / 10, -shift]) cylinder(r=2 * base_foot, h=base_foot / 2 + shift, $fn=24);
//         translate([-base_depth / 4, 7 * base_depth / 10, -shift]) cylinder(r=2 * base_foot, h=base_foot / 2 + shift, $fn=24);
//       }

//       translate([0, base_depth / 2, -2 * holder_connector_outer_radius * cos(holder_angle_min) - shift]) {
//         translate([-shift / 2, -(2 * base_link + 2 * tolerance) / 2, 0]) cube([base_link + shift, 2 * base_link + 2 * tolerance, base_link + tolerance + shift]);
//         translate([base_link - tolerance, -(3 * base_link + 2 * tolerance) / 2, 0]) cube([base_link + 2 * tolerance, 3 * base_link + 2 * tolerance, base_link + tolerance + shift]);
//       }
//     }

//     translate([base_width, base_depth / 2, -2 * holder_connector_outer_radius * cos(holder_angle_min)]) {
//       translate([-shift / 2, -2 * base_link / 2, 0]) cube([base_link + shift, 2 * base_link, base_link]);
//       translate([base_link, -3 * base_link / 2, 0]) cube([base_link, 3 * base_link, base_link]);
//     }
//   }
// }

// module holder() {
//   difference() {
//     union() {
//       difference() {
//         union() {
//           rotate([0, 90, 0]) cylinder(r=holder_connector_outer_radius, h=holder_width, center=true, $fn=6);
//           translate([0, -holder_depth / 2, holder_height / 2 - 2 * holder_connector_outer_radius]) cube([holder_width, holder_depth, holder_height], center=true);
//           translate([0, -holder_depth / 2, -2 * holder_connector_outer_radius]) rotate([holder_angle_min, 0, 0]) cube([holder_width, holder_depth * cos(holder_angle_min), holder_depth * sin(holder_angle_min)], center=true);
//         }

//         rotate([0, 90, 0]) cylinder(r=holder_connector_inner_radius + tolerance / 2, h=holder_width + shift, center=true, $fn=24);
//         translate([-holder_width / 2, -holder_depth, -2 * holder_connector_outer_radius]) {
//           translate([holder_edge, holder_edge, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth - 4 * holder_edge, holder_height - 2 * holder_edge]);
//           translate([-shift / 2, -shift, 4 * holder_connector_outer_radius]) cube([holder_width + shift, holder_depth - 4 * holder_edge + shift, holder_height - 4 * holder_connector_outer_radius + shift]);
//           translate([3 * holder_edge, -shift, 3 * holder_edge]) cube([holder_width - 6 * holder_edge, holder_depth - 4 * holder_edge + shift, 4 * holder_connector_outer_radius - 3 * holder_edge + shift]);
//         }
//       }

//       translate([-holder_width / 2, -holder_depth, -2 * holder_connector_outer_radius]) {
//         translate([0, holder_depth - 3 * holder_edge, holder_height - holder_edge]) {
//           rotate([0, 90, 0]) {
//             linear_extrude(holder_width) {
//               polygon(
//                 [
//                   [0, 0],
//                   [holder_edge, 0],
//                   [0, -holder_edge],
//                 ]
//               );
//             }
//           }
//         }
//       }
//     }

//     translate([-holder_width / 2, -holder_depth, -2 * holder_connector_outer_radius]) {
//       translate([holder_width, -shift / 2, holder_height]) rotate([0, 90, 90]) cylinder(r=2 * holder_width / 3, h=holder_depth + shift, $fn=24);
//     }
//   }
// }
