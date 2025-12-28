$fn = 50;

size = 5;
radius = 2.9;
length = size * 2 + 2;
chamfer = .6;

difference() {
  rotate_extrude() {
    polygon(
      [
        [0, 0],
        [radius + chamfer - .2, 0],
        [radius + chamfer, .2],
        [radius + chamfer, 1],
        [radius, 2],
        [radius, 3],
        [radius + chamfer, 4],
        [radius + chamfer, 5],
        [radius + chamfer * 2 - .2, 5],
        [radius + chamfer * 2, 5.2],
        [radius + chamfer * 2, length - 5.2],
        [radius + chamfer * 2 - .2, length - 5],
        [radius + chamfer, length - 5],
        [radius + chamfer, length - 4],
        [radius, length - 3],
        [radius, length - 2],
        [radius + chamfer, length - 1],
        [radius + chamfer, length - .2],
        [radius + chamfer - .2, length],
        [0, length],
      ]
    );
  }

  translate([0, 0, 0]) cube([(radius + chamfer) * 2, 1, 9], center=true);
  translate([0, 0, 4.5]) rotate([0, 90, 0]) cylinder(d=1, h=(radius + chamfer) * 2, center=true);
  translate([0, 0, length]) cube([(radius + chamfer) * 2, 1, 9], center=true);
  translate([0, 0, length - 4.5]) rotate([0, 90, 0]) cylinder(d=1, h=(radius + chamfer) * 2, center=true);
}
