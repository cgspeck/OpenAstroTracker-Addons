use <MCAD/boxes.scad>
include <MCAD/nuts_and_bolts.scad>
include <LCD Case/common.scad>

fn=3*72;
$fn=fn;

lid_dimensions = [
    153,
    153,
    3
];

lcd_front_dimensions = [
    96,
    73,
    17.7
];

lcd_back_dimensions = [
    96,
    74.6,
    20
];

module Lid() {
    larger_lid_dim=[
        lid_dimensions.x,
        lid_dimensions.y,
        1.25
    ];
    smaller_lid_dim=[
        146,
        146,
        3 - 1.25 + de_minimus
    ];
    lid_hole_pts = [
        [12.5,17.5,-1-3],
        [12.5,135.5,-1-3],
        [140.5,135.5,-1-3],
        [140.5,17.5,-1-3],
    ];

    difference() {
        union() {
            // translate([
            //     lid_dimensions.x,
            //     0,
            //     0
            // ]) rotate([0, 180, 0]) render() import("mksbase-thing2751907/files/Contol_Box_MK3_Lid.stl", convexity=10);
            translate([
                smaller_lid_dim.x / 2 + 3.5,
                smaller_lid_dim.y / 2 + 3.5,
                -smaller_lid_dim.z / 2 - 1.25 + de_minimus,
            ]) roundedCube(smaller_lid_dim, 3, true, true);
            translate([
                larger_lid_dim.x / 2,
                larger_lid_dim.y / 2,
                -larger_lid_dim.z / 2,
            ]) roundedCube(larger_lid_dim, 7, true, true);
        }
        // holes for the lid
        for (pt=lid_hole_pts) {
            translate(pt) 3mmCounterSunkScrew(2);
        }

        // holes for mount
        translate([
            lid_dimensions.x / 2,
            lid_dimensions.y / 2,
            -5
        ]) {
            translate([-5,0,0]) cylinder_outer(20, 1.5 + clearance_loose);
            translate([5,0,0]) cylinder_outer(20, 1.5 + clearance_loose);
        }
        // hole for cable
        translate([
            lid_dimensions.x / 2 - 20,
            lid_dimensions.y / 2 - 12,
            -de_minimus - 3
        ]) {
            cube([
                15,
                7,
                3 + 2 * de_minimus
            ]);
        }

    }
}


lcd_case_rotation = [
    30,
    0,
    0
];

lcd_case_tran = [
    lid_dimensions.x / 2,
    lid_dimensions.y / 2,
    18.5
];

// translate(lcd_case_tran) rotate(lcd_case_rotation) LCDCase();

module LCDCase() {
    translate([
        lcd_back_dimensions.x / 2,
        lcd_back_dimensions.y / 2,
        0,
    ]) rotate([0,0,180]) import("LCD Case/modified_lcd_case_back.stl");
    translate([
        lcd_front_dimensions.x / 2 - .5,
        - lcd_front_dimensions.y / 2,
        lcd_back_dimensions.z + lcd_front_dimensions.z,
    ]) rotate([180,0,180]) import("LCD Case/modified_lcd_case_front.stl");
}

module MountSheathSolid() {
    outer_dim=[50,40,30];
    wedge_dim=[
        25, 15, 30
    ];
    thickness=1.2;
    shrug=1.2;
    inner_dim=[
        outer_dim.x - thickness * 2,
        outer_dim.y - thickness * 2,
        outer_dim.z + 2 * de_minimus
    ];
    difference() {
        union() {
            difference() {
                roundedCube(outer_dim, 3, true, true);
                roundedCube(inner_dim, 3, true, true);
            }
            rotate(lcd_case_rotation) translate([
                0,
                (outer_dim.y - wedge_dim.y) / 2 + 5,
                0
            ]) roundedCube(wedge_dim, 3, true, true);
        }
        // rear section
        translate([
            0,
            outer_dim.y / 2 + 7.5,
            0
        ]) cube([50, 15, wedge_dim.z + 5], center=true);

        rotate(lcd_case_rotation) translate([
            0,
            19,
            0
        ]) {
            translate([-5,0,0]) ElongatedNutHole();
            translate([5,0,0]) ElongatedNutHole();
        }
        // cutout for cable
        translate([
            -outer_dim.x/2 + 5,
            -outer_dim.y/2 - de_minimus,
            -outer_dim.z/2 - de_minimus
        ]) cube([
            15,
            2.4,
            1.2
        ]);
    }

    // brace part, maybe?
    difference() {
        translate([
            0,
            0,
            -outer_dim.z / 2 + shrug / 2
        ]) {
            cube([
                outer_dim.x,
                10,
                shrug
            ],
                center=true
            );
        }

        translate([
            0,
            0,
            -25
        ]) {
            translate([-5,0,0]) cylinder_outer(20, 1.5 + clearance_loose);
            translate([5,0,0]) cylinder_outer(20, 1.5 + clearance_loose);
        }
    }

}

module ElongatedNutHole() {
    max_z=30;
    translate([
        0,
        0,
        -max_z/2
    ]) {
        cylinder_outer(max_z, 1.5 + clearance_tight);
        cylinder_outer(15, 3);
        translate([0,0,15-de_minimus]) nutHole(3);
    }

}

module MountSheath() {
    difference() {
        translate(mount_sheath_tran) MountSheathSolid();
        LCDCaseProxy();
    }
}

module LCDCaseProxy() {
    ttl_z=lcd_front_dimensions.z + lcd_back_dimensions.z;
    translate(lcd_case_tran) {
        rotate(lcd_case_rotation) {
            translate([
                0,
                0,
                ttl_z / 2
            ]) cube([
                lcd_front_dimensions.x,
                lcd_front_dimensions.y,
                ttl_z
            ], center=true);
        }
    };
}

mount_sheath_tran = [
    lid_dimensions.x / 2,
    lid_dimensions.y / 2,
    15
];

Lid();

// translate([0, 0, 10]) {
//     MountSheath();
// }
