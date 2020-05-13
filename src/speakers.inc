
#local colorOuterPart = <1, 0, 0.3>;
#local colorInnerPart = <0.8, 0.4, 0.5>;
#local colorEarCut =  <0.9, 0.9, 0.9>;

#declare OuterPart = cone {
    <0, -25, 0>, 0 // <x, y, z>, center & radius of one end
    <0, 0, 0>, 70 // <x, y, z>, center & radius of the other end
    pigment {color rgb colorOuterPart}
};

#declare InnerPart = cone {
    <0, 0, 0>, 70 // <x, y, z>, center & radius of one end
    <0, 100, 0>, 100 // <x, y, z>, center & radius of the other end
    pigment {color rgb colorInnerPart}
};

#declare EarCut = cone {
    <0, 60, 0>, 55 // <x, y, z>, center & radius of one end
    <0, 110, 0>, 70 // <x, y, z>, center & radius of the other end
    pigment {color rgb colorEarCut}
};

#declare LeftSpeaker = difference {
    union {
        object {OuterPart}
        object {InnerPart}
    }
    object {EarCut}
    rotate <0, 0, -90> // <x°, y°, z°>
    pigment {color rgb colorEarCut}
    translate <-250,0, 0> // <x, y, z>
};


#declare RightSpeaker = object {
    LeftSpeaker
    rotate <0, 180, 0> // <x°, y°, z°>
};

#declare Speakers = union {
    object {LeftSpeaker}
    object {RightSpeaker}
};
// 3 CSG: 2 Union, 1 Difference
