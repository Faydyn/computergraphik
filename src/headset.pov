// Modeling a Headset
// Date: 12.05.2020
// Author: Nils Seitz (218205308)
// 1 Unit of Length correspondents to 1 mm

#version 3.7;



//camera { 
//	location <0.0, 800.0, -1000.0> // fester Standpunkt// Eine Kamera in 80 cm Hoehe, 1 Meter in negativer z-Richtung entfernt location <0.0, 800.0, -1000.0> // fester Standpunkt
//	look_at <0.0, 400.0, 0.0>
//}

 camera {
    location  <4500,8000, -10000.0>
    look_at   <1000.0, 2500.0,  0.0>
}

sky_sphere {
	pigment{ // Himmelskugel - Ein schoener blauer Himmel pigment
		gradient y
		color_map { [0.0 color blue 0.6] [1.0 color rgb 1] }
	}
}
// Eine braune Ebene als Untergrund senkrecht auf der y-Achse durch den Punkt <0, -100, 0> // plane {<A, B, C>, D } where: A*x + B*y + C*z = D
plane { 
    y, -100 
    pigment {color rgb <0.8, 0.6, 0.4>} 
    finish { ambient 0.6 diffuse 0.4}
}

light_source {
	<500, 1500, -120> // Position der Lichtquelle 
	color rgb< 1.0, 1.0, 1.0> // Farbe der Lichtquelle
}

/////////////////////HEADER END /////////////////////////////


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
    cylinder {
        <0, -20, -50>, <0, -10, 50>, 255 // center of one end, center of other end, radius
        
    }
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

#declare Connectors = union {
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


#declare HEADSET = union {
    object {
        Speakers
        translate <0, 225, 0> // <x, y, z>
        scale 1.6*<1.0, 1.0, 1.0> // <x, y, z>
    }
    object{
        Headband
        translate <0, 470, 0> // <x, y, z>
        scale 1.2*<1.0, 1.0, 1.0> // <x, y, z>
    }
    object{
        Connectors
        translate <0, 375, 0> // <x, y, z>
    }
};

// object{HEADSET
// translate <0, -90, 0> // <x, y, z>
// }

#declare Kabine = difference{ 
    box {
        <0, 0, 0>, <3000, 3000, 3000> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        pigment{color rgb colorHeadband}
    }
    box {
        <100, 100, -1>, <2900, 2900, 2900> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
    }
    rotate <0, -45, 0> // <x°, y°, z°>
};

object{Kabine}

object{
    Kabine
    translate <3050, 0, 3050> // <x, y, z>   
}

object{
    Kabine
    translate <6100, 0, 6100> // <x, y, z>   
}







