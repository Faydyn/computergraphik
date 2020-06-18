// Modeling a Headset
// Date: 12.06.2020
// Author: Nils Seitz (218205308)
// 1 Unit of Length correspondents to 1 mm

#version 3.7;
#include "colors.inc"

 camera {
    location  <5000+((3050*(sqrt(2)/2))-5000)*clock-10,4000-3980*clock, -2000+((3050*(sqrt(2)/2))+2000)*clock-10>
    look_at   <3025*(sqrt(2)/2), 2300-2300*clock, 3025*(sqrt(2)/2) >
}
//REALLY NICE PERSPEC
//camera {
//    location  <5000+((3050*(sqrt(2)/2))-5000)*clock,4000-3800*clock, -2000+((3050*(sqrt(2)/2))+2000)*clock>
//    look_at   <3050*(sqrt(2)/2), 2300-2300*clock, 3050*(sqrt(2)/2) >
//}

sky_sphere {
	pigment{ 
		gradient y
		color_map { [0.0 color blue 0.6] [1.0 color rgb 1] }
	}
}
plane { 
    y, -100 
    pigment {color rgb <0.8, 0.6, 0.4>} 
    finish { ambient 0.6 diffuse 0.4}
}
light_source {
	<-300, 2500, -1020> 
	color rgb< 1.0, 1.0, 1.0>
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

object{HEADSET
    translate <0, -40, 0> // <x, y, z>
    scale 0.9*<1.0, 1.0, 1.0>
}


#declare Kabine = difference{ 
    box {
        <0, 0, 0>, <3000, 3000, 3000> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        pigment{color rgb colorHeadband}
    }
    box {
        
        <100, 100, -1>, <2900, 2900, 2900> 
        pigment{Brown}
        // <x, y, z> near lower left corner, <x, y, z> far upper right corner
    }

    rotate <0, -45, 0> // <x°, y°, z°>
   // translate<-korrektur,0, -korrektur >     
};



// Kabinen sollen auf folgender Gerade verschoben werden:
// - in XZ-Ebene
// - 45° zur X-Achse => cos(pi/4) => sqrt(2)/2
// - 45° zur Z-Achse => sin(pi/4) => sqrt(2)/2
// - monoton steigend (vom 3. -> 1. Quadranten)
// Da aber die 
#local ratioSideLength45Degree = 3000*(sqrt(2)/2);
#local ratioSpareDistance45Degree= 50*(sqrt(2)/2);
#local ratiototalLength45Degree = ratioSideLength45Degree + ratioSpareDistance45Degree;

#declare Pointer = cone {
    <0, 0, 0>, 0.1 // <x, y, z>, center & radius of one end
    <-5000, 4000, -5000>, 190 // <x, y, z>, center & radius of the other end
    
} 
object {
    Pointer
    pigment{Green}
}
#declare Pointer2 = cone {
    <(ratioSideLength45Degree), 0, (ratioSideLength45Degree)>, 0.1 // <x, y, z>, center & radius of one end
    <-5000, 4000, -5000>, 190 // <x, y, z>, center & radius of the other end
    
} 
object {
    Pointer2
    pigment{Green}
}
#declare Pointer3 = cone {
    <ratiototalLength45Degree, 0, ratiototalLength45Degree>, 0.1 // <x, y, z>, center & radius of one end
    <-5000, 4000, -5000>, 190 // <x, y, z>, center & radius of the other end
    
} 
object {
    Pointer3
    pigment{Green}
}


//#for (Identifier, Start, End [, Step]) - INCLUSIVE!!!!!! 0,1,2 -> 3x
 #for (i, 0, 2) 
   object{ Kabine
           translate<ratiototalLength45Degree*i,0, ratiototalLength45Degree*i >
         } 
 #end 







