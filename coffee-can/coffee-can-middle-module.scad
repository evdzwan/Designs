module renderMiddle(radius, height, inset, border) {
  indent = 2;

  union() {
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
          [radius, height * 2],
          [radius - border / 2, height * 2],
          [radius - border, height * 2 - border / 2],

          [radius - border, height * 2 - border / 2 - inset],
          [radius - border + indent, height * 2 - border / 2 - inset - indent],
          [radius - border + indent, height * 2 - border / 2 - inset - indent * 2],
          [radius - border, height * 2 - border / 2 - inset - indent * 3],

          [radius - border, height + border + border / 2],
          [radius - border - border / 2, height + border],
          [radius - border * 2, height + border],
        ]
      );
    }
  }
}
