include <BOSL2/std.scad>
$fn=50;


module everbuilt_wood_screw_hole(outer_radius = 5, inner_radius = 3, cap_depth=4, tolerance=.2, hole_depth) {
    // cap
    color("gray")
    union() {
        cyl(r1=outer_radius + tolerance, r2=inner_radius + tolerance, height=cap_depth, anchor=BOTTOM);
        cyl(r1=inner_radius + tolerance, r2=inner_radius + tolerance, height=hole_depth, anchor=BOTTOM);
    }
}