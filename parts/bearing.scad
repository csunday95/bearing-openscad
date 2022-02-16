include <inner_race.scad>
include <cage_split.scad>
include <outer_race.scad>

//$fa = 0.05;
//$fs = 0.025;

//id = 5;
//od = 6;
//height = 4;
//lip_thickness = 0.4;
//lip_depth = 0.5;
//roller_radius = 1;
//roller_margin = 0.3;
//roller_count = 16;
//cage_thickness = 0.5;

module bearing(id, od, outer_thickness, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_margin) {
  outer_bound = (od + outer_thickness) / 2;
  
  // inner race
  translate([0, 0, height/2])
    inner_race(height, id, od, lip_thickness, lip_depth, 4, 1);

  // rollers
  roller_height = height - lip_thickness * 2 - roller_margin * 2;
  for (a=[0:360/roller_count:360]) {
    rotate([0, 0, a])
      translate([od / 2 + roller_radius - lip_depth, 0, height / 2])
        cylinder(h=roller_height, r=roller_radius, center=true);
  }
  
  // cage, split into two
  //rotate([0, 0, 45])
  cage_thickness = roller_radius * 2 - lip_depth * 2 - cage_margin * 2;
  cage_split(od + cage_margin, height, cage_thickness, roller_height, roller_radius * 2, roller_count);
  
  // outer race
  translate([0, 0, height/2])
    outer_race(height, od + roller_radius * 2, od + outer_thickness, lip_thickness, lip_depth, notches=16, notch_depth=1);
}
 
$fs = 0.1;
$fa = 0.1;
 
id = 12;
od = 26;
outer_thickness = 12;
height = 10;
lip_thickness = 1;
lip_depth = 1;
roller_radius = 2.5;
roller_margin = 0.5;
tile_offset = od / 2 + roller_radius + outer_thickness / 2;
roller_count = 16;
cage_margin = 0.1;

bearing(id, od, outer_thickness, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_margin);
