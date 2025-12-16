include <token-organizer-separator-module.scad>
$fn = 50;

sizeX = 100;
sizeY = 100;
sizeZ = 30;
spacing = .4;
thickness = 2;
radius = 4;
inset = 4;

renderSeparator(sqrt(sizeX * sizeX + sizeY * sizeY), thickness, sizeZ - inset - spacing - radius / 2 + radius / 4, radius, spacing);
