use <../shapes.scad>

*brandLogo($fn=90);
*brandLogoPin($fn=90);
*geometricLogo($fn=90);
textualLogo($fn=90);

module brandLogo(size = 8, height = .6, radius = 2, pinSize = 2, tolerance = .2) {
  difference() {
    union() {
      // e part
      translate([-(size - .4), .4, 0]) {
        rotate([0, 0, 5]) {
          difference() {
            translate([0, 0, height / 2]) roundedCube([size, size, height], radius, center=true);
            linear_extrude(height + 1) text("E", size=size / 2, font="Liberation Sans:style=Bold", halign="center", valign="center");
          }
        }
      }

      // z part
      rotate([0, 0, -20]) {
        difference() {
          translate([0, 0, height / 2]) roundedCube([size, size, height], radius, center=true);
          linear_extrude(height + 1) text("Z", size=size / 2, font="Liberation Sans:style=Bold", halign="center", valign="center");
        }
      }

      // games emboss
      translate([-size / 2, -(size / 2 + .4), height]) roundedCube([size * 2, size / 2, height * 2], radius, center=true);
    }

    // games cut-out
    translate([-size / 2, -(size / 2 + .4), 0]) linear_extrude(height * 2 + 1) text("GAMES", size=size / 4, font="Liberation Sans:style=Bold", spacing=1.3, halign="center", valign="center");

    // pin hole
    translate([-size / 2, -1, (height / 3 + tolerance) / 2]) cube([pinSize + tolerance, pinSize + tolerance, height / 3 + tolerance], center=true);
  }
}

module brandLogoPin(size = 8, height = .6, pinSize = 2) {
  translate([-size / 2, -1, (height / 3) / 2]) cube([pinSize, pinSize, height / 3], center=true);
}

module geometricLogo(size = [8, 8, .6], radius = 2) {
  difference() {
    // base
    translate([-size[0] / 8, -size[1] / 8 * 3, size[2] / 2]) {
      roundedCube(size, radius, center=true);
      translate([size[0] / 2, size[1] / 2, size[2] / 2]) roundedCube([size[0], size[1], size[2] * 2], radius, center=true);
    }
  }
}

module textualLogo(size = 10, height = .6) {
  linear_extrude(height) text("STORYTILES", size=size, halign="center", valign="center");
}
