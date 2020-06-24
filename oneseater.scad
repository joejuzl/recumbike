// Settings
annotate=false;
$fa = 1;
$fs = 0.4;

// Building blocks
module rod(width, length, thickness){
    inner_width = width-(thickness*2);
    difference() {
        cube([ width, width, length ]);
        translate([ 2, 2, -1 ])
            cube([ inner_width, inner_width, length + 2 ]);
    }
}

module hole(front, rod_width, diameter, x, y) {
    rot_x = (front) ? 90 : 0;
    rot_y = (front) ? 0 : -90;
    trans_x = (front) ? x : y;
    trans_y = (front) ? y : x;
    trans_z = -(rod_width+1);
    color("black")
        rotate([ rot_x, rot_y, 0 ])
            translate([ trans_x, trans_y, trans_z ])
                cylinder(rod_width+2, diameter / 2, diameter / 2);
    
    
    if (annotate){
        text("hello");
    }
}

module rod_component(width, length, thickness, holes, color) {
    difference() {
        color(color)
        rod(width, length, thickness);
        for (hole_params=holes){
            front = hole_params[0];
            diameter = hole_params[1];
            x = hole_params[2];
            y = hole_params[3];
            from_start = hole_params[4];
            y_norm = (from_start) ? y : length-y;
            hole(front, width, diameter, x, y_norm);
        }
    }

    if (annotate){
        color("black"){
            translate([28, 0, 0]){
                rotate([90,0,0]){
                    square([1,length]);
                    translate([2,length/2,0])
                        text(str(length), size=6);    
                }
            
                translate([0, 28, 0]){
                    rotate([90,0,90]){
                        square([1,length]);
                        translate([2,length/2,0])
                            text(str(length), size=6);    
                    }
                }

                for (i=[0:len(holes)-1]){
                    hole = holes[i];
                    hole_length = hole[3];
                    from_start = hole[4];
                    front = hole[0];
                    rot_x = 90;
                    rot_y = 0;
                    rot_z = (front) ? 0 : 90;
                    trans_y = (front) ? 0 : 12.5;
                    trans_x = (front) ? -16 : 0;
                    translate([trans_x, trans_y, 0]){
                            rotate([ rot_x, rot_y, rot_z ]){
                                translate([0, 0, 0]){
                                    if(from_start){
                                        square([1,hole_length]);
                                        translate([-9,hole_length/2,0])
                                            text(str(hole_length), size=6);
                                    } 
                                    else {
                                        translate([0,length-(hole_length),0]){
                                            square([1,hole_length]);
                                            translate([-9,hole_length/2,0])
                                                text(str(hole_length), size=6);
                                        }
                                    }
                                    
                                }
                            }
                        }
                    
                }
            }
            
        }
    }
}

// Components
module fr_1a() {
    rod_thickness = 2;    
    rod_width = 25;
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
    rod_component(rod_width, rod_length, rod_thickness, holes, color);
}

module fr_1b() {
    fr_1a();
}

module fr_2a() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 37.5, true],
    ];
    color = "red";
    rod_component(rod_width, rod_length, rod_thickness, holes, color);
}

module fr_2b() {
    rod_thickness = 2;    
    rod_width = 25;
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
    rod_component(rod_width, rod_length, rod_thickness, holes, color);
}

module fr_2c() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 105.5, false],
    ];
    color = "orange";
    rod_component(rod_width, rod_length, rod_thickness, holes, color);
}

module fr_3a(){
    rod_thickness = 2;    
    rod_width = 25;
    rod_length = 125;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 37.5, true],
    ];
    color = "lightblue";
    rod_component(rod_width, rod_length, rod_thickness, holes, color);
}

module fr_3b() {
    rod_thickness = 2;    
    rod_width = 25;
    rod_length = 125;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
    ];
    color = "turquoise";
    rod_component(rod_width, rod_length, rod_thickness, holes, color);
}

// Parts
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
        translate([ 0, -25, 0 ])
            fr_2a();
        translate([ 0, 125, 0 ])
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
}

frame();
// fr_2a();