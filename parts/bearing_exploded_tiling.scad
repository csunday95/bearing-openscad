include <bearing_exploded.scad>

$fs = 0.05;
$fa = 0.01;

// inner diameter of inner race
id = 12;
// outer diameter of inner race
od = 28;
// thickness of outer race including lip
outer_thickness = 14;
// marginal increase to outer race ID to compensate for shrinkage
outer_id_margin = 0.1;
// height of bearing in axial direction
height = 12;
// thickness of lip in axial direction
lip_thickness = 1.2;
// depth of lip in radial direction
lip_depth = 0.8;
/// roller radius
roller_radius = 2.5;
// margin between roller and top/bottom of races in axial direction
roller_margin = 0.6;
// number of rollers
roller_count = 12;
// margin between the cage and the races in the radial direction
cage_margin = 0.3;
// margin between the roller and cage in the rotational direction
roller_cage_margin = 0.15;

tile_offset = od / 2 + roller_radius + outer_thickness / 2;

translate([2 * tile_offset, 2 * tile_offset, height / 2])
  rotate([0, 0, 90])
    bearing_exploded(
      id=id,
      od=od,
      outer_thickness=outer_thickness,
      outer_id_margin=outer_id_margin,
      height=height, 
      lip_thickness=lip_thickness,
      lip_depth=lip_depth,
      roller_radius=roller_radius,
      roller_margin=roller_margin,
      roller_count=roller_count,
      cage_margin=cage_margin,
      roller_cage_margin=roller_cage_margin,
      labels=true
    );