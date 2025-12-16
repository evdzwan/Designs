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
