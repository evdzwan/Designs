module renderSeparator(size, height, bottom, thickness, radius, insetHeight) {
  availableSize = size - radius * 2;
  separatorHeight = height - bottom - insetHeight;
  separatorLength = sqrt(availableSize * availableSize + availableSize * availableSize);
  spacing = .4;
  chamfer = 1;

  scale([.9, .9, 1]) {
    difference() {
      union() {
        cube([separatorLength + radius, thickness, separatorHeight - spacing], center=true);

        for (x = [-1:1]) {
          if (x != 0) {
            translate([x * separatorLength / 2, 0, -(separatorHeight - spacing) / 2]) {
              rotate([0, 0, x * -90]) {
                rotate_extrude(angle=180) {
                  polygon(
                    [
                      [0, 0],
                      [radius - spacing - chamfer, 0],
                      [radius - spacing, chamfer],
                      [radius - spacing, separatorHeight - spacing - chamfer],
                      [radius - spacing - chamfer, separatorHeight - spacing],
                      [0, separatorHeight - spacing],
                    ]
                  );
                }
              }
            }
          }
        }
      }

      rotate([90, 0, 0]) {
        linear_extrude(height=thickness + 1, center=true) {
          polygon(
            [
              [-(thickness + spacing * 2) / 2, -spacing],
              [(thickness + spacing * 2) / 2, -spacing],
              [(thickness + spacing * 2) / 2, (separatorHeight - spacing) / 2 - chamfer],
              [(thickness + spacing * 2) / 2 + chamfer * 2, (separatorHeight - spacing) / 2 + chamfer],
              [-(thickness + spacing * 2) / 2 - chamfer * 2, (separatorHeight - spacing) / 2 + chamfer],
              [-(thickness + spacing * 2) / 2, (separatorHeight - spacing) / 2 - chamfer],
            ]
          );
        }
      }
    }
  }
}
