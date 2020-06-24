annotate=false;
$fa = 1;
$fs = 0.4;
// Building blocks
module rod_25(length){
    difference() {
        cube([ 25, 25, length ]);
        translate([ 2, 2, -1 ])
            cube([ 21, 21, length + 2 ]);
    }
}

module hole25(front, diameter, x, z) {
    rot_x = (front) ? 90 : 0;
    rot_y = (front) ? 0 : -90;
    trans_x = (front) ? x : z;
    trans_y = (front) ? z : x;
    trans_z = -26;
    color("black")
        rotate([ rot_x, rot_y, 0 ])
            translate([ trans_x, trans_y, trans_z ])
                cylinder(27, diameter / 2, diameter / 2);
    
    
    if (annotate){
        text("hello");
    }
}

module rod_component(length, holes, color) {
    difference() {
        color(color)
        rod_25(length);
        for (hole=holes){
            hole_distance = (hole[4]) ? hole[3] : length-hole[3];
            hole25(hole[0], hole[1], hole[2], hole_distance);
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
    length = 1500;
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
    rod_component(length, holes, color);
}

module fr_1b() {
    fr_1a();
}

module fr_2a() {
    length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 37.5, true],
    ];
    color = "red";
    rod_component(length, holes, color);
}

module fr_2b() {
    length = 260;
    holes = [
        [true, 6.5, 12.5, 37.5, false],
        [true, 6.5, 12.5, 95.5, false],
        [true, 6.5, 12.5, 179, false],
        [true, 6.5, 12.5, 37.5, true],
        [false, 6.5, 12.5, 12.5, false],
        [false, 6.5, 12.5, 12.5, true],
    ];
    color = "yellow";
    rod_component(length, holes, color);
}

module fr_2c() {
    length = 210;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 105.5, false],
    ];
    color = "orange";
    rod_component(length, holes, color);
}

module fr_3a(){
    length = 125;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
        [false, 6.5, 12.5, 37.5, false],
        [false, 6.5, 12.5, 37.5, true],
    ];
    color = "lightblue";
    rod_component(length, holes, color);
}

module fr_3b() {
    length = 125;
    holes = [
        [true, 6.5, 12.5, 12.5, false],
        [true, 6.5, 12.5, 12.5, true],
    ];
    color = "turquoise";
    rod_component(length, holes, color);
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