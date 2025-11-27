module renderClip(height) {
  // bottom left curve
  translate([2, 2, 0]) {
    rotate([0, 0, 90]) {
      rotate_extrude(angle=180) {
        translate([1, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // top left curve
  translate([2, 7, 0]) {
    rotate([0, 0, 90]) {
      rotate_extrude(angle=180) {
        translate([1, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // bottom outer straight
  translate([2, 0, 0]) {
    cube([10, 1, height]);
  }

  // bottom inner straight
  translate([2, 3, 0]) {
    cube([10, 1, height]);
  }

  // bottom inner curve
  translate([12, 3.5, 0]) {
    cylinder(h=height, r=.5);
  }

  // top outer straight
  translate([2, 8, 0]) {
    cube([10, 1, height]);
  }

  // top inner straight
  translate([2, 5, 0]) {
    cube([10, 1, height]);
  }

  // top inner curve
  translate([12, 5.5, 0]) {
    cylinder(h=height, r=.5);
  }

  // middle outer curve
  translate([12, 4.5, 0]) {
    rotate([0, 0, 270]) {
      rotate_extrude(angle=180) {
        translate([3.5, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // handle bottom outer straight
  translate([12, 0, 0]) {
    cube([10, 1, height]);
  }

  // handle bottom inner straight
  translate([15.5, 2, 0]) {
    cube([6.5, 1, height]);
  }

  // handle top outer straight
  translate([12, 8, 0]) {
    cube([10, 1, height]);
  }

  // handle top inner straight
  translate([15.5, 6, 0]) {
    cube([6.5, 1, height]);
  }

  // bottom reinforcement curve
  translate([19, 1.5, 0]) {
    rotate([0, 0, 270]) {
      rotate_extrude(angle=180) {
        translate([.5, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // bottom right curve
  translate([22, 1.5, 0]) {
    rotate([0, 0, 270]) {
      rotate_extrude(angle=180) {
        translate([.5, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // top reinforcement curve
  translate([19, 7.5, 0]) {
    rotate([0, 0, 270]) {
      rotate_extrude(angle=180) {
        translate([.5, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // top right curve
  translate([22, 7.5, 0]) {
    rotate([0, 0, 270]) {
      rotate_extrude(angle=180) {
        translate([.5, 0, 0]) {
          square([1, height]);
        }
      }
    }
  }

  // bottom grip
  union() {
    for (i = [0:4]) {
      translate([3 + i * 2, 4, 0]) {
        cylinder(h=height, r=.5);
      }
    }
  }

  // top grip
  union() {
    for (i = [0:3]) {
      translate([4 + i * 2, 5, 0]) {
        cylinder(h=height, r=.5);
      }
    }
  }

  // bottom handle grip
  union() {
    for (i = [0:3]) {
      translate([21 - i, 0, 0]) {
        cylinder(h=height, r=.25);
      }
    }
  }

  // top handle grip
  union() {
    for (i = [0:3]) {
      translate([21 - i, 9, 0]) {
        cylinder(h=height, r=.25);
      }
    }
  }
}
