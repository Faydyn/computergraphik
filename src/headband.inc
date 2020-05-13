// Der Buegel ueber dem Kopf soll aus einem Torus gemacht werden
#local colorHeadband = <0.9, 0.9, 0.9>;
#local colorInside =  <1, 0, 0.3>;

#declare Base = torus {
    280,40 // major radius, minor radius  
    rotate <90, 0, 0> // <x°, y°, z°>
    pigment {color rgb colorHeadband}
};


#declare Cutoff = union {
    cylinder {
        <0, -325, 0>, <0, -30, 0>, 300 // center of one end, center of other end, radius
    }
    
//    cylinder {
//        <0, -20, -50>, <0, -10, 50>, 255 // center of one end, center of other end, radius
//        
//    }
};

#declare Headband = difference{
    intersection {
        object {Base}
        object {
            Base
            translate <0, -33, 0> // <x, y, z>
        }
         object {
            Base
            translate <-25, 0, 0> // <x, y, z>
        }
         object {
            Base
            translate <25, 0, 0> // <x, y, z>
        }
    }
    object {Cutoff}
    
};

// 2 CSG: 1 Intersection (3 für Binaerbaum), 1 Diff