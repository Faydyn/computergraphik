// Modeling a Headset
// Date: 12.05.2020
// Author: Nils Seitz (218205308)
// 1 Unit of Length correspondents to 1 mm

#version 3.7;

#include "colors.inc"
#include "speakers.inc"
#include "headband.inc"


//camera { 
//	location <0.0, 800.0, -1000.0> // fester Standpunkt// Eine Kamera in 80 cm Hoehe, 1 Meter in negativer z-Richtung entfernt location <0.0, 800.0, -1000.0> // fester Standpunkt
//	look_at <0.0, 400.0, 0.0>
//}

 camera {
    location  <1000.0*sin(clock*2*pi), 800.0, -1000.0*cos(clock*2*pi)>
    look_at   <0.0, 400.0,  0.0>
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

#declare HEADSET = union{
    object {
        Speakers
        translate <0, 200, 0> // <x, y, z>
        scale 1.5*<1.0, 1.0, 1.0> // <x, y, z>
    }
    object{
        Headband
        translate <0, 440, 0> // <x, y, z>
    }
};

object{HEADSET}









