include <const.scad>
use <holder.scad>

$fn = 10;
color("teal") base();
*for (i = [0:holder_count - 1]) {
  holder_angle = holder_angle_min + (i / (holder_count - 1)) * (holder_angle_max - holder_angle_min);
  color("magenta") translate([i * (holder_width + 2 * tolerance) + holder_width / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([-holder_angle, 0, 0]) holder();
}

module base() {
  difference() {
    union() {
      // main body
      difference() {
        base_hull();
        translate([-base_scale_diff * base_width, base_scale_diff * (sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth)), 0]) scale([1 + 2 * base_scale_diff, 1 - 2 * base_scale_diff, 1 - 2 * base_scale_diff]) base_hull();
        translate([-shift / 2, -base_radius - shift / 2, -base_radius - shift]) cube([base_width + shift, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth) + 2 * base_radius + shift, base_radius + shift]);
      }

      // connector bar
      translate([0, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);

      // front foot
      rotate([90, 0, 90]) {
        linear_extrude(base_width) {
          polygon(
            [
              [-base_radius, 0],
              [-base_radius + 2 * base_foot / 3, 0],
              [-base_radius + sin(holder_angle_min) * base_foot, base_foot],
            ]
          );
        }
      }

      // rear foot
      translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth), 0]) {
        rotate([90, 0, 90]) {
          linear_extrude(base_width) {
            polygon(
              [
                [base_radius, 0],
                [base_radius - 2 * base_foot / 3, 0],
                [base_radius - sin(holder_angle_min) * base_foot, base_foot],
              ]
            );
          }
        }
      }
    }

    // connector slots
    for (i = [0:holder_count - 1]) {
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=holder_connector_radius + tolerance / 2, h=holder_connector_width + tolerance, center=true);
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (holder_connector_width + tolerance) / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) sphere(r=holder_connector_inset + tolerance);
      translate([i * (holder_width + 2 * tolerance) + holder_width / 2 + (holder_connector_width + tolerance) / 2, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) sphere(r=holder_connector_inset + tolerance);
    }

    // front foot slot
    translate([0, 0, -shift]) {
      hull() {
        translate([2 * foot_radius, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
        translate([2 * foot_radius + foot_width, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
      }

      hull() {
        translate([base_width - 2 * foot_radius, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
        translate([base_width - 2 * foot_radius - foot_width, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
      }
    }

    // read foot slot
    translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth), -shift]) {
      hull() {
        translate([2 * foot_radius, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
        translate([2 * foot_radius + foot_width, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
      }

      hull() {
        translate([base_width - 2 * foot_radius, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
        translate([base_width - 2 * foot_radius - foot_width, 0, 0]) cylinder(r=foot_radius, h=foot_inset + shift);
      }
    }
  }
}

module base_hull() {
  hull() {
    translate([0, 0, 0]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
    translate([0, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
    translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
    translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + sin(holder_angle_min) * (cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth), 0]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width);
  }
}

// module base() {
//   difference() {
//     // body
//     difference() {
//       base_hull();

//       scale([1 + base_scale_diff, 1 - base_scale_diff, 1 - base_scale_diff]) {
//         translate([-base_width * base_scale_diff / 2, (sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth) * base_scale_diff / 2, 0]) {
//           base_hull();
//         }
//       }

//       translate([-shift / 2, -base_radius, -2 * base_radius]) cube([base_width + shift, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth + 2 * base_radius, 2 * base_radius]);
//     }

//     // slots
//     for (i = [0:holder_count - 1]) {
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (2 + tolerance), sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=4, h=4 + 2 * tolerance);
//     }
//   }

//   for (i = [0:holder_count - 1]) {
//     hull() {
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (4 + tolerance), sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * 2.4, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * 2.4]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (4 + tolerance), sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * 2.2 - .2, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * 2.2 - 1.6]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//     }

//     hull() {
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (4 + tolerance), sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * 2.2 - .2, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * 2.2 - 1.6]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 - (4 + tolerance), sin(holder_angle_min) * 7, cos(holder_angle_min) * 7]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//     }

//     hull() {
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 + (2 + tolerance), sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * 2.4, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * 2.4]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 + (2 + tolerance), sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * 2.2 - .2, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * 2.2 - 1.6]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//     }

//     hull() {
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 + (2 + tolerance), sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * 2.2 - .2, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * 2.2 - 1.6]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//       translate([i * (holder_width + 2 * tolerance) + holder_width / 2 + (2 + tolerance), sin(holder_angle_min) * 7, cos(holder_angle_min) * 7]) rotate([90, 0, 90]) cylinder(d=base_radius, h=2, $fn=20);
//     }
//   }
// }

// module base_hull() {
//   hull() {
//     translate([0, 0, 0]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width, $fn=20);
//     translate([0, sin(holder_angle_min) * holder_connector_offset, cos(holder_angle_min) * holder_connector_offset]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width, $fn=20);
//     translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth, cos(holder_angle_min) * holder_connector_offset + cos(holder_angle_max) * base_depth]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width, $fn=20);
//     translate([0, sin(holder_angle_min) * holder_connector_offset + sin(holder_angle_max) * base_depth, 0]) rotate([90, 0, 90]) cylinder(r=base_radius, h=base_width, $fn=20);
//   }
// }
