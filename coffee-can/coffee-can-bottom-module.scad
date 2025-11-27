include <../text.scad>

module renderBottom(radius, height, inset, border) {
  indent = 2;

  difference() {
    rotate_extrude() {
      polygon(
        [
          [0, 0],
          [radius - border, 0],
          [radius, border],
          [radius, height],
          [radius - border / 2, height],
          [radius - border, height - border / 2],
          [radius - border, height - border / 2 - inset],
          [radius - border + indent, height - border / 2 - inset - indent],
          [radius - border + indent, height - border / 2 - inset - indent * 2],
          [radius - border, height - border / 2 - inset - indent * 3],
          [radius - border, border + border / 2],
          [radius - border - border / 2, border],
          [0, border],
        ]
      );
    }

    translate([0, 0, height / 2]) {
      curveText("STORED WITH LOVE", radius - 1, floor(radius / 20) + 2, 1.5);
    }

    translate([0, 0, border - 1]) {
      rotate([0, 0, 90]) {
        linear_extrude(2) {
          text("EZ", font="Liberation Sans:style=Bold", size=5, spacing=1.2, halign="center", valign="center");
        }
      }
    }
  }
}
