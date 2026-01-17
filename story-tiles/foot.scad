foot($fn=90);
*footHole($fn=90);

module foot(diameter = 8, baseHeight = 1) {
  intersection() {
    translate([0, 0, -(diameter - baseHeight * 2)]) sphere(d=diameter * 2);
    cylinder(d=diameter, h=baseHeight * 2);
  }
}

module footHole(diameter = 8, baseHeight = 1, tolerance = .4) {
  cylinder(d=diameter + tolerance, h=baseHeight);
}
