use <../shapes.scad>
use <tile.scad>

holder();

module holder() {
  tile = tileSize();
  tileSpacing = 1;
  indent = 1.6;
  edge = 2;

  translate([0, -4, -6.93]) {
    rotate([90, 0, 0]) {
      difference() {
        union() {
          roundedCube([tile[0] + tileSpacing + edge * 2, tile[1] + tileSpacing + edge * 2, tile[2] + tileSpacing + edge * 2], radius=2, $fn=4);
          intersection() {
            translate([0, 6.93, -4]) rotate([0, 90, 0]) cylinder(r=8, h=tile[0] + tileSpacing + edge * 2, $fn=6);
            translate([0, 0, -2 * 8]) roundedCube([tile[0] + tileSpacing + edge * 2, tile[1] + tileSpacing + edge * 2, 2 * 8], radius=2, $fn=4);
          }
        }

        translate([edge, edge, edge]) cube([tile[0] + tileSpacing, tile[1] + tileSpacing, tile[2] + tileSpacing]);
        translate([edge * 2, edge * 2, edge]) cube([tile[0] + tileSpacing - edge * 2, tile[1] + tileSpacing - edge * 2, tile[2] + tileSpacing + edge + 1]);
        translate([-.5, 2 * (tile[1] + tileSpacing + edge * 2) / 5, tile[2] + tileSpacing + edge / 2]) cube([tile[0] + tileSpacing + edge * 2 + 1, 3 * (tile[1] + tileSpacing + edge * 2) / 5 + 1, edge * 1.5 + 1]);
        translate([tile[0] + tileSpacing + edge * 2, tile[1] + tileSpacing + edge * 2, -.5]) cylinder(r=tile[0] - edge, h=tile[2] + tileSpacing + edge * 2 + 1, $fn=50);
        translate([-.5, 6.93, -4]) rotate([90, 0, 90]) cylinder(r=6, h=tile[0] + tileSpacing + edge * 2 + 1, $fn=6);
        translate([-1, 6.93, -4]) rotate([90, 0, 90]) cylinder(r=6, h=indent + 1, $fn=50);
      }
    }
  }
}
