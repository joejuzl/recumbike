annotate=true;
$fa = 1;
$fs = 0.4;
// Building blocks
module rod_25(length, color="lightblue"){
    color(color){
        difference() {
            cube([ 25, 25, length ]);
            translate([ 2, 2, -1 ])
                cube([ 21, 21, length + 2 ]);
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
            }
        }
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

// Components
module fr_1a() {
    length = 1500;
    difference() {
        color("lightgreen")
            rod_25(length);
        hole25(true, 6.5, 12.5, length - 12.5);
        hole25(true, 6.5, 12.5, length - 47.5);
        hole25(true, 6.5, 12.5, length - 411.5);
        hole25(false, 6.5, 12.5, length - 436.5);
        hole25(false, 6.5, 12.5, length - 577.5);
        hole25(true, 6.5, 12.5, 635);
        hole25(false, 6.5, 12.5, 610);
        hole25(true, 6.5, 12.5, 585);
        hole25(true, 6.5, 12.5, 97.5);
        hole25(true, 6.5, 12.5, 62.5);
        hole25(true, 6.5, 12.5, 37.5);
        hole25(false, 6.5, 12.5, 12.5);
    }
}

module fr_1b() {
    fr_1a();
}

module fr_2a() {
    length = 210;
    difference() {
        color("red")
            rod_25(length);
        hole25(true, 6.5, 12.5, 12.5);
        hole25(true, 6.5, 12.5, length - 12.5);
        hole25(false, 6.5, 12.5, 37.5);
        hole25(false, 6.5, 12.5, length - 37.5);
    }
}

module fr_2b() {
    length = 260;
    difference() {
        color("yellow")
            rod_25(length);
        hole25(true, 6.5, 12.5, 37.5);
        hole25(true, 6.5, 12.5, 95.5);
        hole25(true, 6.5, 12.5, 179);
        hole25(true, 6.5, 12.5, length - 37.5);
        hole25(false, 6.5, 12.5, 12.5);
        hole25(false, 6.5, 12.5, length - 12.5);
    }
}

module fr_2c() {
    length = 210;
    difference() {
        color("orange") 
            rod_25(length);
        hole25(true, 6.5, 12.5, 12.5);
        hole25(true, 6.5, 12.5, length - 12.5);
        hole25(false, 6.5, 12.5, 37.5);
        hole25(false, 6.5, 12.5, 105.5);
    }
}

module fr_3a() {
    length = 125;
    difference() {
        rod_25(length);
        hole25(true, 6.5, 12.5, 12.5);
        hole25(true, 6.5, 12.5, length - 12.5);
        hole25(false, 6.5, 12.5, 37.5);
        hole25(false, 6.5, 12.5, length - 37.5);
    }
}

module fr_3b() {
    length = 125;
    difference() {
        color("turquoise")
            rod_25(length);
        hole25(true, 6.5, 12.5, 12.5);
        hole25(true, 6.5, 12.5, length - 12.5);
    }
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

// frame();
        
fr_3a();