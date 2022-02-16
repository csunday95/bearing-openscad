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

module bearing_exploded(id, od, outer_thickness, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_margin, roller_cage_margin) {
  outer_bound = (od + outer_thickness) / 2;
  outer_race_id = 2 * (od / 2 + roller_radius * 2 - lip_depth * 2);
  cage_thickness = roller_radius * 2 - cage_margin - lip_depth * 2;
  roller_height = height - lip_thickness * 2 - roller_margin * 2;
  
  // inner race
  translate([outer_bound, outer_bound, 0])
    inner_race(height, id, od, lip_thickness, lip_depth, 4, 1.5);

  // rollers
  translate([-outer_bound, outer_bound + roller_radius, -roller_margin - lip_thickness]) {
    for (a=[0:360/roller_count:360]) {
      rotate([0, 0, a])
        translate([od / 2 + roller_radius - lip_depth, 0, 0])
          cylinder(h=roller_height, r=roller_radius, center=true);
    }
  }
  
  // cage, split into two
  translate([outer_bound, -outer_bound - outer_thickness / 2, -height / 2]) {
    rotate([0, 0, 45])
      cage_split(od + cage_margin, height, cage_thickness, roller_height, roller_radius * 2 + roller_cage_margin * 2, roller_count);
  }

  // outer race
  translate([-outer_bound, -outer_bound, 0])
    outer_race(height, outer_race_id, outer_race_id + outer_thickness, lip_thickness, lip_depth, notches=16, notch_depth=1.5);
}
