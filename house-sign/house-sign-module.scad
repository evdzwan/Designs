module renderSign() {
  difference() {
    union() {
      renderFront();
      renderOffsets();
    }
    renderInsets();
  }
}

module renderFront() {
  linear_extrude(height=5) {
    difference() {
      translate([5, 5, 0]) {
        minkowski() {
          square([390, 150]);
          circle(r=5);
        }
      }

      translate([85, 80, 0]) text("3", font="Calibri", size=100, spacing=1.1, halign="center", valign="center");

      translate([160, 80, 0]) square([3, 120], center=true);

      translate([190, 120, 0]) text("Wytse", font="Calibri:style=Bold", size=20, spacing=1.1, valign="center");
      translate([190, 95, 0]) text("Ellen", font="Calibri:style=Bold", size=20, spacing=1.1, valign="center");
      translate([190, 70, 0]) text("Owen", font="Calibri:style=Bold", size=20, spacing=1.1, valign="center");

      translate([190, 30, 0]) text("Posthumus & Sprenkeling", font="Calibri", size=10, spacing=1.1, valign="center");
    }
  }

  union() {
    translate([259.6, 122, 0]) cube([1, 10, 5]);
    translate([225.8, 95, 0]) cube([1, 10, 5]);
    translate([198.8, 70, 0]) cube([1, 10, 5]);
    translate([238.8, 70, 0]) cube([1, 10, 5]);
    translate([193, 32, 0]) cube([1, 10, 5]);
    translate([200.4, 31, 0]) cube([1, 10, 5]);
    translate([264, 33, 0]) cube([1, 10, 5]);
    translate([264, 18, 0]) cube([1, 10, 5]);
    translate([284.2, 31, 0]) cube([1, 10, 5]);
    translate([296.8, 31, 0]) cube([1, 10, 5]);
    translate([318.4, 31, 0]) cube([1, 10, 5]);
    translate([340, 31, 0]) cube([1, 10, 5]);
    translate([340, 16, 0]) cube([1, 10, 5]);
  }
}

module renderOffsets() {
  for (y = [0:1]) {
    for (x = [0:1]) {
      translate([20 + x * 360, 20 + y * 120, -5]) cylinder(r=8, h=5);
    }
  }
}

module renderInsets() {
  for (y = [0:1]) {
    for (x = [0:1]) {
      translate([20 + x * 360, 20 + y * 120, -5]) {
        cylinder(r=3, h=6);
        translate([0, 0, 6]) cylinder(r1=3, r2=5, h=2);
        translate([0, 0, 8]) cylinder(r=5, h=2);
      }
    }
  }
}
