magnet($fn=90);
*magnetHole($fn=90);

module magnet(diameter = 6, height = 3) {
  cylinder(d=diameter, h=height);
}

module magnetHole(diameter = 6, height = 3, tolerance = .2) {
  cylinder(d=diameter + tolerance, h=height, center=true);
}
