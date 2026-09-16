include <BOSL2/std.scad>

/* [Measurements] */

// Width of the base of the glasses stand holder.
glasses_stand_width = 53; // [40:1:60]

// Depth of the base of the glasses stand holder.
glasses_stand_depth = 52; // [40:1:60]

// Height of the base of the glasses stand holder.
glasses_stand_height = 17; // [15:1:39]

// Diameter of the of the spray bottle.
spray_bottle_diam = 35; // [20:1:50]

// Include a cleaning cloth slot.
cleaning_clothslot = true; // [true:false]

// Thickness of walls along the perimeter
wall_thickness = 4; // [1:1:5]

/* [Hidden] */
base_width = glasses_stand_width + (wall_thickness * 2);
base_depth = glasses_stand_depth  + spray_bottle_diam + (wall_thickness * 3);
base_height = glasses_stand_height + 1;


difference() {
  cuboid([base_width, base_depth, base_height], anchor=BOTTOM, chamfer=3, edges="Z");
  up(2) {
    translate([0, base_depth / 2 - wall_thickness, 0])
      cylinder(d=spray_bottle_diam, h=glasses_stand_height, anchor=BOTTOM+BACK);
    translate([0, -(base_depth / 2 - wall_thickness), 0])
      cuboid([glasses_stand_width, glasses_stand_depth, glasses_stand_height], anchor=BOTTOM+FRONT);
    //cuboid([glasses_stand_width, wall_thickness, glasses_stand_height], anchor=BOTTOM+BACK);
  }
}