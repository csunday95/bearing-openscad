
# SCAD Origin Bearing Changelog

Started keeping track at version 0.6.0

### Terms:
 - directions:
    - build side vs terminal side - side that prints on the build head (z = 0) vis terminal side of circular bearing face
   - radial - along the vector going from the center toward the perimeter for circularly symmetric parts
   - anti-radial - opposite direction as radial
   - axial - along the vector of a shaft that would pass through the center of the bearing, perpendicular to the circular face of the bearing. Positive axial is in the terminal print direction (positive z)
   - anti-axial - opposite axial direction
   - rotational - direction of the bearing's rotation, at any point the cross product of radial and axial vectors
 - dimensions
   - width - size in rotational direction
   - height - size in axial direction
   - length - size in radial direction

# 0.6.0

 - first satisfactorily functional bearing printed with settings

 ```json
 {
    "export_v6": {
        "$fa": "0.01",
        "$fs": "0.050000000000000003",
        "cage_margin": "0.29999999999999999",
        "height": "12",
        "id": "12",
        "lip_depth": "1.3",
        "lip_thickness": "0.80000000000000004",
        "od": "28",
        "outer_thickness": "14",
        "roller_cage_margin": "0.20000000000000001",
        "roller_count": "12",
        "roller_margin": "0.75",
        "roller_radius": "2.5"
    },
 }
 ```
 ## Notes:
  - smooth rolling performance with zero thrust, decent thrust zero-load performance
  - a bit more slop than I'd like in the axial direction due to the rollers being shorter than the bevel; candidate for panelization 
  - probably can get a better insertion notch but putting it on the build head side
  - put text on the rollers / other parts in non crital areas for easier identification, best to put on non build side
