// Modeling a Headset
// Date: 12.06.2020
// Author: Nils Seitz (218205308)
// 1 Unit of Length correspondents to 1 mm

#version 3.7;
#include "colors.inc"
#include "textures.inc"
#include "rotationsvase.inc"

// 1. CLOSE-UP CAMERA
 camera {
    location  <50, 2060, 2790 >
    look_at   <450, 0, 3000 >
}


// camera {
//    location  <-1700+((150*(sqrt(2)/2))-1500)*clock-10,4000-2200, 2400+((150*(sqrt(2)/2))+1200)*clock-10>
//    look_at   <400*(sqrt(2)/2), 500, 00*(sqrt(2)/2) >
//}
//
//camera {
//    //location <5500+10000*sin(2*pi*clock), 3800, 6500-10000*cos(2*clock*pi)> 
//    location  <1700+((3050*(sqrt(2)/2))-5000)*clock-10,3800, -3700+((3050*(sqrt(2)/2))+2000)*clock-10>
//    look_at   <2000*(sqrt(2)/2), 2100, 1600*(sqrt(2)/2) >
//}
//REALLY NICE PERSPEC
//camera {
//    location  <5000.0*sin(clock*2*pi), 4800.0, -5000.0*cos(clock*2*pi)> 
//    //location  <3000+((-999*(sqrt(2)/2))-3000)*clock,4000-3800*clock, -2000+((1899*(sqrt(2)/2))+2000)*clock>
//    look_at   <5000*(sqrt(2)/2), 500, 19000*(sqrt(2)/2) >
//}


//  sky_sphere {
//    pigment {
//      gradient y
//      color_map {
//        [(1-cos(radians(100)))/2 color rgb <0.8, 0.1, 0>]
//        [(1-cos(radians(190)))/2 color Blue]
//      }
//      scale 2
//      translate -1
//    }
//  }
//https://www.povray.org/documentation/view/3.6.1/91/
//http://www.f-lohmueller.de/pov_tut/tex/tex_160e.htm
// http://texlib.povray.org/wood-browsing_1.html
// http://www.imagico.de/imenu/insert_menu.php
#declare Photons=on;

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
  #if (Photons)          // global photon block
    photons {
      spacing 0.02                 // specify the density of photons
      count 10000               // alternatively use a total number of photons

      //gather min, max            // amount of photons gathered during render [20, 100]
      //media max_steps [,factor]  // media photons
      //jitter 1.0                 // jitter phor photon rays
      //max_trace_level 5          // optional separate max_trace_level
      //adc_bailout 1/255          // see global adc_bailout
      //save_file filename       // save photons to file
      //load_file filename       // load photons from file
      //autostop 0                 // photon autostop option
      //radius 10                  // manually specified search radius
      // (---Adaptive Search Radius---)
      //steps 1
      //expand_thresholds 0.2, 40
    }

  #end
}

#declare M_Glass=    // Glass material
material {
  texture {
    pigment {rgbt <1,1,1,0.8>}
    finish {
      ambient 0.0
      diffuse 0.05
      specular 0.6
      roughness 0.005
      reflection {
        0.1, 1.0
        fresnel on
      }
      conserve_energy
    }
  }
  interior {
    ior 1.5
    fade_power 1001
    fade_distance 0.9
    fade_color <0.5,0.8,0.6>
  }
}
  sky_sphere {
      
    pigment {
      gradient y
      color_map {
        [0.000 0.002 color rgb <1.0, 0.2, 0.0>
                     color rgb <1.0, 0.2, 0.0>]
        [0.002 0.200 color rgb <0.8, 0.1, 0.0>
                     color rgb <0.2, 0.2, 0.3>]
      }
      scale 2
      translate -1
    }
    pigment {
      bozo
      turbulence 0.65
      octaves 6
      omega 0.7
      lambda 2
      color_map {
          [0.0 0.1 color rgb <0.85, 0.85, 0.85>
                   color rgb <0.75, 0.75, 0.75>]
          [0.1 0.5 color rgb <0.75, 0.75, 0.75>
                   color rgbt <1, 1, 1, 1>]
          [0.5 1.0 color rgbt <1, 1, 1, 1>
                   color rgbt <1, 1, 1, 1>]
      }
      scale <0.2, 0.5, 0.2>
    }
    rotate -135*x
  }

plane {               // checkered floor
  y, -100
  texture
  {
    pigment {
      checker
      color rgb (1/256)*<25, 16, 8>
      color rgb (1/256)*<47, 32, 15>
      scale 200
    }

  }
 
}
//light_source {
//	<500, 2500, 1500> 
//	color rgb 0.8*< 1.0, 1.0, 1.0>
//    photons {           // photon block for a light source
//    refraction on
//    reflection on
//  }
//}
//
//light_source {
//	<3000, 2500, -1500> 
//	color rgb 0.8*< 1.0, 0.3, 0.3>
//    photons {           // photon block for a light source
//    refraction on
//    reflection on
//  }
//}

#declare Sonne =  
   light_source
   {
        <100000, 1000.0, 1100000.0>         // Position der Lichtquelle
        color rgb <0.8, 0.1, 0>       // Farbe des Lichtes
                // Art der Lichtquelle
        
        
                   // Abschwaechung zum Rand
                 // falloff (auesserer Radius in Grad)  
        // Darstellung der Lichtquelle in der Szene als durchsichtige Kugel
        looks_like { 
                sphere { <0, 0, 0>, 400000 
                
                pigment { 
                    gradient y
      color_map {
        [0.5 color rgb <0.8, 0.1, 0>]
        [1 color Blue]
      }}
                finish {ambient 0.6} 
                }
        }
   }
   object{Sonne}
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
            translate <0, 10, 0> // <x, y, z>
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
    translate <410, -15, 0> // <x, y, z>
    scale 0.6*<1.0, 1.0, 1.0> // <x, y, z>
};

