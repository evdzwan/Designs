include <../text.scad>
$fn = 50;

width = 60;
height = 40;

rotate([90, 0, 0]) {
  difference() {
    rotate([-90, 0, 0]) {
      cylinder(h=width, d=6);
    }

    rotate([-90, 0, 0]) {
      cylinder(h=width, d=2);
    }

    translate([-1, 0, 0]) {
      cube([2, width, 3]);
    }
  }

  translate([-3, 0, 0]) {
    cube([2, width, height]);
  }

  translate([-13, 0, height]) {
    difference() {
      rotate([-90, 0, 0]) {
        cylinder(h=width, d=24);
      }

      rotate([-90, 0, 0]) {
        cylinder(h=width, d=20);
      }

      translate([-10, 0, -12]) {
        cube([24, width, 12]);
      }
    }
  }

  translate([-25, 0, height - 10]) {
    cube([2, width, 10]);
  }

  translate([1, 0, 0]) {
    cube([2, width, 8]);
  }
}
