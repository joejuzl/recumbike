// Settings
annotate=false;
text_size=3;
text_color="black";
line_color="darkgrey";
$fa = 1;
$fs = 0.4;

// Building blocks
module rod(width, depth, length, thickness){
    inner_width = width-(thickness*2);
    inner_depth = depth-(thickness*2);
    difference() {
        cube([ width, depth, length ]);
        translate([ thickness, thickness, -1 ])
            cube([ inner_width, inner_depth, length + 2 ]);
    }
}

module hole(front, depth, diameter, x, y) {
    rot_x = (front) ? 90 : 0;
    rot_y = (front) ? 0 : -90;
    trans_x = (front) ? x : y;
    trans_y = (front) ? y : x;
    trans_z = -(depth+1);
    color("black")
        rotate([ rot_x, rot_y, 0 ])
            translate([ trans_x, trans_y, trans_z ])
                cylinder(depth+2, diameter / 2, diameter / 2);
}

module annotate_rod(width, depth, length) {
    // front
    // length
    rotate([90,0,0]){
        translate([width+3, 0, 0]){
            color(line_color) square([1,length]);
            translate([2,length/2,0])
                color(text_color) text(str(length), size=text_size);    
        }
    }
    // width
    rotate([90,90,0]){
        translate([-(length+3), 0, 0]){
            color(line_color) square([1,width]);
            translate([-8,width/2,0])
                color(text_color) text(str(width), size=text_size);    
        }
    }
    // side
    // length
    rotate([90,0,-90]){
        translate([-(depth+3), 0, 0]){
            color(line_color) square([1,length]);
            translate([-8,length/2,0])
                color(text_color) text(str(length), size=text_size);    
        }
    }
    // depth
    rotate([0,-90,0]){
        translate([length+2, 0, 0]){
            color(line_color) square([1,depth]);
            translate([2,depth/2,0])
                color(text_color) text(str(depth), size=text_size);    
        }
    }
}

module annotate_hole(front, from_start, x, y, rod_length, rod_width, rod_depth) {
    // front
    if (front) {
        // length
        rotate([ 90, 0, 0 ]){
            if (y < rod_length/2){
                translate([x-0.5,0,0]){
                    color(line_color) square([1,y]);
                    translate([-9,y/2,0])
                        color(text_color) text(str(y), size=text_size);
                }
            } else {
                translate([x-0.5,y,0]){
                    color(line_color) square([1,rod_length-y]);
                    translate([-9,(rod_length-y)/2,0])
                        color(text_color) text(str(rod_length-y), size=text_size);
                }
            }
        }
        // width
        rotate([ 90, 90, 0 ]){
            if (x < rod_width/2){
                translate([-y,0,0]){
                    color(line_color) square([1,x]);
                    translate([1,x/2,0])
                        color(text_color) text(str(x), size=text_size);
                }
            } else {
                translate([-y,x,0]){
                    color(line_color) square([1,rod_width-x]);
                    translate([1,(rod_width-x)/2,0])
                        color(text_color) text(str(rod_width-x), size=text_size);
                }
            }
        }
    // side
    } else {
        // length
        rotate([ 90, 0, -90 ]){
            if (y < rod_length/2){
                translate([-x,0,0]){
                    color(line_color) square([1,y]);
                    translate([-9,y/2,0])
                        color(text_color) text(str(y), size=text_size);
                }
            } else {
                translate([-x,y,0]){
                    color(line_color) square([1,rod_length-y]);
                    translate([-9,(rod_length-y)/2,0])
                        color(text_color) text(str(rod_length-y), size=text_size);
                }
            }
        }
        // width
        rotate([ 0, -90, 0 ]){
            if (x < rod_depth/2){
            
                translate([y,0,0]){
                    color(line_color) square([1,x]);
                    translate([2,x/2,0])
                        color(text_color) text(str(x), size=text_size);
                }
            } else {
                translate([y,x,0]){
                    color(line_color) square([1,rod_depth-x]);
                    translate([1,(rod_depth-x)/2,0])
                        color(text_color) text(str(rod_depth-x), size=text_size);
                }
            }
        }
    }
}

module rod_component(width, depth, length, thickness, holes, color) {
    difference() {
        color(color)
        rod(width, depth, length, thickness);
        for (hole_params=holes){
            front = hole_params[0];
            diameter = hole_params[1];
            x = hole_params[2];
            y = hole_params[3];
            from_start = hole_params[4];
            y_norm = (from_start) ? y : length-y;
            hole_depth = (front) ? depth : width;
            hole(front, hole_depth, diameter, x, y_norm);
        }
    }

