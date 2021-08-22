include <MCAD/nuts_and_bolts.scad>
include <common.scad>

difference() {
    union() {
        import("./STL/LCD_case_front.STL", convexity=10);
    }

    for (i=hole_xyz_pts) {
        translate(i) CSCScrewHole();
    }
}

module CSCScrewHole() {
    screw_len=20;
    translate([0,0,-z_off -de_minimus + screw_len + 2 ]) rotate([0,180,0]) 3mmCounterSunkScrew(screw_len);
}