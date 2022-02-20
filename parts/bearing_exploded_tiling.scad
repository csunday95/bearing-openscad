include <bearing_exploded.scad>

//$fs = 0.05;
//$fa = 0.01;
//
//// Inner Race Inner Diameter
//id = 12;
//// Inner Race Outer Diameter
//od = 28;
//// outer race thickness
//outer_thickness = 14;
//// bearing height
//height = 12;
//// thickness of lip on inner surface of races
//lip_thickness = 1.25;
//// depth of in cut on inner surafe of races
//lip_depth = 1.25;
//// radius of the bearing rollers
//roller_radius = 2.5;
//// distance between edge lip of the races and the ends of the rollers
//roller_margin = 0.55;
//// margin between cage and the race edges
//cage_margin = 0.3;
//// number of bearing rollers
//roller_count = 12;

$fs = 0.05;
$fa = 0.01;
 
id = 12;
od = 28;
outer_thickness = 14;
height = 12;
lip_thickness = 0.8;
lip_depth = 1.3;
roller_radius = 2.5;
roller_margin = 0.75;
roller_count = 12;
cage_margin = 0.3;
roller_cage_margin = 0.2;

tile_offset = od / 2 + roller_radius + outer_thickness / 2;
// notes: 
// need to add a bit of clearance on the roller mating surface of the cage
// ID of outer race is definitely wrong

translate([2 * tile_offset, 2 * tile_offset, height / 2])
  rotate([0, 0, 90])
    bearing_exploded(id, od, outer_thickness, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_margin, roller_cage_margin);