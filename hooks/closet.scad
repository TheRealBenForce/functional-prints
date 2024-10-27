include <BOSL2/std.scad>
include <../screws.scad>

$fn = 32;
total_height = 100;
bracket_thickness = 10;
overhang_depth = 20;
width = 30;


module core() {

    difference() {
        cuboid([40, width, total_height], chamfer=2, trimcorners=false);
        
        // horizontal shelf
        color("blue")
        down((total_height/2) + .01)
        cube([bracket_thickness * 2 + 2, 60 , total_height * .9], anchor=BOTTOM);

        // verticle shelf
        color("red")
        up((total_height / 2) - bracket_thickness - overhang_depth )
        left(15)
        cube([20, 60 , total_height], anchor=TOP);
    }
}


module complete () {
    union () {
        difference () {    
            core();

            // screw hole
            up(total_height * .32)
            left((40 / 2) + .1)
            yrot(90)
            everbuilt_wood_screw_hole(hole_depth=10 + .2);

        }

        //hook
        down(total_height * .45)
        right((40 / 2) + -3)
        yrot(55)
        prismoid(size1=[5, width - 5], size2=[5, width - 10], h=30, chamfer=1);
    }
}

complete();
