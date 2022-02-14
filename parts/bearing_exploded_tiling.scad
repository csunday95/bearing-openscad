include <bearing_exploded.scad>

$fs = 0.1;
$fa = 0.025;

id = 12;
od = 26;
outer_thickness = 12;
height = 8;
lip_thickness = 0.5;
lip_depth = 1;
roller_radius = 2;
roller_margin = 0.5;
cage_thickness = 1;
tile_offset = od / 2 + roller_radius + outer_thickness / 2;

translate([2 * tile_offset, 2 * tile_offset, height / 2]) {
    for (idx = [0:1]) {
      roller_count = 12 + 4 * idx;
      tile_offset_x = floor(idx / 2) * 4 * tile_offset;
      tile_offset_y = floor(idx % 2) * 4 * tile_offset;
      translate([tile_offset_x, tile_offset_y, 0])
        bearing_exploded(id, od, outer_thickness, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_thickness);
    }
}