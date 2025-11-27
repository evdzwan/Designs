include <../text.scad>

module renderTop(radius, height, inset, border) {
  top = height + 15;
  indent = 2;

  difference() {
    rotate_extrude() {
      polygon(
        [
          [radius - border * 2, 0],
          [radius - border * 2 + border / 2, 0],
          [radius - border, border / 2],
          [radius - border, height - border - border / 2 - inset],
          [radius - border + indent, height - border - border / 2 - inset - indent],
          [radius - border + indent, height - border - border / 2 - inset - indent * 2],
          [radius - border, height - border - border / 2 - inset - indent * 3],
          [radius - border, height - border - border / 2],
          [radius, height - border + border / 2],
          [radius, top - border],
          [radius - border, top],
          [0, top],
          [0, top - border],
          [radius - border - border / 2, top - border],
          [radius - border, top - border - border / 2],
          [radius - border, height],
          [radius - border * 2, height - border],
        ]
      );
    }

    translate([0, 0, height + 4]) {
      curveText("YOUR COFFEE", radius - 1, floor(radius / 20) + 2, 1.5);
    }
  }
}
