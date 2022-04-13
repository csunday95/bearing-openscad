
include <MCAD/constants.scad>

module spacer_cage(id, height, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness = 1.2) {
  cut_out_angle = 360 / cut_out_count;
  difference() {
    cylinder(h=height, r=id / 2 + thickness, center = true);
    cylinder(h=height * 2, r=id / 2, center=true);
    for (a=[0:cut_out_angle:360]) {
      rotate([0, 0, a])
        translate([id / 2, 0, height / 2])
          cube([thickness * 3, cut_out_width, cut_out_height], center=true);
    }
    circumference = PI * id;
    crenelation_width = (circumference - (cut_out_width * cut_out_count)) / cut_out_count;
    for (a=[0:cut_out_angle:360]) {
      rotate([0, 0, a])
        translate([id / 2 - thickness / 2, -cut_out_width / 2, height / 2 - cut_out_height / 2])
          rotate([90, 0, 90])
            linear_extrude(thickness * 3)
              polygon([
                [0, 0],
                [cut_out_width, 0],
                [cut_out_width + crenelation_width * pointiness, cut_out_height],
                [-crenelation_width * pointiness, cut_out_height]
              ]);
    }
  }
}

module cage_lower(id, height, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness) {
    union() {
      translate([0, 0, height / 2]) {
        difference() {
          spacer_cage(id, height, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness);
          translate([0, 0, height])
            cube([(id + thickness) * 2, (id + thickness) * 2, height], center=true);
        }
      }
    }
}

module cage_upper(id, height, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness=1.2) {
  translate([0, 0, height/2])
    difference() {
      spacer_cage(id, height, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness);

      translate([0, 0, height])
        cube([(id + thickness) * 2, (id + thickness) * 2, height], center=true);
  }
}

module cage_split(id, height, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness=1.2) {
  cage_lower(id, height / 2, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness);
  translate([id + 4 * thickness, 0, 0])
    cage_upper(id, height / 2, thickness, cut_out_height, cut_out_width, cut_out_count, pointiness);
}

module test_spacer_cage(pointiness=1.2) {

  $fs = 0.05;
  $fa = 0.05;

  // Inner Race Inner Diameter
  id = 12;
  // Inner Race Outer Diameter
  od = 28;
  // outer race thickness
  outer_thickness = 14;
  // bearing height
  height = 12;
  // thickness of lip on inner surface of races
  lip_thickness = 1.25;
  // depth of in cut on inner surafe of races
  lip_depth = 1.25;
  // radius of the bearing rollers
  roller_radius = 2.5;
  // distance between edge lip of the races and the ends of the rollers
  roller_margin = 0.55;
  // margin between cage and the race edges
  cage_margin = 0.15;
  // number of bearing rollers
  roller_count=12;
  // margin between cage edges and roller rolling surface
  roller_cage_margin = 0.1;
  tile_offset = od / 2 + roller_radius + outer_thickness / 2;
  cage_thickness = roller_radius * 2 - lip_depth * 2;
  roller_height = height - lip_thickness * 2 - roller_margin * 2;

  cage_split(od + roller_radius / 2 - cage_thickness / 2, height, cage_thickness, roller_height, roller_radius * 2, roller_count, pointiness=pointiness);
}

od = 28;
outer_thickness = 14;
translate([(od + outer_thickness) / 2, (od + outer_thickness) / 2, 0]) {
  test_spacer_cage(1.1);
  translate([0, od + outer_thickness, 0])
    test_spacer_cage(1.2);
  translate([0, 2 * (od + outer_thickness), 0])
    test_spacer_cage(1.4);
}