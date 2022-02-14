
module cage(id, height, thickness, edge_margin, cut_out_size, cut_out_count) {
  cut_out_length = height - edge_margin * 2;
  cut_out_angle = 360 / cut_out_count;
  difference() {
    cylinder(h=height, r=id / 2 + thickness, center = true);
    cylinder(h=height * 2, r=id / 2, center=true);
    for (a=[0:cut_out_angle:360]) {
      rotate([0, 0, a])
        translate([id / 2 + edge_margin, 0, 0])
          cube([thickness * 3, cut_out_size, cut_out_size], center=true);
    }
  }
}
