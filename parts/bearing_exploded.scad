include <inner_race.scad>
include <cage_split.scad>
include <outer_race.scad>
include <../util/revolve_text.scad>
include <version.scad>

function str_n_digits(n, digits=2) = str(round(10 ^ digits * n) / 10 ^ digits);


module bearing_exploded(id, od, outer_od, outer_id_margin, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_margin_frac, cage_base_thickness_frac, cage_inner_diameter_mult, roller_cage_margin, roller_vertical_cage_margin, labels=true) {
  outer_bound = outer_od / 2;
  outer_race_id = 2 * (od / 2 + roller_radius * 2 - lip_depth * 2) + outer_id_margin;
  cage_margin = roller_radius * cage_margin_frac;
  cage_thickness = roller_radius * 2 - cage_margin - lip_depth * 2;
  roller_height = height - lip_thickness * 2 - roller_margin * 2;
  
  // inner race
  translate([outer_bound, outer_bound, 0]) {
    difference() {
      inner_race(
        width=height, 
        id=id, 
        od=od, 
        lip_thickness=lip_thickness, 
        lip_depth=lip_depth, 
        notches=inner_notch_count, 
        notch_depth=notch_depth, 
        lower_lip_overhang_frac=lower_lip_overhang_frac
      );
      // notch for roller insertion
      translate([od / 2 + roller_radius - lip_depth * roller_insertion_fraction, 0, -roller_height / 2])
        cylinder(h=roller_height, r=roller_radius, center=true);
      if (labels) {
        // labels
        translate([0, 0, height / 2 - label_depth]) {
          revolve_text(
            radius=(id + (od - id) / 2) / 2.1,
            chars=str(
              "id=", id, 
              ",od=", od,
              ",ht=", height, 
              ",lt=", lip_thickness,
              ",ld=", lip_depth,
              ",V=", VERSION
            ),
            font_size=(od - id) / 8,
            thickness=2*label_depth
          );
        }
      }
    }
  }

  // rollers
  translate([-outer_bound, outer_bound + roller_radius, -roller_margin - lip_thickness]) {
    for (a=[0:360/roller_count:360]) {
      rotate([0, 0, a])
        translate([od / 2 + roller_radius - lip_depth, 0, 0])
          difference() {
            cylinder(h=roller_height, r=roller_radius, center=true);
            if (labels) {
            translate([0, 0, roller_height / 2 - label_depth])
              linear_extrude(2 * label_depth)
                union() {
                  text(
                    text=str("r", roller_radius),
                    size=roller_radius/label_size_factor,
                    halign="center",
                    valign="bottom"
                  );
                  text(
                    text=str("h", str_n_digits(roller_height)),
                    size=roller_radius/label_size_factor,
                    halign="center",
                    valign="top"
                  );
                }
            }
          }
    }
  }
  cage_id = (od + cage_margin) * cage_inner_diameter_mult;
  echo(cage_id);
  // cage, split into two
  translate([-outer_bound, -3 * outer_bound, -height / 2]) {
    rotate([0, 0, 0])
      difference() {
        cage_split(
          cage_id, 
          height * (1 + cage_base_thickness_frac) + 2 * roller_vertical_cage_margin,
          cage_thickness,
          roller_height + 2 * roller_vertical_cage_margin,
          roller_radius * 2 + roller_cage_margin * 2,
          roller_count
        );
        if (labels) {
          translate([0, 0, height / 2 - label_depth])
            rotate([0, 0, 360 / roller_count / 2])
              revolve_text(
                radius=od / 2 + roller_radius / 2,
                chars=str(
                  "V=", VERSION,
                  ",BOT"
                ),
                font_size=roller_radius / 2.5,
                thickness=label_depth * 2
              );
          translate([cage_id + 4 * cage_thickness, 0, height / 2 - label_depth])
            rotate([0, 0, 360 / roller_count / 2])
              revolve_text(
                radius=od / 2 + roller_radius / 2,
                chars=str(
                  "V=", VERSION,
                  ",TOP"
                ),
                font_size=roller_radius / 2.5,
                thickness=label_depth * 2
              );
        }
      }
  }
  // outer race
  translate([0, -outer_bound, 0])
    difference() {
      outer_race(
        height=height,
        id=outer_race_id,
        od=outer_od,
        lip_thickness=lip_thickness,
        lip_depth=lip_depth, 
        notches=outer_notch_count, 
        notch_depth=notch_depth,
        lower_lip_overhang_frac=lower_lip_overhang_frac
      );
      // notch for assembly
      translate([outer_race_id / 2 - roller_radius + lip_depth * roller_insertion_fraction - outer_id_margin * 2, 0, -roller_height / 2])
        cylinder(h=roller_height, r=roller_radius, center=true);
      if (!labels) {
        translate([0, 0, height / 2 - label_depth]) {
          revolve_text(
            radius=(outer_race_id + (outer_od - outer_race_id)) / 2 * 0.75,
//            chars=str(
//              ",id=", outer_race_id,
//              ",od=", outer_od,
//              ",rr=", roller_radius,
//              ",ht=", height,
//              ",lt=", lip_thickness,
//              ",ld=", lip_depth,
//              ",V=", VERSION
//            ),
            chars=str("V=", VERSION),
            font_size=(od - id) / 7,
            thickness=label_depth * 2,
            arc_fraction=0.15
          );
        }
      }
    }
}

label_size_factor = 3.5;
label_depth = 0.15;
roller_insertion_fraction = 1.0;
// value to compensate for first layer getting slightly dilated in the 
// lower lip compared to top layer overhang; lower lip radial length is 90% of
// nominal value
lower_lip_overhang_frac = 0.9;
outer_notch_count = 16;
inner_notch_count = 4;
notch_depth = 1.0;
