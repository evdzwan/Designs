use <../shapes.scad>
use <magnet.scad>
use <logos.scad>
use <icon.scad>

tile($fn=90);
*tileHole($fn=90);

module tile(size = [50, 50, 6], radius = 8) {
  translate([0, 0, size[2] / 2]) {
    difference() {
      // base
      roundedCube(size, radius, center=true);

      // icon
      translate([0, 0, size[2] / 2]) iconHole();

      // logo
      translate([-(size[0] / 2 - radius), size[1] / 2 - radius, size[2] / 2]) scale([1, 1, -1]) geometricLogo();

      // magnets
      translate([-(size[0] / 2 - 8), -(size[1] / 2 - 8), 0]) magnetHole();
      translate([(size[0] / 2 - 8), (size[1] / 2 - 8), 0]) magnetHole();
    }
  }
}

module tileHole(size = [50, 50, 6], radius = 8, tolerance = .6) {
  translate([-(size[0] + tolerance) / 2, -(size[1] + tolerance) / 2, 0]) roundedCube([size[0] + tolerance, size[1] + tolerance, size[2]], radius);
}
