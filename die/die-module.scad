include <../text.scad>

module renderDie(size) {
  inset = size / 8;
  hole = size / 8;

  translate([-inset, -inset, -inset]) {
    // body
    difference() {
      // main
      translate([size / 2, size / 2, size / 2]) {
        sphere(d=size);
      }

      // side cut-outs
      union() {
        // front cut-out
        translate([0, 0, 0]) {
          cube([size, inset, size]);
        }

        // back cut-out
        translate([0, size - inset, 0]) {
          cube([size, inset, size]);
        }

        // left cut-out
        translate([0, 0, 0]) {
          cube([inset, size, size]);
        }

        // right cut-out
        translate([size - inset, 0, 0]) {
          cube([inset, size, size]);
        }

        // bottom cut-out
        translate([0, 0, 0]) {
          cube([size, size, inset]);
        }

        // top cut-out
        translate([0, 0, size - inset]) {
          cube([size, size, inset]);
        }
      }

      // number cutouts
      union() {
        // front (1)
        translate([size / 2, inset, size / 2]) {
          for (x = [-1:1]) {
            for (y = [-1:1]) {
              if (x == 0 && y == 0) {
                translate([x * size / 6, 0, y * size / 6]) {
                  sphere(d=hole);
                }
              }
            }
          }
        }

        // back (6)
        translate([size / 2, size - inset, size / 2]) {
          for (x = [-1:1]) {
            for (y = [-1:1]) {
              if (x != 0) {
                translate([x * size / 6, 0, y * size / 6]) {
                  sphere(d=hole);
                }
              }
            }
          }
        }

        // left (5)
        translate([inset, size / 2, size / 2]) {
          for (x = [-1:1]) {
            for (y = [-1:1]) {
              if ( (x == 0 && y == 0) || (x != 0 && y != 0)) {
                translate([0, x * size / 6, y * size / 6]) {
                  sphere(d=hole);
                }
              }
            }
          }
        }

        // right (2)
        translate([size - inset, size / 2, size / 2]) {
          for (x = [-1:1]) {
            for (y = [-1:1]) {
              if ( (x == -1 && y == -1) || (x == 1 && y == 1)) {
                translate([0, x * size / 6, y * size / 6]) {
                  sphere(d=hole);
                }
              }
            }
          }
        }

        // bottom (4)
        translate([size / 2, size / 2, inset]) {
          for (x = [-1:1]) {
            for (y = [-1:1]) {
              if (x != 0 && y != 0) {
                translate([x * size / 6, y * size / 6, 0]) {
                  sphere(d=hole);
                }
              }
            }
          }
        }

        // top (3)
        translate([size / 2, size / 2, size - inset]) {
          for (x = [-1:1]) {
            for (y = [-1:1]) {
              if (x == y) {
                translate([x * size / 6, y * size / 6, 0]) {
                  sphere(d=hole);
                }
              }
            }
          }
        }
      }

      // logo
      translate([size * (2 / 3), inset + .2, size * (1 / 3)]) {
        rotate([90, 0, 0]) {
          logo(size=1, thickness=.4);
        }
      }
    }
  }
}
