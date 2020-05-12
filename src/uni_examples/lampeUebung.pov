// Modellierung einer Schreibtischlampe
// Datum: 30.03.2001  letzte Aenderung: 29.04.2020
// Autor: Bernd Karstens 
// Einheiten 1.0 entspricht 1mm 



#version 3.7 


#include "colors.inc"

// Eine Kamera in 800 mm Hoehe, 1 Meter in negativer z-Richtung entfernt
camera
{
 //   location  <40.0, 300.0, -300.0>  // fester Standpunkt
      location  <0.0, 800.0, -1000.0>  // fester Standpunkt  
 //    location  <1000.0*sin(clock*2*pi), 800.0, -1000.0*cos(clock*2*pi)> /
     look_at   <0.0, 400.0,  0.0> 
     direction 1.0*z
}
/* Zur Animation unter Menue: Render         
              -> Edit Settings/Renderer
              -> Command Line Option eintragen: +KFF36
 dann werden 36 Bilder gerendert und die Variable clock
 durchlaueft das Intervall von 0.0 bis 1.0 in Schritten von 1/36
 Die Kamera in 800 mm Hoehe auf einem Kreis von 1 Meter Durchmesser
 camera {
    location  <1000.0*sin(clock*2*pi), 800.0, -1000.0*cos(clock*2*pi)>
    look_at   <0.0, 400.0,  0.0>
}
*/ 


// Ein schoener blauer Himmel (gefunden im Insert-Menue)
sky_sphere
{
  pigment
  {
    gradient y
    color_map { [0.0 color blue 0.6] [1.0 color rgb 1] }
  }
}   

// Eine braune Ebene als Untergrund senkrecht auf der y-Achse
// durch den Punkt <0, -100, 0> 
// plane {<A, B, C>, D } where: A*x + B*y + C*z = D
plane { y, -300 pigment {color rgb <0.8, 0.6, 0.4>} finish { ambient 0.6 diffuse 0.4}} 
  

// Eine weisse Lichtquelle leicht schraeg von oben
light_source
{
  <500, 1500, -120>             // Position der Lichtquelle
  color rgb< 1.0, 1.0, 1.0>     // Farbe der Lichtquelle
} 

// Kameralicht eine zweite Lichtquelle aus Richtung der Kamera
light_source
{
  <40, 300, -1000>              // Position der Lichtquelle
  color rgb< 0.5, 0.5, 0.5>     // Farbe der Lichtquelle
} 


// ------------------------------------------------------
// Die Modellierung kann beginnen:
// Hilfsobjekte

#declare h_kegel =  
      cone {   // Kegelstumpf
             < 0.0, 120.0, 0.0>, 0.0,  // oberer Mittelpunkt und Radius
             < 0.0,  0.0, 0.0>, 95.   // unterer Mittelpunkt und Radius 
}
#declare h_kugel = sphere {<0, 80.0, 0> 80.0}
#declare h_grosser_zylinder = cylinder { <0, 80.0, 0>, <0, 170.0, 0>, 30.}
#declare h_kleiner_zylinder = cylinder { <0, 70.0, 0>, <0, 150.0, 0>, 28.}



// ------------------------------------------------------
// CSG-Modellierung  

// Experimente aus der Online Uebung

/*  
	  
#declare h_kugel =	  
	sphere {<0, 80, 0> 80 
	        pigment {Red}
	}  
	  
object {h_kugel}      
      
 */ 
 /*
difference { 
 difference {  
   union {  
    intersection {  
        object{h_kugel}
        object{h_grosser_zylinder}
        pigment {Yellow}
    }
    object {h_kegel}
    pigment {Magenta}
    }
    object { h_kleiner_zylinder}
    }                   
    object {h_kegel translate <0, -1, 0>}   
    pigment{ Gray}
    rotate <135, 0, 0>
    }            
                   
  */                 
      
      
      
      
      
      
      
                
                
                
                
                
                
                
      



//  Hier eine m�gliche Musterl�sung :
//-------------------------------------------------------------------------------------------

// Lampenschirm
#declare lampe =
   difference {
     difference {
        union {
           intersection {
                object {h_grosser_zylinder}
                object {h_kugel} 
               // pigment {Yellow}
                }
           object {h_kegel}
           pigment {Red}
         }
      object {h_kleiner_zylinder}
       pigment {Silver}
       finish { ambient 0.3 diffuse 0.3 specular 0.4} 
     }
    
    object {h_kegel translate<0.0,-1.0, 0.0>}
      pigment {Silver}
      finish { ambient 0.3 diffuse 0.3 specular 0.4}
   }  


// Befestigung des Schirms aus 2 Tori
#declare befestigung =
union {
  torus { // Torus in X-Z-Ebene definiert
    10.0, 3.0 
    pigment {Yellow}
    rotate<90.0, 0.0, 0.0>
  }
  torus {
    10.0, 3.0 
    pigment {Yellow}
  }
 rotate<0.0, 0.0, 90.0> 
 translate<0.0, 160.0, 0.0> 
}


// 4 Stangen und Halbkugel  
#declare laenge = 350.0;
#declare stange = 
 union {
         sphere     {<0.0, 0.0, 0.0>, 8.0 pigment {Gray70}}
         cylinder   {<0.0, 0.0, 0.0>, <0.0, laenge, 0.0>, 8.0 
                        pigment {Gray70}}
         sphere     {<0.0, laenge, 0.0>, 8.0 pigment {Gray70}}
} 
 
