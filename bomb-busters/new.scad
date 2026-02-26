$fn = 50;

shift = 1;

angle = 15;
radius = 4;
width = 100;
height = 20;
depth = 40;
edge = radius / 2;

x = 0;
y = 1;
z = 2;

fb = [0, radius, 0];
ft0 = [0, fb[y] + sin(angle) * height, fb[z] + cos(angle) * height];
ft = [0, fb[y] + sin(angle) * (height - 2 * radius) + cos(angle) * 2 * radius, fb[z] + cos(angle) * (height - 2 * radius) - sin(angle) * 2 * radius];
rt = [0, ft0[y] + cos(angle) * depth, ft0[z] - sin(angle) * depth];
rb = [0, rt[y] + sin(angle) * rt[z], fb[z]];

fl0 = [0, fb[y] - cos(angle) * 1.5 * radius, fb[z] + sin(angle) * 1.5 * radius];
fl1 = [0, fl0[y], fl0[z]];
fl2 = [0, fl0[y] + sin(angle) * radius / 4, fl0[z] + cos(angle) * radius / 4];

rl0 = [0, rb[y] + cos(angle) * 1.5 * radius, rb[z] + sin(angle) * 1.5 * radius];
rl1 = [0, rl0[y], rl0[z]];
rl2 = [0, rl0[y] - sin(angle) * radius / 4, rl0[z] + cos(angle) * radius / 4];

tl0 = [0, rt[y] + sin(angle) * 1.5 * radius, rt[z] + cos(angle) * 1.5 * radius];
tl1 = [0, tl0[y], tl0[z]];
tl2 = [0, tl0[y] - cos(angle) * radius / 4, tl0[z] + sin(angle) * radius / 4];

difference() {
  union() {
    difference() {
      body();
      floorCutout();
    }

    frontLip();
    rearLip();
    topLip();
  }

  bodyHole();
}

module body() {
  hull() {
    translate(fb) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
    translate(ft) rotate([90, 0, 90]) cylinder(r=3 * radius, h=width, center=true);
    translate(rt) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
    translate(rb) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
  }
}

module bodyHole() {
  hull() {
    translate(fb) rotate([90, 0, 90]) cylinder(r=radius - edge, h=width + shift, center=true);
    translate(ft) rotate([90, 0, 90]) cylinder(r=3 * radius - edge, h=width + shift, center=true);
    translate(rt) rotate([90, 0, 90]) cylinder(r=radius - edge, h=width + shift, center=true);
    translate(rb) rotate([90, 0, 90]) cylinder(r=radius - edge, h=width + shift, center=true);
  }
}

module floorCutout() {
  translate([0, (rb[y] - fb[y] + 2 * radius) / 2, fb[z] - (radius + shift) / 2]) cube([width + shift, rb[y] - fb[y] + 2 * radius + shift, radius + shift], center=true);
}

module frontLip() {
  difference() {
    hull() {
      translate(fl1) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
      translate(fl2) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
    }

    hull() {
      translate(fl1) rotate([90, 0, 90]) cylinder(r=radius / 2, h=width + shift, center=true);
      translate(fl2) rotate([90, 0, 90]) cylinder(r=radius / 2, h=width + shift, center=true);
    }

    translate(fl2) rotate([-angle, 0, 0]) translate([0, 0, radius]) cube([width + shift, 2 * radius + shift, 2 * radius], center=true);
  }

  translate([fl2[x], fl2[y] - cos(angle) * .75 * radius, fl2[z] + sin(angle) * .75 * radius]) rotate([90, 0, 90]) cylinder(r=radius / 4, h=width, center=true);
}

module rearLip() {
  difference() {
    hull() {
      translate(rl1) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
      translate(rl2) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
    }

    hull() {
      translate(rl1) rotate([90, 0, 90]) cylinder(r=radius / 2, h=width + shift, center=true);
      translate(rl2) rotate([90, 0, 90]) cylinder(r=radius / 2, h=width + shift, center=true);
    }

    translate(rl2) rotate([angle, 0, 0]) translate([0, 0, radius]) cube([width + shift, 2 * radius + shift, 2 * radius], center=true);
  }

  translate([rl2[x], rl2[y] + cos(angle) * .75 * radius, rl2[z] + sin(angle) * .75 * radius]) rotate([90, 0, 90]) cylinder(r=radius / 4, h=width, center=true);
}

module topLip() {
  difference() {
    hull() {
      translate(tl1) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
      translate(tl2) rotate([90, 0, 90]) cylinder(r=radius, h=width, center=true);
    }

    hull() {
      translate(tl1) rotate([90, 0, 90]) cylinder(r=radius / 2, h=width + shift, center=true);
      translate(tl2) rotate([90, 0, 90]) cylinder(r=radius / 2, h=width + shift, center=true);
    }

    translate(tl2) rotate([90 - angle, 0, 0]) translate([0, 0, radius]) cube([width + shift, 2 * radius + shift, 2 * radius], center=true);
  }

  translate([tl2[x], tl2[y] + sin(angle) * .75 * radius, tl2[z] + cos(angle) * .75 * radius]) rotate([90, 0, 90]) cylinder(r=radius / 4, h=width, center=true);
}
