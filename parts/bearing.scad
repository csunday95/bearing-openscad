include <inner_race.scad>
include <cage.scad>
include <outer_race.scad>

$fa = 0.01;
$fs = 0.01;

id = 5;
od = 6;
height = 4;
lip_thickness = 0.4;
lip_depth = 0.5;
roller_radius = 1;
roller_margin = 0.3;
roller_count = 16;
cage_thickness = 0.5;
part = "inner_race"; // ["all", "inner_race", "rollers", "cage", "outer_race"]

if (part == "inner_race" || part == "all") {
    inner_race(height, id, od, lip_thickness, lip_depth);
}

if (part == "rollers" || part == "all") {
    for (a=[0:360/roller_count:360]) {
      rotate([0, 0, a])
        translate([od + roller_radius - lip_depth, 0, 0])
          cylinder(h=(height - lip_thickness * 2 - roller_margin * 2), r=   roller_radius, center=true);
    }
}

if (part == "cage" || part == "all") {
    cage(od + roller_radius / 2 - cage_thickness / 2, height, cage_thickness, roller_margin + lip_thickness, roller_radius * 2, roller_count);
}

if (part == "outer_race" || part == "all") {
    outer_race(height, od + roller_radius * 2 - lip_depth * 2, od + 2, lip_thickness, lip_depth);
}
  