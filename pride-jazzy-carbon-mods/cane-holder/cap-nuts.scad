include <BOSL2\std.scad>
include <BOSL2\threading.scad>

diam = 5.5; //mm 
length =  25; //mm 
$fn = 36;

// https://github.com/BelfrySCAD/BOSL2/wiki/threading.scad#module-threaded_nut
threaded_nut(nutwidth=(diam * 1.75), id=diam, h=length, pitch=1, bevel1=false, end_len1=5, $slop=0.1, $fa=1, $fs=1);

