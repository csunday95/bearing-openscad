
module inner_race_profile(width, depth, lip_thickness, lip_depth, lower_lip_overhang_frac) {
  lower_lip_offset = (1 - lower_lip_overhang_frac) * lip_depth;
  points= [
    [0, -width / 2], 
    [0, width / 2], 
    [depth, width / 2], 
    [depth, width / 2 - lip_thickness], 
    [depth - lip_depth, width / 2 - lip_thickness * 1.5], 
    [depth - lip_depth, -width / 2 + lip_thickness * 1.5],
    [depth - lower_lip_offset, -width / 2 + lip_thickness], 
    [depth - lower_lip_offset, -width / 2]
  ];
  polygon(points);
}

module inner_race(width, id, od, lip_thickness, lip_depth, notches=0, notch_depth=0, lower_lip_overhang_frac=1.0) {
  thickness = (od - id) / 2;
  difference() {
      rotate_extrude() {
        translate([id / 2, 0, 0])
          inner_race_profile(
            width, 
            thickness, 
            lip_thickness, 
            lip_depth,
            lower_lip_overhang_frac
          );
      }
      if (notches > 0) {
          for (a=[0:360/notches:360]) {
            rotate([0, 0, a])
              translate([id / 2, 0, 0])
                cube([notch_depth * 2, notch_depth, width * 2], center=true);
          }
      }
  }
}

module test_profile() {
  inner_race_profile(1, 1, 0.1, 0.1);
}

module test_inner_race() {
  inner_race(
    width=5,
    id=10,
    od=16,
    lip_thickness=1,
    lip_depth=1,
    notches=4,
    notch_depth=1,
    lower_lip_overhang_frac=1.0
  );
}

//$fs = 0.1;
//$fa = 0.1;
//test_inner_race();
