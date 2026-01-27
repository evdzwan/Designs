tolerance = .2;

tile_count = 3;
tile_radius = 2;
tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_width = tile_width + holder_edge * 2 + tolerance * 4;
holder_height = tile_height + holder_edge * 2 + tolerance * 4;
holder_depth = tile_depth + holder_edge * 2 + tolerance * 4;

base_spacing = 1;
base_height = 10;
base_depth = 30;
base_width = tile_count * (holder_width + base_spacing) - base_spacing;

color("olive") base();
for (i = [0:tile_count - 1]) {
  translate([i * (holder_width + base_spacing), 0, 0]) color("magenta") holder(-10 - (i * 90) / max(tile_count - 1, 1));
}

module base() {
  difference() {
    rotate([90, 0, 90]) {
      linear_extrude(base_width) {
        polygon(
          [
            [base_depth / 10 + tolerance, 0],
            [base_depth / 6, base_height - tolerance],
            [base_depth, base_height / 2 + 2 * tolerance],
            [base_depth, 0],
          ]
        );
      }
    }

    for (i = [0:tile_count - 1]) {
      translate([i * (holder_width + base_spacing) + holder_width / 2, base_depth / 6, base_height - tolerance]) rotate([-10, 0, 0]) cube([holder_width, 4, 4], center=true);
    }
  }
}

module holder(angle) {
  translate([0, holder_depth + 1.5, base_height - 1.5]) {
    rotate([angle, 0, 0]) {
      translate([0, -(holder_depth + 1.5), -(base_height - 1.5)]) {
        difference() {
          cube([holder_width, holder_depth, holder_height]);
          translate([holder_edge, -holder_edge, holder_edge]) cube([holder_width - 2 * holder_edge, holder_depth, holder_height]);
        }

        translate([-.5, 0, 0]) {
          translate([holder_width / 2 - 1, holder_depth, base_height - 2]) cube([1, 2, 1]);
          translate([holder_width / 2 - 2, holder_depth + 1, base_height - 2]) cube([1, 1, 1]);

          translate([holder_width / 2 + 1, holder_depth, base_height - 2]) cube([1, 2, 1]);
          translate([holder_width / 2 + 2, holder_depth + 1, base_height - 2]) cube([1, 1, 1]);
        }
      }
    }
  }
}