#declare Holder = cylinder {
    <0, 0, -190>, <0, 0, -130>, 23 // center of one end, center of other end, radius
    rotate <15, 0, 0> // <x°, y°, z°>
    translate <245, -65, 0> // <x, y, z>
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
        translate <-490, 0, 0> // <x, y, z>
    } 
    object {
        Holder
        rotate <0, 180, 0> // <x°, y°, z°>
    }
    object {
        Holder
        translate <-490, 0, 0> // <x, y, z>
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
        translate <0, 365, 0> // <x, y, z>
        scale <1.4, 1.0, 1.0> // <x, y, z>
    }
};




// 2x2m und 20cm dick


#declare Kabine = difference{ 
    box {
        <0, 0, 0>, <3005, 3010, 3010> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
       
        material { M_Glass }

  photons {  // photon block for an object
    target 1.0
    refraction off
    reflection off
  }
    }
    box {
        <-1, 5, -1>, <3000, 3005, 3005>
        //<5, 5, -1>, <3005, 3005, 3005> CLOSED SIDES 
        
         material { M_Glass }

  photons {  // photon block for an object
    target 1.0
    refraction on
    reflection on
  }
    }

    rotate <0, -45, 0> // <x°, y°, z°>
     
};





// Kabinen sollen auf folgender Gerade verschoben werden:
// - in XZ-Ebene
// - 45° zur X-Achse => cos(pi/4) => sqrt(2)/2
// - 45° zur Z-Achse => sin(pi/4) => sqrt(2)/2
// - monoton steigend (vom 3. -> 1. Quadranten)
// Strecke ist Länge der Kabine (3000mm = 300cm = 3m) + Abstand (500mm = 50 cm = 0.5m)

#local ratio45Degree = (sqrt(2)/2);
#local ratioDistanceToWall45Degree = 900*ratio45Degree;
#local ratioLength45Degree = 3500*ratio45Degree; 

//#for (Identifier, Start, End [, Step]) - INCLUSIVE!!!!!! 0,1,2 -> 3x
 
#declare VaseMitBall = union{
object {
    Vase
    pigment{Silver}
    scale 25*<1.0, 1.0, 1.0> // <x, y, z>
    translate <0, 101, 1800> // <x, y, z>
    rotate <0, -45, 0> // <x°, y°, z°>
    translate <450*ratio45Degree, 0, 450*ratio45Degree> // <x, y, z>
    finish {
        specular 0.25
        roughness .05
        reflection { 
            0.9 metallic 
        }
        brilliance 4
        
    }
}

light_source
   {
        <0.0, 60.0, 0.0>         // Position der Lichtquelle
        color rgb <1,1,1>       // Farbe des Lichtes
  //      spotlight               // Art der Lichtquelle
  //      point_at <0, -10, 0>      // Richtung des Spotlichtes
  //      radius 360              // hotspot (innerer Radius in Grad)
  //      tightness 0             // Abschwaechung zum Rand
  //      falloff 0              // falloff (auesserer Radius in Grad)  
        // Darstellung der Lichtquelle in der Szene als durchsichtige Kugel
        translate <0, 101, 1800> // <x, y, z>
    rotate <0, -45, 0> // <x°, y°, z°>
    translate <450*ratio45Degree, 2*pi*250+69, 450*ratio45Degree> // <x, y, z>
        looks_like { 
                sphere {
    <0, 0, 0>, 100 // <x, y, z>, radius
    
   pigment{White}
}
        }
   }

}

#declare Tisch = union{ 
    box {
        <0, 900, 0>, <2000, 1100, 2000> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
    }
    cylinder {
        <50, 0, 50>, <50, 900, 50>, 40 // center of one end, center of other end, radius
    }
    cylinder {
        <1950, 0, 50>, <1950, 900, 50>, 40 // center of one end, center of other end, radius
    }
    cylinder {
        <50, 0, 1950>, <50, 900, 1950>, 40 // center of one end, center of other end, radius
    }
    cylinder {
        <1950, 0, 1950>, <1950, 900, 1950>, 40 // center of one end, center of other end, radius
    }
    pigment { color rgb <0.254, 0.102 , 0.018> }
    finish { 
        ambient 0.4 
        diffuse 1  
        roughness 1
        reflection { 
                0.05 
        }
    }
    texture {
        Cork
        scale 800*<1.0, 1.0, 1.0> // <x, y, z>
        rotate -45*y
    }
              
        
    
};



#for (i, 0, 0) 
union{
    //object{ Kabine } 
    
        object{
            HEADSET
            scale 0.9*<1.0, 1.0, 1.0>
            rotate <105.9, 0, 0> // <x°, y°, z°> - Neige etwas mehr als 90°
            translate <ratioDistanceToWall45Degree-500*ratio45Degree, 1354, ratioDistanceToWall45Degree+2500*ratio45Degree> // <x, y, z>
        }
    // Es wurde mittel Intersection geprüft, ob Tisch und Headset sich schneiden
        object{
            Tisch
            translate<0,0,900>
            rotate <0, -45, 0> // <x°, y°, z°>
            translate <ratioDistanceToWall45Degree, 0, ratioDistanceToWall45Degree> // <x, y, z>
        }
    
   //object{ VaseMitBall } 

translate<ratioLength45Degree*i,0, ratioLength45Degree*i >
}

#end 
