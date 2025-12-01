// Import BOSL2 library
include <BOSL2/std.scad>;

// Parameters
inner_wheel_diam = 8  ; // Diameter of the wheel
inner_hole_diam = 5;   // Diameter of the hole
inner_wheel_thickness = 3; // Thickness of the wheel

outer_wheel_diam = 19  ; // Diameter of the wheel
outer_hole_diam = inner_hole_diam + 1;   // Diameter of the hole
outer_wheel_thickness = 2.5; // Thickness of the wheel

$fn = 64; // Set high resolution for smooth circles

// Combine inner and outer wheel into a single module
module wheel(diam, hole_diam, thickness, chamfer_bottom=false) {
    tube(
        h=thickness,
        or=diam/2,
        ir=hole_diam/2,
        center=false,
        rounding2=diam * 0.01, // Chamfer the top edge
        rounding1=chamfer_bottom ? diam * 0.01 : 0 // Optional chamfer for the bottom edge
    );
}

module outer_tube() {
    color("gray")
    tube(
        h=outer_wheel_thickness * .5,
        or=(outer_wheel_diam / 2) + .5, // Corrected to use radius
        ir=(outer_wheel_diam / 2) - .5, // Corrected to use radius
        center=false,
        rounding=0.2 // Chamfer the top edge
    );
}

module spoke_cutout(h, w, num_spokes) {
    linear_extrude(height=inner_wheel_thickness + 1) {
        for (i = [0 : num_spokes - 1]) {
            rotate([0, 0, i * 360 / num_spokes]) {
                translate([0, (outer_wheel_diam - inner_wheel_diam)/2 , 0]) // Adjust translation to align the face
                trapezoid(h=h, w1=w * .6, w2=w * 1.4, rounding=.1);
            }
        }
    }
}



// Inner wheel
wheel(diam=inner_wheel_diam, hole_diam=inner_hole_diam, thickness=inner_wheel_thickness);

// Outer wheel with optional bottom chamfer
difference() {
  wheel(diam=outer_wheel_diam, hole_diam=outer_hole_diam, thickness=outer_wheel_thickness, chamfer_bottom=true);
  spoke_cutout(5, 1, 18);

  // tube part of the bike
  translate([0, 0, outer_wheel_thickness* .25]) {
    outer_tube();
  }
}

// Add a black cylinder for the outer tube
translate([outer_wheel_diam * 1.2, 0, 0]) {
outer_tube();
}