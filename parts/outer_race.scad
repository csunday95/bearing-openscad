module outer_race_profile(width, depth, lip_thickness, lip_depth) {
  points = [
    [0, -width / 2],
    [depth, -width / 2],
    [depth, width / 2],
    [0, width / 2],
    [0, width / 2 - lip_thickness],
    [lip_depth, width / 2 - lip_thickness],
    [lip_depth, -width / 2 + lip_thickness],
    [0, -width / 2 + lip_thickness]
  ];
  polygon(points);
}

module outer_race(width, id, od, lip_thickness, lip_depth, notches=0, notch_depth=0) {
  thickness = (od - id) / 2;
  difference() {
      rotate_extrude() {
        translate([id / 2, 0, 0])
          outer_race_profile(width, thickness, lip_thickness, lip_depth);
      }
      if (notches > 0) {
        for (a=[0:360/notches:360]) {
          rotate([0, 0, a])
            translate([od / 2, 0, 0])
              cube([notch_depth * 2, notch_depth, width * 2], center=true);
        }
      }
  }
}
