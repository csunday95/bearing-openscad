include <bearing_exploded.scad>

// render values
$fs = 0.02;
$fa = 0.04;

// working values
//$fs = 0.1;
//$fa = 0.1;

// inner diameter of inner race
id = 12;
// outer diameter of inner race
od = 28;
// outer diameter of outer race
outer_od = 50;
// marginal increase to outer race ID to compensate for shrinkage as a fraction of outer_od - od - roller_radius * 2
outer_id_margin_frac = 0.001;
/// roller radius
roller_radius = 2.75;
// height of bearing in axial direction
height = 12;
// thickness of lip in axial direction as a fraction of height
lip_thickness_frac = 0.0786;
// depth of lip in radial direction as a fraction of od
lip_depth_frac = 0.02677;
// margin between roller and top/bottom of races in axial direction
roller_margin_frac = 0.055;
// number of rollers
roller_count = 12;
// margin between the cage and the races in the radial direction as a fraction of roller radius
cage_margin_frac = 1 / 3.9;
// cage inner diameter multiplied by this value to compensate for adhesion layer expansion
cage_inner_diameter_mult = 1.0025;
// margin between the roller and cage in the rotational direction as a fraction of roller radius
roller_cage_margin_frac = 0.0125;
// margin between top and bottom of roller and the inner top/bot surface of cage as fraction of bearing height
roller_vertical_cage_margin_frac = 0.0075;


tile_offset = od / 2 + roller_radius + (outer_od - od) / 2;
lip_thickness = lip_thickness_frac * height;
lip_depth = lip_depth_frac * od;
roller_margin = roller_margin_frac * height;
roller_cage_margin = roller_cage_margin_frac * roller_radius;
roller_vertical_cage_margin = roller_vertical_cage_margin_frac * height;
outer_id_margin = (outer_od - od - roller_radius * 2) * outer_id_margin_frac;
echo(outer_id_margin);

//translate([2 * tile_offset, 2 * tile_offset, height / 2])
//  rotate([0, 0, 90])
    bearing_exploded(
      id=id,
      od=od,
      outer_od=outer_od,
      outer_id_margin=outer_id_margin,
      height=height, 
      lip_thickness=lip_thickness,
      lip_depth=lip_depth,
      roller_radius=roller_radius,
      roller_margin=roller_margin,
      roller_count=roller_count,
      cage_margin_frac=cage_margin_frac,
      cage_inner_diameter_mult=cage_inner_diameter_mult,
      roller_cage_margin=roller_cage_margin,
      roller_vertical_cage_margin=roller_vertical_cage_margin,
      labels=false
    );