#declare lampengestaenge = 
union {   // 4 Stangen 
 object {stange translate<0.0, 0.0, -20.>
                rotate <0.0, 0.0, 30.0>}
 object {stange translate<0.0, 0.0, 20.>
                rotate <0.0, 0.0, 30.0>}
 object {stange translate<0.0, 0.0, -20.0>
                rotate <0.0, 0.0, -30.0>
                translate<laenge*sin(-pi/6),laenge*cos(-pi/6), 0.0>}
 object {stange translate<0.0, 0.0, 20.0>
                rotate <0.0, 0.0, -30.0>
                translate<laenge*sin(-pi/6),laenge*cos(-pi/6), 0.0>}
} 

#declare lampenfuss =                
 union {  // Eine Halbkugel mit Schalter
   difference {
     sphere { <0.0, 0.0, 0.0>, 100.0 }
     box {<-110.0, 0.0, -110.0>,<110.0, -110.0, 110.0>}
     cylinder { <0.0, -50.0, 0.0>, <0.0, 50.0, 0.0>, 15.0
          pigment {Blue}
          rotate<0.0, 0.0, -45.0> 
          translate<100.0*sin(pi/4), 100.0*sin(pi/4), 0.0>
     }
     texture { pigment {Red} 
               normal {bumps 0.7 scale 1} 
               finish {ambient 0.3 diffuse 0.5 specular 0.7 
                                reflection {0.2 metallic}}}
   }
   cylinder { <0.0, -50.0, 0.0>, <0.0, 30.0, 0.0>, 5.0
          pigment {Gold}
          finish { ambient 0.4 diffuse 0.4 specular 0.8 roughness .1}
          rotate<0.0, 0.0, -45.0> 
          translate<100.0*sin(pi/4), 100.0*sin(pi/4), 0.0>
   }   
 }  



        
// Spielerei mit Licht
#declare licht_in_der_lampe =  
   light_source
   {
        <0.0, 60.0, 0.0>         // Position der Lichtquelle
        color rgb <1,1,1>       // Farbe des Lichtes
        spotlight               // Art der Lichtquelle
        point_at <0, -10, 0>      // Richtung des Spotlichtes
        radius 45               // hotspot (innerer Radius in Grad)
        tightness 1             // Abschwaechung zum Rand
        falloff 75              // falloff (auesserer Radius in Grad)  
        // Darstellung der Lichtquelle in der Szene als durchsichtige Kugel
        looks_like { 
                sphere { <0.0, 0.0, 0.0>, 30 
                double_illuminate
                pigment { color rgbt <1.0, 1.0, 1.0, 0.2> }
                finish {ambient 0.6} 
                }
        }
   }



 

// Spielereien mit Roations- und Verschiebek�rpern
/*
 // extrude a closed 2-D shape along an axis
prism {                                
  linear_sweep  // or conic_sweep for tapering to a point
  linear_spline // linear_spline | quadratic_spline | cubic_spline | bezier_spline 
  -5.0,         // height 1
   5.0,         // height 2
  9,           // number of points
  // (--- the <u,v> points ---)
   
  < -25.0, -25.0>, < -40.0,  25.0>, < 40.0, 25.0>, < 25.0,  -25.0>, < -25.0,  -25.0>, 
 
  
   
  <-10.0,  -10.0>, <0.0,  10.0>, <10.0, -10.0>, <-10.0,  -10.0> 
  
  // [open]
  // [sturm] 
  pigment {Red}
  rotate <0.0, 0.0, 0.0>
} 
*/  

/*
// create a Surface of Revolution shape (like lathe, but faster)
sor { 
 //   quadratic_spline
    12, // # of points
    <0.0, 0.0> // list of <u,v> points
    <30.0, 0.0>
    <29.0, 2.0>
    <4.0,  4.0>
    <3.0,  5.0>
        
    <3.0,  68.0>
    <10.0, 70.2>
    <20.0, 72.0>
    <30.0, 80.0> 
    <40.0, 100.0>
       
    <45.0, 116.0>
    <43.0, 116.0>
//    <38.0, 100.0>
 //   <28.0, 80.0>
 //   <18.0, 72.0>
    
 //   <0.0, 72.0>    
    // [open]
    pigment {Yellow}
}
*/  
   
#declare gelenk =
prism {                                
  linear_sweep  // or conic_sweep for tapering to a point
  cubic_spline // linear_spline | quadratic_spline | cubic_spline | bezier_spline 
  -32.0,         // height 1
   32.0,         // height 2
  13,           // number of points
  // (--- the <u,v> points ---)
  < 25.0,  -25.0>,  
  < -25.0, -25.0>, < -40.0,  25.0>, < 40.0, 25.0>, < 25.0,  -25.0>, < -25.0,  -25.0>, 
  < -40.0,  25.0>,  
  
  <10.0, -10.0>, 
  <-10.0,  -10.0>, <0.0,  10.0>, <10.0, -10.0>, <-10.0,  -10.0> ,
  <0.0,  10.0>
  // [open]
  // [sturm] 
  pigment {Red}
  rotate <-90.0, 0.0, 0.0> 
  rotate <0.0, 0.0, 90.0>
  translate<laenge*sin(-pi/6),laenge*cos(-pi/6), 0.0>
} 
       


 
// fertiger Lampenschirm        
#declare lampe_mit_licht =
union {
   object {lampe}
   object {befestigung}
   licht_in_der_lampe 
}
  
  
// fertige Lampe ohne Gelenk  
#declare fertige_lampe =
union {
   object {lampe_mit_licht
    translate <0.0, -170.0, 0.0>
                rotate<0.0, 0.0, 60.0>
                translate <0.0, 2*laenge*cos(-pi/6)-10.0, 0.0>
   } 
  object {lampengestaenge}
  object {gelenk}
  object {lampenfuss}
}   
   
// -----------------------------------------------------------
// Darstellung der Szene


//object {lampe}
//object {stange } 
object {fertige_lampe}
