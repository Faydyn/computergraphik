#include "colors.inc"


camera { 
	location <0.0, 800.0, -1000.0> // fester Standpunkt// Eine Kamera in 80 cm Hoehe, 1 Meter in negativer z-Richtung entfernt location <0.0, 800.0, -1000.0> // fester Standpunkt
	look_at <0.0, 400.0, 0.0>
}

sky_sphere {
	pigment{ // Himmelskugel - Ein schoener blauer Himmel pigment
		gradient y
		color_map { [0.0 color blue 0.6] [1.0 color rgb 1] }
	}
}
// Eine braune Ebene als Untergrund senkrecht auf der y-Achse durch den Punkt <0, -100, 0> // plane {<A, B, C>, D } where: A*x + B*y + C*z = D
plane { y, -100 pigment {color rgb <0.8, 0.6, 0.4>} finish { ambient 0.6 diffuse 0.4}}

light_source {
	<500, 1500, -120> // Position der Lichtquelle } co
	color rgb< 1.0, 1.0, 1.0> // Farbe der Lichtquell
}

sphere {<0, 80.0, 0> 80.0}
sphere {<0, 80.0, 0> 80.0 pigment {Red}}
sphere {<0, 80.0, 0> 80.0 pigment {rgb <1.0, 0.0, 0.0>}}

sphere {
	<0, 80.0, 0> 80.0
	 pigment {Red}
}

#declare h_kugel = sphere { 
	<0, 80.0, 0> 80.0
	pigment {Red} 
} 
object {h_kugel}