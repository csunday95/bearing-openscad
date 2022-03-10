include <bearing_exploded.scad>

$fs = 0.02;
$fa = 0.01;

// inner diameter of inner race
id = 7;
// outer diameter of inner race
od = 11;
// thickness of outer race including lip
outer_thickness = 5;
// marginal increase to outer race ID to compensate for shrinkage as a fraction of other_thickness
outer_id_margin_frac = 0.005;
/// roller radius
roller_radius = 1;
// height of bearing in axial direction
height = 4;
// thickness of lip in axial direction as a fraction of height
lip_thickness_frac = 0.0786;
// depth of lip in radial direction as a fraction of od
lip_depth_frac = 0.02677;
// margin between roller and top/bottom of races in axial direction
roller_margin_frac = 0.05;
// number of rollers
roller_count = 12;
// margin between the cage and the races in the radial direction as a fraction of roller radius
cage_margin_frac = 1 / 5;
// margin between the roller and cage in the rotational direction as a fraction of roller radius
roller_cage_margin_frac = 0.0075;


tile_offset = od / 2 + roller_radius + outer_thickness / 2;
lip_thickness = lip_thickness_frac * height;
lip_depth = lip_depth_frac * od;
roller_margin = roller_margin_frac * height;
roller_cage_margin = roller_cage_margin_frac * roller_radius;
outer_id_margin = outer_thickness * outer_id_margin_frac;

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
      cage_margin_frac=cage_margin_frac,
      roller_cage_margin=roller_cage_margin,
      labels=true
    );