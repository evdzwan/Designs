renderPeg(length=30, holeRadius=3.6, baseHeight=10, $fn=50);

module renderPeg(length, holeRadius, baseHeight) {
  spacerHeight = 2;
  radius = holeRadius - .1;
  height = length + baseHeight + spacerHeight;
  insetSize = 1.6;

  difference() {
    union() {
      cylinder(r=radius, h=height, $fn=6);
      translate([0, 0, baseHeight + spacerHeight / 2]) cube([radius * 2, radius * sqrt(3), spacerHeight], center=true);
    }

    translate([0, 0, baseHeight / 2 - .5]) cube([insetSize, radius * 2, baseHeight + 1], center=true);
  }
}
