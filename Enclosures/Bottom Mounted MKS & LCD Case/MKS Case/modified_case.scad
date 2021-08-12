desired_base_thickness=1.2;
extra_height=10;

existing_base_thickness=0.6;
existing_height=23;

adj_height=desired_base_thickness-existing_base_thickness;

module EnclosureWithCutouts() {
    difference() {
        union() {
            // thicker base
            linear_extrude(desired_base_thickness) projection(cut=true) import("STL/Case_v3.STL", convexity=10);
            translate([
                0,
                0,
                adj_height
            ]) import("STL/Case_v3.STL", convexity=10);
        }
        translate([
            92 - 34,
            17.5,
            11.6
        ]) cube([
            34.1,
            5,
            12
        ]);
    }
}

module TopPart(height) {
    linear_extrude(height) projection(cut=true) translate([0, 0, -20]) EnclosureWithCutouts();
}

EnclosureWithCutouts();

translate([
    0,
    0,
    existing_height+(desired_base_thickness - existing_base_thickness)
]) TopPart(extra_height);
