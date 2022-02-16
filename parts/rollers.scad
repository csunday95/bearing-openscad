
id = 12;
od = 26;
outer_thickness = 12;
height = 8;
lip_thickness = 0.5;
lip_depth = 1;
roller_radius = 2;
roller_margin = 0.5;
cage_thickness = 1;
roller_count = 16;

$fs = 0.1;
$fa = 0.1;

translate([od / 2 + roller_radius * 2, od / 2 + roller_radius * 2, height / 2 - 2 * roller_margin]) {
  for (a=[0:360/roller_count:360]) {
    rotate([0, 0, a])
      translate([od / 2 + roller_radius - lip_depth, 0, 0])
        cylinder(h=(height - lip_thickness * 2 - roller_margin * 2), r=roller_radius, center=true);
  }
}