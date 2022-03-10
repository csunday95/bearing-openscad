module outer_race_profile(height, depth, lip_thickness, lip_depth, lower_lip_overhang_frac) {
  lower_lip_overhang = (1 - lower_lip_overhang_frac) * lip_depth;
  points = [
    [lower_lip_overhang, -height / 2],
    [depth, -height / 2],
    [depth, height / 2],
    [0, height / 2],
    [0, height / 2 - lip_thickness],
    [lip_depth, height / 2 - lip_thickness * 1.5],
    [lip_depth, -height / 2 + lip_thickness * 1.5],
    [lower_lip_overhang, -height / 2 + lip_thickness]
  ];
  polygon(points);
}

module outer_race(height, id, od, lip_thickness, lip_depth, notches=0, notch_depth=0, lower_lip_overhang_frac=1.0) {
  thickness = (od - id) / 2;
  difference() {
    rotate_extrude() {
      translate([id / 2, 0, 0])
        outer_race_profile(height, thickness, lip_thickness, lip_depth, lower_lip_overhang_frac);
    }
    // change to use notch script
    if (notches > 0) {
      for (a=[0:360/notches:360]) {
        rotate([0, 0, a])
          translate([od / 2, 0, 0])
            cube([notch_depth * 2, notch_depth, height * 2], center=true);
      }
    }
  }
}

module test_outer_race_profile() {
  $fs = 0.1;
  $fa=0.1;
  outer_race_profile(2, 2, 0.2, 0.2, 0.8);
}
