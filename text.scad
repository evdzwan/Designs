module curveText(txt, radius, size, thickness) {
  spacing = size;
  for (i = [0:len(txt) - 1]) {
    char = str(txt[i]);
    angle = i * spacing - (len(txt) - 1) * spacing / 2;
    rotate([0, 0, angle]) {
      translate([radius, 0, 0]) {
        rotate([90, 0, 90]) {
          linear_extrude(thickness) {
            text(char, font="Liberation Sans:style=Bold", size=size, halign="center", valign="center");
          }
        }
      }
    }
  }
}
