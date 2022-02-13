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
outer_bound = od + roller_radius * 2;

translate([outer_bound, outer_bound, 0])
    inner_race(height, id, od, lip_thickness, lip_depth);

translate([-outer_bound, outer_bound, 0]) {
    for (a=[0:360/roller_count:360]) {
      rotate([0, 0, a])
        translate([od + roller_radius - lip_depth, 0, 0])
          cylinder(h=(height - lip_thickness * 2 - roller_margin * 2), r=   roller_radius, center=true);
    }
}
translate([outer_bound, -outer_bound, 0]) {
    cage(od + roller_radius / 2 - cage_thickness / 2, height, cage_thickness, roller_margin + lip_thickness, roller_radius * 2, roller_count);
}

translate([-outer_bound, -outer_bound, 0])
    outer_race(height, od + roller_radius * 2 - lip_depth * 2, od + 2, lip_thickness, lip_depth);
  