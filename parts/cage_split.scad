
include <cage.scad>

module cage_lower(id, height, thickness, cut_out_height, cut_out_width, cut_out_count) {
    union() {
      translate([0, 0, height / 2]) {
        difference() {
          cage(id, height, thickness, cut_out_height, cut_out_width, cut_out_count);
          translate([0, 0, height])
            cube([(id + thickness) * 2, (id + thickness) * 2, height], center=true);
        }
      }
    }
}

module cage_upper(id, height, thickness, cut_out_height, cut_out_width, cut_out_count) {
  translate([0, 0, height/2])
    difference() {
      cage(id, height, thickness, cut_out_height, cut_out_width, cut_out_count);

      translate([0, 0, height])
        cube([(id + thickness) * 2, (id + thickness) * 2, height], center=true);
  }
}

module cage_split(id, height, thickness, cut_out_height, cut_out_width, cut_out_count) {
  cage_lower(id, height / 2, thickness, cut_out_height, cut_out_width, cut_out_count);
  translate([id + 4 * thickness, 0, 0])
    cage_upper(id, height / 2, thickness, cut_out_height, cut_out_width, cut_out_count);
}

//id = 12;
//od = 26;
//outer_thickness = 12;
//height = 10;
//lip_thickness = 1;
//lip_depth = 1;
//roller_radius = 2;
//roller_margin = 0.5;
//cage_thickness = roller_radius * 2 - lip_depth * 2;
//tile_offset = od / 2 + roller_radius + outer_thickness / 2;
//roller_count = 16;
//roller_height = height - lip_thickness * 2 - roller_margin * 2;
//
//cage_split(od + roller_radius / 2 - cage_thickness / 2, height, cage_thickness, roller_height, roller_radius * 2, roller_count);

//$fs = 0.1;
//$fa = 0.1;
//
//module test_cage_split() {
//  cage_split(10, 8, 3, 2, 2, 12);
//}
//
//test_cage_split();
