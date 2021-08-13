existing_thickness=0.80;
desired_thickness=1.2;
difference_thickness=desired_thickness-existing_thickness;

module TopSection(height) {
    linear_extrude(height) projection() import("STL/Lid.STL", convexity=5);
}

difference() {
    union() {
        TopSection(difference_thickness);
        translate([
            0,
            0,
            difference_thickness
        ]) import("STL/Lid.STL", convexity=10);
    }
    translate([
        64.5 - 34,
        79.8,
        0
    ]) cube([
        34.1,
        10,
        10
    ]);
}



