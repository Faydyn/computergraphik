// Modellierung einer Lupe
// Datum: 30.03.2020  letzte Aenderung: 29.04.2020
// Autor: Bernd Karstens 
// Einheiten 1.0 entspricht 1mm 

#version 3.7;
global_settings{ assumed_gamma 1.3 max_trace_level 10}

#include "colors.inc"
#include "glass.inc"
#include "metals.inc"
#include "woods.inc"


camera{ location  <0,400,280>  
        look_at   <0,2,0>
      }

// Zwei Lichtquellen
light_source {<-140,200, 300> rgb <1.0, 1.0, 0.95>}
light_source {< 0,300,30> rgb <0.9, 0.9, 1.00>}    
//light_source {< 0,300,10> rgb <0.9, 0.9, 1.00> shadowless}    


  
// Ebene unter der Szene
plane { <0,1,0>, -20  // normal vector, distance to zero ----
    texture { 
                pigment{ checker color rgb<0.9,0.20, 0.20> color rgb<0.20,0.2, 0.2> }
	            scale <5.0, 1.0, 15.0>
    } // end of texture
} // end of plane ------------------------------------------


//Objekt zum betrachten
  
cylinder { <-250,2.5,-5>,<200.00, 2.5,-5>, 10.0 
            texture{T_Wood8 scale <5.0, 1.0, 10.0> rotate<0, 90, 0>}      
} // end of cylinder -------------------------------------      
  
  

#declare radius_glass_kugel=250;    // r
#declare radius_linse=60.0;         // h
#declare dicke_lupenrand=12;        // fuer Torusdicke und Stieldicke
#declare stiel_laenge=100;          //
          
#declare abstand=radius_glass_kugel*
     sqrt(1-((radius_linse/radius_glass_kugel)*(radius_linse/radius_glass_kugel))); 


            
union {
    intersection {  // Linse   
        sphere { <-abstand,0,0>, radius_glass_kugel }
        sphere { < abstand,0,0>, radius_glass_kugel }
        material{ // bei glass.inc gefunden und leicht veraendert
          texture { pigment{ color rgbt<1,1,1,0.89>}
                   finish { diffuse 0.1
                            reflection 0.2
                            specular 0.8
                            roughness 0.0003
                            phong 1
                            phong_size 400} 
          } // Ende der Texturbeschreibung
          interior{    
                    ior 1.5   
                    caustics 0.05
                    fade_distance 6.8
                    fade_power 1001
          } // Ende der Interior-Beschreibung
        } // Ende der Material-Beschreibung           
       rotate<0,0,90>  // Linse um 90° um z-Achse rotieren
    
    // 2.Objekt der Vereinigung Metallrand                
    }
    torus { radius_linse, dicke_lupenrand 
        texture{T_Chrome_2E}  // aus metal.inc
    } // end of torus  -------------------------------              

    // 3.Objekt der Vereinigung Holzstiel         
    cylinder { <0,0,radius_linse>,<0,0,radius_linse+stiel_laenge>, dicke_lupenrand
        texture{T_Wood4}   // aus wood.inc
    } // end of cylinder -------------------------------------  
   
    rotate<10,0,0> // leicht schraege stellen
    translate<0, 15, 8.5>   // Lupe  nach oben und in z-Richtungverschieben
}  