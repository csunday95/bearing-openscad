
$fs = 0.1;

module profile(mount_region_radius=1, hole_radius=0.5, base_margin=1) {
  translate([1.5 * mount_region_radius, 2 * mount_region_radius + base_margin / 2])
  difference() {
    union() {
      circle(r=mount_region_radius);
      difference() {
        translate([- mount_region_radius / 2, 0])
          square([mount_region_radius, mount_region_radius * 4], center=true);
        translate([0, -mount_region_radius * 2])
          circle(r=mount_region_radius);
        translate([0, mount_region_radius * 2])
          circle(r=mount_region_radius);
      }
      translate([-mount_region_radius * 1.25, 0])
        square([mount_region_radius / 2, mount_region_radius * 4 + base_margin], center=true);
    }
    circle(r=hole_radius);
  }
}

module stand(thickness=1, mount_region_radius=1, hole_radius=0.5, base_margin=1, base_hole_diameter=0.25) {
  difference() {
    linear_extrude(thickness)
      profile(mount_region_radius, hole_radius, base_margin);
    translate([0, base_margin / 2, thickness / 2])
      rotate([0, 90, 0])
        cylinder(h=mount_region_radius * 2, r=base_hole_diameter, center=true);
  }
}

stand(1, 2, 1, 1);