    if (annotate){
        annotate_rod(width, depth, length);

        for (i=[0:len(holes)-1]){
            hole = holes[i];
            front = hole[0];
            from_start = hole[4];
            hole_x = hole[2];
            hole_y = hole[3];
            hole_y_norm = (from_start) ? hole_y : length-hole_y;
            annotate_hole(front, from_start, hole_x, hole_y_norm, length, width, depth);
        }
    }
}

// Components
module fr_1a() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 25;
    rod_length = 1500;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 47.5, false],
        [true, 6.5, 12.5, 411.5, false],
        [false, 6.5, 12.5, 436.5, false],
        [false, 6.5, 12.5, 577.5, false],
        [true, 6.5, 12.5, 635, true],
        [false, 6.5, 12.5, 610, true],
        [true, 6.5, 12.5, 585, true],
        [true, 6.5, 12.5, 97.5, true],
        [true, 6.5, 12.5, 62.5, true],
        [true, 6.5, 12.5, 37.5, true],
        [false, 6.5, 12.5, 12.5, true],
    ];
    color = "lightgreen";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

module fr_1b() {
    fr_1a();
}

module fr_2a() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 25;
    rod_length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 37.5, true],
    ];
    color = "red";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

module fr_2b() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 25;
    rod_length = 260;
    holes = [
        [true, 6.5, 12.5, 37.5, false],
        [true, 6.5, 12.5, 95.5, false],
        [true, 6.5, 12.5, 179, false],
        [true, 6.5, 12.5, 37.5, true],
        [false, 6.5, 12.5, 12.5, false],
        [false, 6.5, 12.5, 12.5, true],
    ];
    color = "yellow";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

module fr_2c() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 25;
    rod_length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 105.5, false],
    ];
    color = "orange";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

module fr_3a(){
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 25;
    rod_length = 125;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 37.5, true],
    ];
    color = "lightblue";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

module fr_3b() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 25;
    rod_length = 125;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
    ];
    color = "turquoise";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

module fr_4a() {
    rod_thickness = 4;    
    rod_width = 60;
    rod_depth = 4;
    rod_length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, true],
        [true, 6.5, 60-12.5, 12.5, true],
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 60-12.5, 12.5, false],
        [true, 12.5, 20, 105, true],
    ];
    color = "lightgrey";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}


// Sections
module frame() {
    rotate([ 0, -90, 0 ]) {
        fr_1b();
        translate([ 0, 100, 0 ])
            fr_1b();
        translate([ 185, 0, 0 ]) {
            fr_1a();
            translate([ 0, 100, 0 ])
                fr_1a();
        }
    }
    translate([ -1500 + 35, 0, 0 ]) {
        translate([ 0, -29, 0 ])
            fr_2a();
        translate([ 0, 129, 0 ])
            fr_2a();
    }
    translate([ -1500 + 411 - 12.5, 0, -25 ]) {
        translate([ 0, 25, 0 ])
            fr_2b();
        translate([ 0, 75, 0 ])
            fr_2b();
    }
    translate([ -50, 25, 0 ])
        fr_2a();
    translate([ -50, 75, 0 ])
        fr_2a();
    translate([ -635 - 12.5, 0, 0 ]) {
        translate([ 0, -25, 0 ])
            fr_2c();
        translate([ 0, 125, 0 ])
            fr_2c();
    }
    translate([ -585 - 12.5, 0, 0 ]) {
        translate([ 0, -25, 0 ])
            fr_2c();
        translate([ 0, 125, 0 ])
            fr_2c();
    }
    rotate([ -90, 0, 0 ]) {
        translate([ -1500 + 423.5, 0, 0 ]) {
            translate([ 0, -235, 0 ])
                fr_3a();
            fr_3a();
        }
        translate([ -25, -50, 0 ])
            fr_3a();
        translate([ -25, -185, 0 ])
            fr_3a();
        translate([ -1500 + 565, -50, 0 ])
            fr_3b();    
    }
    translate([-1500,-4,0])
        fr_4a();
    
    translate([-1500,125,0])
        fr_4a();
    
    
}

frame();



module test_component(){
    rod_thickness = 2;    
    rod_width = 25;
    rod_depth = 100;
    rod_length = 125;
    holes = [
        [true, 10, 8, 12.5, false],
        [true, 4, 20, 30, true],
        [false, 12, 15, 50, false],
        [false, 3, 80, 12, true],
    ];
    color = "lightblue";
    rod_component(rod_width, rod_depth, rod_length, rod_thickness, holes, color);
}

// test_component();