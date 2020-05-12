// Der Buegel ueber dem Kopf soll aus einem Torus gemacht werden
#local colorInnerPart = <0.8, 0.4, 0.5>;
#local colorOuterPart =  <0.05, 0.05, 0.05>;

#declare Base = torus {
    200, 140 // major radius, minor radius  
    rotate <90, 0, 0> // <x°, y°, z°>
    translate <0, 25, 0> // <x, y, z>
    pigment {color rgb colorOuterPart}
};

#declare BaseCutter = cylinder {
    <0, 0, -210>, <0, 0, 210>, 335 // center of one end, center of other end, radius
    pigment {color rgb colorInnerPart}
};

#declare Headband = difference {    
    object {Base}
    union {
        object {BaseCutter}
        object {
            BaseCutter
            rotate <90, 0, 0> // <x°, y°, z°>
            translate <0, -210, 0> // <x, y, z>
        }
    }
};

// 2 CSG: 1 Union, 1 Diff