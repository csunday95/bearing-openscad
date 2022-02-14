
module notch_gen(shaft_diameter, shaft_length, notch_count, notch_depth) {
  for (a = [0:360/notch_count:360]) {
    rotate([0, 0, a])
      translate([shaft_diameter / 2, 0, 0])
        cube([notch_depth * 2, notch_depth, shaft_length], center=true);
  }
}

module notched_shaft(diameter=1, length=5, notch_count=1, notch_depth=0.1, integrated=false) {
  if (integrated) {
    union() {
      cylinder(h=5, r=diameter/2, center=true);
      notch_gen(diameter, length, notch_count, notch_depth);
    }
  } else {
    difference() {
      cylinder(h=5, r=diameter/2, center=true);
      translate([diameter/2, 0, 0])
        cube([notch_depth * 2, notch_depth, length], center=true);
    }
  }
}

