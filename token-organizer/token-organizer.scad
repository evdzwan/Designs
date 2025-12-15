include <token-organizer-box-module.scad>
include <token-organizer-separator-module.scad>
$fn = 50;

sizeX = 100;
sizeY = 100;
sizeZ = 30;
spacing = .4;
thickness = 2;
radius = 4;
inset = 4;

renderBox(sizeX, sizeY, sizeZ, radius, thickness, inset, spacing);
translate([sizeX / 2, sizeY / 2, inset + radius / 2]) rotate([0, 0, 45]) renderSeparator(sqrt(sizeX * sizeX + sizeY * sizeY), thickness, sizeZ - inset - spacing - radius / 2, radius, spacing);
translate([sizeX / 2, sizeY / 2, sizeZ - spacing]) rotate([0, 0, 315]) scale([1, 1, -1]) renderSeparator(sqrt(sizeX * sizeX + sizeY * sizeY), thickness, sizeZ - inset - spacing - radius / 2, radius, spacing);
