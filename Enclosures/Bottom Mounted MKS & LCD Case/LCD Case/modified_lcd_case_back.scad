include <MCAD/nuts_and_bolts.scad>
include <common.scad>

difference() {
    union() {
        import("./STL/LCD_Case_back.STL", convexity=10);
        for (i=hole_xyz_pts) {
            translate(i) HexNutHolderShim();
        }
        translate([33, 15, 0.2]) cube([31,22,10]);
        translate([30, 15, 0.2]) cube([38,22,1]);
    }

    for (i=hole_xyz_pts) {
        translate(i) HexNutWithHole();
    }
}


module HexNutHolderShim() {
    cylinder_outer(9.2, 3);
};

module HexNutWithHole() {
    translate([0,0,-de_minimus]) cylinder_outer(9.2 * 2, 1.5 + clearance_loose);
    translate([0,0,-.05]) nutHole(3);
    translate([0,0,-z_off]) cylinder_outer(z_off, 3.5);
}
