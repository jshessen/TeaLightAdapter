/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&  TeaLightAdapter: TeaLightAdapter.scad

        Copyright (c) 2022, Jeff Hessenflow
        All rights reserved.
        
        https://github.com/jshessen/TeaLightAdapter
&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&  GNU GPLv3
&&
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/





/*?????????????????????????????????????????????????????????????????
/*???????????????????????????????????????????????????????
?? Section: Customizer
??
    Description:
        The Customizer feature provides a graphic user interface for editing model parameters.
??
???????????????????????????????????????????????????????*/
/* [Global] */
// Display Verbose Output?
$VERBOSE=1; // [0:No,1:Level=1,2:Level=2,3:Developer]

/* ["Tea Light" Dimension Parameters] */
// "Tea Light" Base Height
custom_height=16.75;  // [0:.01:25]
// "Tea Light" Base Diameter
diameter=41.75;         // [0:.01:50]

/* [Mounting Bracket Parameters] */
// Bolt Hole Diameter
hole_diameter=3.1;      // [0:.01:5]
// Distance Between Holes (On-Center)
on_center=59.4;         // [0:.01:100]
// "Round" Bracket Ends
$ROUND=1;               // [0:No,1:Yes]

/* [Advanced] */
// "Width" of Part Wall
custom_wall=2;          // [0:.01:100]
// "Depth" of Mounting Bracket
custom_depth=8.5;       // [0:.01:100]
// Rounded Corner "Offset" Value
round_corner=2;        // [0:1:25]
/*
?????????????????????????????????????????????????????????????????*/





/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section: Derived Variables
*/
/* [Hidden] */
//$fa = 0.1;
//$fs = 0.1;
wall=custom_wall;
r=diameter/2;
width=on_center+(6*wall);
depth=custom_depth;
height=custom_height+wall;
/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/





/*/////////////////////////////////////////////////////////////////
// Section: Modules
*/
/*///////////////////////////////////////////////////////
// Module: make_TeaLightAdapter()
//
    Description:
        Wrapper module to create all adapter objects

    Arguments:
        N/A
*/
// Example: Make sample objects
   make_TeaLightAdapter();
///////////////////////////////////////////////////////*/
module make_TeaLightAdapter(){
    difference(){
        // Create Foundation Frame
        union(){
            if($VERBOSE) echo("--> Make \"Adapter\" Bolt Tabs");
            if($ROUND){
                linear_extrude(wall,$fn=360)
                    offset(r=round_corner)
                        square([width-(2*round_corner),depth-(2*round_corner)], center=true);
            } else {
                translate([0,0,wall/2])
                    cube([width,depth,wall],center=true);
            }
            if($VERBOSE) echo("--> Make \"Adapter\" Object");
            translate([0,0,height/2])
                cylinder(h=height,r=r,center=true, $fn=360);
        }
        if($VERBOSE) echo("--> Hollow \"Adapter\" for Tea Light");
        translate([0,0,(height/2)+wall])
            cylinder(h=height,r=(r-wall),center=true, $fn=360);
        if($VERBOSE) echo("--> Create Opening for Tea Light Switch/Battery Door");
        translate([0,0,wall])
            cylinder(h=3*wall,r=(r-(2*wall)),center=true, $fn=360);
        if($VERBOSE) echo("--> Create Mounting Bolt Holes");
        translate([(on_center/2),0,wall/2])
            cylinder(h=2*wall,d=hole_diameter,center=true, $fn=360);
        translate([-(on_center/2),0,wall/2])
            cylinder(h=2*wall,d=hole_diameter,center=true, $fn=360);
    }
}
/*
#################################################################*/