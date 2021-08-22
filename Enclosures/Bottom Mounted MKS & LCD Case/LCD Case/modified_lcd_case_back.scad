include <MCAD/nuts_and_bolts.scad>
include <common.scad>

model_z_error=0.2;

difference() {
    union() {
        import("./STL/LCD_Case_back.STL", convexity=10);
        for (i=hole_xyz_pts) {
            translate([
                i.x,
                i.y,
                model_z_error
            ]) HexNutHolderShim();
        }
        translate([33, 15, model_z_error]) cube([31,25,11]);
        translate([30, 15, model_z_error]) cube([38,22,1]);
    }

    for (i=hole_xyz_pts) {
        translate(i) HexNutWithHole();
    }

    translate([
        lcd_enclosure_base_dim.x / 2,
        lcd_enclosure_base_dim.y - 15,
        model_z_error
    ]) CSCPair(1.2);

    translate([
        lcd_enclosure_base_dim.x / 2,
        20,
        model_z_error
    ]) CSCPair(3);

    translate([
        lcd_enclosure_base_dim.x / 2,
        lcd_enclosure_base_dim.y / 2,
        model_z_error
    ]) CSCPair(3);

    BottomCurveProfile();
}


module HexNutHolderShim() {
    cylinder_outer(20, 4.8);
};

module HexNutWithHole() {
    translate([0,0,-de_minimus]) cylinder_outer(9.2 * 2, 1.5 + clearance_loose);
    translate([0,0,-.05]) nutHole(3);
    translate([0,0,-z_off]) cylinder_outer(z_off, 3.5);
}

module CSCPair(screw_len) {
    dx=10;
    translate([-dx/2, 0, -de_minimus]) 3mmCounterSunkScrew(screw_len + de_minimus);
    translate([dx/2, 0, -de_minimus]) 3mmCounterSunkScrew(screw_len + de_minimus);
}

module BottomCurveProfile(length=90) {
    mirror([0,0,1]) rotate([0,90,0]) linear_extrude(length) projection() rotate([0,90,0]) union() {
        difference() {
            union() {
                import("./STL/LCD_Case_back.STL", convexity=10);
                translate([
                    lcd_enclosure_base_dim.x /2 + 0.5,
                    0,
                    model_z_error
                ]) difference() {
                    cube([
                        1,
                        8.5,
                        10.5
                    ]);
                    translate([
                        0-0.1,
                        6,
                        4
                    ]) cube([
                        1+0.2,
                        3,
                        6.6
                    ]);
                }
            }
            import("./STL/LCD_Case_back.STL", convexity=10);
        }
        translate([-1,-1,model_z_error]) cube([
            1,
            1,
            10.5
        ]);
    }
}
