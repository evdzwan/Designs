module renderBox(sizeX, sizeY, sizeZ, radius, spacing) {
  separatorSizeX = sqrt((sizeX - radius * 2) * (sizeX - radius * 2) + (sizeY - radius * 2) * (sizeY - radius * 2));
  separatorSizeY = 2;
  separatorSizeZ = sizeZ + radius;

  translate([0, 0, sizeZ / 2 + radius]) {
    difference() {
      renderHull(sizeX, sizeY, sizeZ, radius);

      translate([0, 0, sizeZ]) {
        renderHull(sizeX, sizeY, sizeZ, radius);
      }

      translate([0, 0, sizeZ / 2]) {
        cube([sizeX + 1, sizeY + 1, radius], center=true);
      }

      translate([0, 0, radius / 2]) {
        scale([.9, .9, 1]) {
          renderHull(sizeX, sizeY, sizeZ, radius);
        }
      }

      translate([0, 0, 0]) {
        rotate([0, 0, 45]) {
          cube([separatorSizeX + spacing * 2, separatorSizeY + spacing * 2, separatorSizeZ], center=true);
        }
        rotate([0, 0, 315]) {
          cube([separatorSizeX + spacing * 2, separatorSizeY + spacing * 2, separatorSizeZ], center=true);
        }
      }
    }
  }
}

module renderHull(sizeX, sizeY, sizeZ, radius) {
  minkowski() {
    cube([sizeX - radius * 2, sizeY - radius * 2, sizeZ], center=true);
    sphere(r=radius);
  }
}
