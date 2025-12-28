$fn = 50;

height = 5;
radius = 2.4;

difference() {
  rotate_extrude() {
    polygon(
      [
        [0, 0],
        [radius + .6, 0],
        [radius + 1, .4],
        [radius + 1, height - .4],
        [radius + .6, height],
        [0, height],
      ]
    );
  }
  cylinder(r=radius - .2, h=height);
}
