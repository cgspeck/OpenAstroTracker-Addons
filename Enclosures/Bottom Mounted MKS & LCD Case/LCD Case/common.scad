fn=72 * 4;
$fn=fn;
clearance_tight=0.2;
clearance_loose=0.4;
de_minimus=0.1;

z_off=11;
hole_xyz_pts=[
    [22.4, 4.4, z_off],
    [74.6, 4.4, z_off],
    [22.4, 69.4, z_off],
    [74.6, 69.4, z_off],
];


module cone_outer(height,radius1,radius2,fn=fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=radius1*fudge,r2=radius2*fudge,$fn=fn);
}

module cylinder_outer(height,radius,fn=fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

module CounterSunkScrew(screw_dia, screw_len, screw_cs_len, screw_cs_head_w) {
    actual_screw_dia=screw_dia + (clearance_tight * 2);
    cylinder_outer(screw_len, actual_screw_dia / 2);
    translate([0, 0, screw_len]) cone_outer(screw_cs_len, actual_screw_dia / 2, screw_cs_head_w /2);
    translate([0, 0, screw_len + screw_cs_len]) cylinder_outer(screw_len * 2, screw_cs_head_w / 2);;
}

module 3mmCounterSunkScrew(screw_len) {
    screw_cs_len = 2;
    screw_cs_head_w = 6;
    CounterSunkScrew(3, screw_len, screw_cs_len, screw_cs_head_w);
}