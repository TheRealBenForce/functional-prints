// Import BOSL2 library
include <BOSL2/std.scad>;

// Parameters
card_thickness = 4; // Thickness of the sample card
hole_diam_start = 4; // Starting diameter of the holes
hole_diam_end = 6;   // Ending diameter of the holes
hole_increment = 0.1; // Increment for hole diameters
hole_spacing = 2;    // Spacing between holes

// Calculate the number of holes
num_holes = ceil((hole_diam_end - hole_diam_start) / hole_increment) + 1;

// Calculate card dimensions
card_width = (hole_diam_end + hole_spacing) * num_holes;
card_height = hole_diam_end + hole_spacing;

// Create the sample cards with varying thicknesses
for (thickness = [2 : 0.25 : 3]) {
    translate([0, (thickness - 2) * (card_width / 2 + 10), thickness / 2]) // Adjusted spacing to be half the card width
        difference() {
            // Base rectangle
            cube([card_width, card_height, thickness], center = true);

            // Holes
            for (i = [0 : num_holes - 1]) {
                translate([i * (hole_diam_end + hole_spacing) - card_width / 2 + hole_diam_end / 2, 0, 0])
                    cylinder(h = thickness * 2, d = hole_diam_start + i * hole_increment, center = true, $fn = 32);
            }
        }
}
