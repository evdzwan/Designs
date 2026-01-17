use <../shapes.scad>
use <magnet.scad>
use <logos.scad>
use <foot.scad>
use <tile.scad>

strip($fn=90);

module strip(tileSize = [50, 50, 8], tileSpacing = 8, tileInset = 2, tileCount = 4, radius = 8, logoOffset = 10) {
  size = [tileCount * (tileSize[0] + tileSpacing) + tileSpacing, tileSize[1] + tileSpacing * 2 + logoOffset, tileSize[2]];
  translate([-size[0] / 2, -size[1] / 2, 0]) {
    difference() {
      // base
      roundedCube(size, radius);

      // tiles
      for (i = [0:tileCount - 1]) {
        translate([i * (tileSize[0] + tileSpacing) + tileSize[0] / 2 + tileSpacing, tileSize[1] / 2 + tileSpacing, size[2] - tileInset]) {
          tileHole();

          // magnets
          translate([-(tileSize[0] / 2 - 8), -(tileSize[1] / 2 - 8), -(size[2] - tileInset) / 2]) magnetHole();
          translate([(tileSize[0] / 2 - 8), -(tileSize[1] / 2 - 8), -(size[2] - tileInset) / 2]) magnetHole();
        }
      }

      // feet
      translate([size[0] / 2, size[1] / 2, 0]) {
        for (y = [-1:1]) {
          if (y != 0) {
            for (x = [-1:1]) {
              if (x != 0) {
                translate([x * (size[0] / 2 - radius), y * (size[1] / 2 - radius), 0]) footHole();
              }
            }
          }
        }
      }
    }

    // logos
    translate([radius, size[1] - radius, size[2]]) geometricLogo();
    translate([size[0] / 2, size[1] - radius - (logoOffset - radius) / 2, size[2]]) textualLogo();
    translate([size[0] - radius, size[1] - radius, size[2]]) brandLogoPin();
  }
}
