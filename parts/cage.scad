
module cage(id, height, thickness, cut_out_height, cut_out_width, cut_out_count) {
  cut_out_angle = 360 / cut_out_count;
  difference() {
    cylinder(h=height, r=id / 2 + thickness, center = true);
    cylinder(h=height * 2, r=id / 2, center=true);
    for (a=[0:cut_out_angle:360]) {
      rotate([0, 0, a])
        translate([id / 2, 0, height / 2])
          cube([thickness * 3, cut_out_width, cut_out_height], center=true);
    }
  }
}

//$fs = 0.1;
//$fa = 0.1;
//
//id = 12;
//od = 26;
//outer_thickness = 12;
//height = 10;
//lip_thickness = 1;
//lip_depth = 1;
//roller_radius = 2;
//roller_margin = 0;
//cage_thickness = roller_radius * 2 - lip_depth * 2;
//tile_offset = od / 2 + roller_radius + outer_thickness / 2;
//roller_count = 16;
//roller_height = height - lip_thickness * 2 - roller_margin * 2;
//
//cage(od + roller_radius / 2 - cage_thickness / 2, height, cage_thickness, roller_height, roller_radius * 2, roller_count);
