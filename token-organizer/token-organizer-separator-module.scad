module renderSeparator(boxSizeX, boxSizeY, boxSizeZ, boxRadius, spacing) {
  sizeX = sqrt((boxSizeX - boxRadius * 2) * (boxSizeX - boxRadius * 2) + (boxSizeY - boxRadius * 2) * (boxSizeY - boxRadius * 2));
  sizeY = 2;
  sizeZ = boxSizeZ - boxRadius / 2 - spacing;

  insetSizeX = sizeY;
  insetSizeY = sizeY;
  insetSizeZ = sizeZ / 2;

  translate([0, 0, (sizeZ + boxRadius) / 2]) {
    difference() {
      cube([sizeX, sizeY, sizeZ], center=true);
      translate([0, 0, insetSizeZ / 2]) {
        cube([insetSizeX + spacing * 2, insetSizeY + spacing * 2, insetSizeZ + spacing], center=true);
      }
    }

    difference() {
      union() {
        translate([-sizeX / 2, 0, 0]) {
          cylinder(h=sizeZ, r=boxRadius, center=true);
        }

        translate([sizeX / 2, 0, 0]) {
          cylinder(h=sizeZ, r=boxRadius, center=true);
        }
      }

      rotate([0, 0, 45]) {
        difference() {
          cube([boxSizeX, boxSizeY, boxSizeZ], center=true);

          translate([0, 0, boxRadius / 2]) {
            scale([.895, .895, 1]) {
              minkowski() {
                cube([boxSizeX - boxRadius * 2, boxSizeY - boxRadius * 2, boxSizeZ], center=true);
                sphere(r=boxRadius);
              }
            }
          }
        }
      }
    }
  }
}
