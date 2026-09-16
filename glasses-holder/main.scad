include <BOSL2/std.scad>

/* [Measurements] */

// Width of the base of the glasses stand holder.
glasses_stand_width = 53; // [40:1:80]

// Depth of the base of the glasses stand holder.
glasses_stand_depth = 52; // [40:1:80]

// Height of the base of the glasses stand holder. Pick slighly less if you want an aesthetic to show more of the base popping up.
glasses_stand_height = 14; // [10:1:40]

// Diameter of the of the spray bottle.
spray_bottle_diam = 35; // [20:1:50]

// Include a cleaning cloth slot.
cleaning_clothslot = true; // [true:false]

// Size of chamfer around perimeter
chamfer_size = 2; // [2:1:6]

// Thickness of walls along the perimeter
wall_thickness = 5; // [1:1:6]

/* [Hidden] */
$fn = 64;
base_width = glasses_stand_width + (wall_thickness * 2);
cleaning_clothslot_depth = cleaning_clothslot ? wall_thickness * 3 : 0;
cleaning_clothslot_wall = cleaning_clothslot ? wall_thickness : 0;
base_depth = glasses_stand_depth + spray_bottle_diam
           + (wall_thickness * 3) + cleaning_clothslot_depth + cleaning_clothslot_wall;
base_height = glasses_stand_height + 1;


difference() {
  cuboid([base_width, base_depth, base_height], anchor=BOTTOM, chamfer=chamfer_size, edges=[TOP,"Z"]);
  up(2) {
    translate([0, base_depth / 2 - wall_thickness, 0])
      cylinder(d=spray_bottle_diam, h=glasses_stand_height, anchor=BOTTOM+BACK)
        attach(BOTTOM) cylinder(d=spray_bottle_diam * .75, h=glasses_stand_height);
    translate([0, -(base_depth / 2 - wall_thickness), 0])
      cuboid([glasses_stand_width, glasses_stand_depth, glasses_stand_height], anchor=BOTTOM+FRONT)
        attach(BOTTOM) cuboid([glasses_stand_width * .75, glasses_stand_depth * .75, glasses_stand_height]);
    if (cleaning_clothslot == true)
      translate([0, -base_depth / 2 + (wall_thickness * 2) + glasses_stand_depth, 0])
        cuboid([glasses_stand_width, cleaning_clothslot_depth, glasses_stand_height], anchor=BOTTOM+FRONT);
  }
}