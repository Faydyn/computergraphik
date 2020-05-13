#include "headband.inc"

#declare Connector = object {
    Headband
    rotate <0, 90, 0> // <x°, y°, z°>
    translate <550, 0, 0> // <x, y, z>
    scale 0.6*<1.0, 1.0, 1.0> // <x, y, z>
};

#declare Holder = cylinder {
    <0, 0, -190>, <0, 0, -130>, 23 // center of one end, center of other end, radius
    rotate <15, 0, 0> // <x°, y°, z°>
    translate <330, -50, 0> // <x, y, z>
}

##declare Connectors = union {
    object {Connector}
    object {
        Connector
        rotate <0, 180, 0> // <x°, y°, z°>
    }
    object {Holder}
    object {
        Holder
        translate <-660, 0, 0> // <x, y, z>
    } 
    object {
        Holder
        rotate <0, 180, 0> // <x°, y°, z°>
    }
    object {
        Holder
        translate <-660, 0, 0> // <x, y, z>
        rotate <0, 180, 0> // <x°, y°, z°>
    }
};