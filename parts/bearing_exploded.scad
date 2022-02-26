include <inner_race.scad>
include <cage_split.scad>
include <outer_race.scad>
include <../../util/revolve_text.scad>
include <version.scad>


module bearing_exploded(id, od, outer_thickness, outer_id_margin, height, lip_thickness, lip_depth, roller_radius, roller_margin, roller_count, cage_margin, roller_cage_margin, labels=true) {
  outer_bound = (od + outer_thickness) / 2;
  outer_race_id = 2 * (od / 2 + roller_radius * 2 - lip_depth * 2) + outer_id_margin;
  cage_thickness = roller_radius * 2 - cage_margin - lip_depth * 2;
  roller_height = height - lip_thickness * 2 - roller_margin * 2;
  
  // inner race
  translate([outer_bound, outer_bound, 0]) {
    difference() {
      inner_race(height, id, od, lip_thickness, lip_depth, inner_notch_count, notch_depth);
      // notch for roller insertion
      translate([od / 2 + roller_radius - lip_depth * roller_insertion_fraction, 0, -roller_height / 2])
        cylinder(h=roller_height, r=roller_radius, center=true);
      if (labels) {
        // labels
        translate([0, 0, height / 2 - label_depth]) {
          revolve_text(
            radius=(id + (od - id) / 2) / 2,
            chars=str(
              "id=", id, 
              ",od=", od,
              ",ht=", height, 
              ",lt=", lip_thickness,
              ",ld=", lip_depth,
              ",V=", VERSION
            ),
            font_size=(od - id) / 7,
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
                    text=str("h", roller_height),
                    size=roller_radius/label_size_factor,
                    halign="center",
                    valign="top"
                  );
                }
            }
          }
    }
  }
  
  // cage, split into two
  translate([-outer_bound, -3 * outer_bound, -height / 2]) {
    rotate([0, 0, 0])
      difference() {
        cage_split(od + cage_margin, height, cage_thickness, roller_height, roller_radius * 2 + roller_cage_margin * 2, roller_count);
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
          translate([od + cage_margin + 4 * cage_thickness, 0, height / 2 - label_depth])
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
        od=outer_race_id + outer_thickness,
        lip_thickness=lip_thickness,
        lip_depth=lip_depth, 
        notches=outer_notch_count, 
        notch_depth=notch_depth
      );
      // notch for assembly
      translate([outer_race_id / 2 - roller_radius + lip_thickness * roller_insertion_fraction - outer_id_margin * 2, 0, -roller_height / 2])
        cylinder(h=roller_height, r=roller_radius, center=true);
      if (labels) {
        translate([0, 0, height / 2 - label_depth]) {
          revolve_text(
            radius=od / 2 + outer_thickness / 3,
            chars=str(
              ",id=", outer_race_id,
              ",od=", outer_race_id + outer_thickness,
              ",rr=", roller_radius,
              ",ot=", outer_thickness,
              ",ht=", height,
              ",lt=", lip_thickness,
              ",ld=", lip_depth,
              ",V=", VERSION
            ),
            font_size=(od - id) / 7,
            thickness=label_depth * 2
          );
        }
      }
    }
}

label_size_factor = 2.25;
label_depth = 0.3;
roller_insertion_fraction = 1.0;
outer_notch_count = 16;
inner_notch_count = 4;
notch_depth = 1.5;
