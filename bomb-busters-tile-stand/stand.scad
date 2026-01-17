renderStand(tileWidth=15, tileCount=16, tileSpacing=3);

module renderStand(tileWidth, tileCount, tileSpacing, chamfer = 4) {
  difference() {
    translate([0, tileCount * (tileWidth + tileSpacing) + tileSpacing, 0]) {
      rotate([90, 0, 0]) {
        linear_extrude(height=tileCount * (tileWidth + tileSpacing) + tileSpacing) {
          polygon(
            [
              [0, 0],
              [tileWidth * 2 - chamfer * 2 + 1, 0],
              [tileWidth * 2 - chamfer * 2 + 1, chamfer * 2],
              [chamfer, tileWidth * 2 - chamfer],
              [0, tileWidth * 2 - chamfer],
            ]
          );
        }
      }
    }

    for (i = [0:tileCount - 1]) {
      translate([tileWidth - chamfer - 1, i * (tileWidth + tileSpacing) + tileSpacing + tileWidth / 2, tileWidth + chamfer]) {
        rotate([0, -25, 0]) {
          cube([tileWidth / 2, tileWidth, tileWidth * 2], center=true);
        }
      }

      translate([tileWidth, i * (tileWidth + tileSpacing) + tileSpacing + tileWidth / 2, tileWidth + chamfer * 2]) {
        rotate([0, -25, 0]) {
          cube([tileWidth / 2, tileWidth, tileWidth * 2], center=true);
        }
      }

      translate([0, i * (tileWidth + tileSpacing) + tileSpacing + tileWidth / 2, tileWidth / 2]) {
        rotate([0, -12.5, 0]) {
          cube([tileWidth / 2, tileWidth, tileWidth * 2], center=true);
        }
      }
    }
  }
}
