
include <cage.scad>

module cage_lower(id, height, thickness, edge_margin, cut_out_size, cut_out_count) {
    union() {
      translate([0, 0, height / 2]) {
        difference() {
          cage(id, height, thickness, edge_margin, cut_out_size, cut_out_count);
          translate([0, 0, height / 2])
            cube([id * 2, id * 2, height], center=true);
        }
      }
      for (a = [0:360 / cut_out_count:360]) {
        rotate([0, 0, a + 360 / (cut_out_count * 2)])
          translate([id / 2 + thickness / 2, 0, 0])
            cylinder(h=height * 2 / 3, r=thickness / 4);
      }
    }
}

module cage_upper(id, height, thickness, edge_margin, cut_out_size, cut_out_count) {
  difference() {
    translate([0, 0, height/2])
      cage(id, height, thickness, edge_margin, cut_out_size, cut_out_count);
    for (a = [0:360 / cut_out_count:360]) {
      rotate([0, 0, a + 360 / (cut_out_count * 2)])
        translate([id / 2 + thickness / 2, 0, height / 3])
          cylinder(h=height * 2 / 3, r=thickness / 4);
    }
    translate([0, 0, height])
      cube([id + thickness * 3, id + thickness * 3, height], center=true);
  }
}

module cage_split(id, height, thickness, edge_margin, cut_out_size, cut_out_count) {
  cage_lower(id, height, thickness, edge_margin, cut_out_size, cut_out_count);
  translate([id + 4 * cage_thickness, 0, 0])
    cage_upper(id, height, thickness, edge_margin, cut_out_size, cut_out_count);
}
