include <../shapes.scad>
$fn = 50;

// color("white") {
//   difference() {
//     roundedCube(size=[250, 125, 5], radius=5);

//     translate([25, 15, 0]) {
//       scale([.9, .9, 1]) {
//         translate([6.5, 0, 5]) scale([.4, .4, .2]) import("rest.stl");
//         translate([0, 21.15, 5]) scale([1.6, 1.6, .1]) import("bridge.stl");
//       }
//     }
//   }
// }

translate([25, 15, 5]) {
  scale([.9, .9, 1]) {
    color("lightgreen") translate([6.5, 0, 2.5]) scale([.4, .4, 1]) import("rest.stl");
    //color("orange") translate([0, 21.15, 5]) scale([1.6, 1.6, 1]) import("bridge.stl");
  }
}
