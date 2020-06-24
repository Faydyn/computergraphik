/* 
Date: 24.06.2020
Author: Nils Seitz (218205308)
1 Unit of Length correspondents to 1 mm

Quellen:
- https://www.povray.org/documentation/view/3.6.1/91/
- http://www.f-lohmueller.de/pov_tut/tex/tex_160e.htm
- http://texlib.povray.org/wood-browsing_1.html
- http://www.imagico.de/imenu/insert_menu.php

Die relevanten Zeilen werden jeweils mit einem Buchstaben fuer die jeweilige Aufgabe in eckigen Klammern gekennzeichnet:
Beispielsweise [F], falls die naechsten Zeilen fuer Aufgabe f) relevant sind.
*/

/////////////////////HEADER/////////////////////////////
#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "rotationsvase.inc"

// Angabe der 3 Kamerapositionen [F] - jeweils auskommentieren, ueberschreiben sich -> letzte zaehlt
camera{
// 1. Nahaufnahme des Kopfhoerers
// [E]: sinnvolle Texturskalierungen - Tisch,
//      Schatten: Schatten des Kopfhoerers selbst
    location  <0, 1960, 2590>
    look_at   <450, 500, 3000>

// 2. Blick-schraeg-von-oben-in alle-Kabinen
// [E]: sinnvolle Texturskalierungen - Tisch,
//      Spiegelungen - Tischspiegelung im Boden, Glaskabine z.B. das orange Licht auf dem Dach oder blaue Licht der Lampen in der seitlichen Scheibe
//      Schatten: Schatten der Kabinen von den Lampen in den Kabinen, Schatten des Lampenstaenders
//      Lichtbrechung (Lampe, Tisch, Bild von oben durch Dachglas zu sehen)
    location  <2890,4700, -3790>
    look_at   <2900*(sqrt(2)/2), 2500, 1900*(sqrt(2)/2)>

// 3. selbstgewaehlte interessante Position
// [E]: sinnvolle Texturskalierungen - Tisch,
//      Spiegelungen - In dem Lampenstaender spiegeln sich Kabine, Himmel und Erde

    //location  <-200,2050, 300>
    //look_at   <-750*(sqrt(2)/2), 1400, 3800*(sqrt(2)/2)>
}

// Boden mit Schachbrettmuster parallel zu je X- bzw. Z-Achse -> "Fliesen"
// Als visuelle Hilfe: Kabinen diagonal zu Muster -> nichtachsenparallelen Gerade [D]
plane{    
    y, -100
    texture{
        pigment{
            checker
            color rgb (1/256)*<25, 16, 8>
            color rgb (1/256)*<47, 32, 15>
            scale 200
        }
    }
}

// Ein Himmel mit Wolken und Abendrot
sky_sphere{
    pigment{
        gradient y
        color_map{
            [0.000 0.002 color rgb <1.0, 0.2, 0.0>
                            color rgb <1.0, 0.2, 0.0>]
            [0.002 0.200 color rgb <0.8, 0.1, 0.0>
                            color rgb <0.2, 0.2, 0.3>]
        }
        scale 2
        translate -1
    }

    pigment{
        bozo
        turbulence 0.65
        octaves 6
        omega 0.7
        lambda 2
        color_map{
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

// Dazu eine Riesensonne, die das Abendrot erklaert
#declare Sonne = light_source{
    <500000, 1000.0, 4400000.0>        
    color rgb <0.8, 0.1, 0>       
    looks_like{
        sphere{
            <0, 0, 0>, 900000
            pigment{
                gradient y
                color_map{
                    [0 color rgb <0.8, 0.1, 0>]
                    [1 color <0.8, 0.1, 0.1>]
                }
            }
            finish{ambient 0.6}
        }
        scale <1.0, 0.78, 1.0> // <x, y, z>
    } 
}

object{Sonne} // [E] sichtbar auf Dach der Kabinen

///////////////////// ^ HEADER / SETUP v /////////////////////////////

#declare Photons=on; // Fuer Glass als Material
global_settings{
    assumed_gamma 1.0
    max_trace_level 5

    #if (Photons)
        photons{
            spacing 0.02
            count 10000
        }
    #end
}

// Material der Kabinen [E]
#declare M_Glass = material{
    texture{
        pigment{rgbt <1,1,1,0.8>}
        finish{
            ambient 0.0
            diffuse 0.05
            specular 0.6
            roughness 0.005
            reflection{
                0.1, 1.0
                fresnel on
            }
            conserve_energy
        }
    }

    interior{
        ior 1.5
        fade_power 1001
        fade_distance 0.9
        fade_color <0.5,0.8,0.6>
    }
}

// Farben
#local colorOuterPart = <1, 0, 0.3>;
#local colorInnerPart = <0.8, 0.4, 0.5>;
#local colorEarCut =  <0.9, 0.9, 0.9>;
#local colorHeadband = <0.9, 0.9, 0.9>;
#local colorInside =  <1, 0, 0.3>;
#local cabinLightColor = <0.1,0.8,0.9>;

///////////////////// ^ SETUP / CODE v /////////////////////////////
///////////////////// Headset v [A]

#declare OuterPart = cone{
    <0, -25, 0>, 0 // <x, y, z>, center & radius of one end
    <0, 0, 0>, 70 // <x, y, z>, center & radius of the other end
    pigment{color rgb colorOuterPart}
};

#declare InnerPart = cone{
    <0, 0, 0>, 70 // <x, y, z>, center & radius of one end
    <0, 100, 0>, 100 // <x, y, z>, center & radius of the other end
    pigment{color rgb colorInnerPart}
};

#declare EarCut = cone{
    <0, 60, 0>, 55 // <x, y, z>, center & radius of one end
    <0, 110, 0>, 70 // <x, y, z>, center & radius of the other end
    pigment{color rgb colorEarCut}
};

// Ohrmuschel aus 3 Teilen
#declare LeftSpeaker = difference{
    union{
        object{OuterPart}
        object{InnerPart}
    }

    object{EarCut}

    rotate <0, 0, -90> // <x°, y°, z°>
    pigment{color rgb colorEarCut}
    translate <-250,0, 0> // <x, y, z>
};

#declare RightSpeaker = object{
    LeftSpeaker
    rotate <0, 180, 0> // <x°, y°, z°>
};

// "Spiegelung" bzw. Rotation einer zweiten Ohrmuschel, um ein Hoererpaar zu kreiieren 
#declare Speakers = union{
    object{LeftSpeaker}
    object{RightSpeaker}
};

// Der Bügel über dem Kopf soll aus der Schnittmenge 4 identischer Tori gemacht werden 
#declare Base = torus{
    280,40 // major radius, minor radius  
    rotate <90, 0, 0> // <x°, y°, z°>
    pigment{color rgb colorHeadband}
};

//Die beiden Zylinder bilden ein "Kreuz".
#declare Cutoff = union{
    cylinder{
        <0, -325, 0>, <0, -30, 0>, 300 // center of one end, center of other end, radius
    } 
    cylinder{
        <0, -20, -50>, <0, -10, 50>, 255 // center of one end, center of other end, radius
    }    
};

// Die Schnittmenge der Tori erzeugt ein dünnes Kopfband, welches von dem Zylinderkreuz ausgehoelt und seitlich abgeschnitten wird ("halbiert"), sodass es wie der Bügel aussieht.
#declare Headband = difference{
    intersection{
        object{Base}
        object{
            Base
            translate <0, 10, 0> // <x, y, z>
        }
        object{
            Base
            translate <-25, 0, 0> // <x, y, z>
        }
        object{
            Base
            translate <25, 0, 0> // <x, y, z>
        }
    }

    object{Cutoff}
};

#declare Connector = object{
    Headband
    rotate <0, 90, 0> // <x°, y°, z°>
    translate <410, -15, 0> // <x, y, z>
    scale 0.6*<1.0, 1.0, 0.9> // <x, y, z>
};

#declare Holder = cylinder{
    <0, 0, -200>, <0, 0, -120>, 23 // center of one end, center of other end, radius
    rotate <15, 0, 0> // <x°, y°, z°>
    translate <245, -65, 25> // <x, y, z>
};

// Accessories: Kopfbügel in klein wiederverwenden mit "Schrauben", dass sich die Ohrmuscheln drehen koennen
#declare Connectors = union{
    object{Connector}

    object{
        Connector
        rotate <0, 180, 0> // <x°, y°, z°>
    }

    object{Holder}

    object{
        Holder
        translate <-490, 0, 0> // <x, y, z>
    }
    
    object{
        Holder
        rotate <0, 180, 0> // <x°, y°, z°>
    }

    object{
        Holder
        translate <-490, 0, 0> // <x, y, z>
        rotate <0, 180, 0> // <x°, y°, z°>
    }
};

// Zusammensetzung der 3 Hauptteile
#declare HEADSET = union{
    object{
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

///////////////////// ^ Headset [A] / Kabine v [C,D,E,F]/////////////////////////////

// Kabine ist eine Flaeche von 3x3 Metern mit 3m Hoehe, und ausserdem 
#declare Kabine = union{
    difference{
        box{
            <0, 0, 0>, <3005, 3010, 3005> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
            material{M_Glass}
            photons{
                target 1.0
                refraction off
                reflection off
            }
        }

        box{ // Herausschneiden der gewuenschten Grundflaeche von 3000mm x 3000mm [C]
            <-1, 5, -1>, <3000, 3005, 3000>   // y=5, da Kabine einen Boden braucht, x=z=-1 fuer sichere Differenz (bei =0 manchmal komisch)     
            material{M_Glass}
            photons{
                target 1.0
                refraction on
                reflection on
            }
        }
    }

    // Rand der Szene: Wand genau ueber der Kabine mit Nahaufnahme [C] 
    object{
        box{
            <0,5,0>, <3000, 3005, 0.01>
            texture{
                pigment{
                    image_map{png "headset_closeup.png"
                        map_type 0 
                        interpolate 3 
                        once
                    }
                scale <3000, 3005, 0.01>
                }    
            }
        }      
        translate <0, 0, 2999.99> // <x, y, z>
    }
    rotate <0, -45, 0> // <x°, y°, z°> 
};

#declare VaseMetallic = union{ // aus Metall, Rotationskoerper (included), [C,E].
    object{
        Vase
        pigment{Silver}
        scale 25*<1.0, 1.0, 1.0> // <x, y, z>
        translate <0, 101, 1800> // <x, y, z>
        rotate <0, -45, 0> // <x°, y°, z°>
        finish{
            specular 0.25
            roughness .05
            reflection{
                0.9 metallic 
            }
            brilliance 4    
        }
    }

    light_source{ // [E] -> Kopfhoerer und Kabinen werfen Schatten
        <0.0, 5.0, 0.0>         
        color rgb cabinLightColor      
        translate <0, 101, 1800> // <x, y, z>
        rotate <0, -45, 0> // <x°, y°, z°>
        translate <0, 2*pi*250+69, 0> // <x, y, z>
        looks_like{
            sphere{
                <0, 0, 0>, 100 // <x, y, z>, radius
                pigment{color rgb cabinLightColor}
                material{
                    texture{
                        Metal
                        pigment{rgbt <0.1,0.8,0.9,0.4>}
                        finish{ambient 1}
                    }
                }
            }
        }
    }   
}
   
#declare Tisch = union{ // zur Ablage der Headsets und aus Holz [C,E]
    box{
        <0, 900, 0>, <2000, 1100, 2000> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
    }

    cylinder{
        <50, 0, 50>, <50, 900, 50>, 40 // center of one end, center of other end, radius
    }

    cylinder{
        <1950, 0, 50>, <1950, 900, 50>, 40 // center of one end, center of other end, radius
    }

    cylinder{
        <50, 0, 1950>, <50, 900, 1950>, 40 // center of one end, center of other end, radius
    }

    cylinder{
        <1950, 0, 1950>, <1950, 900, 1950>, 40 // center of one end, center of other end, radius
    }

    pigment{color rgb <0.254, 0.102 , 0.018>}
    finish{
        ambient 0.4 
        diffuse 1  
        roughness 1
        reflection{
            0.05 
        }
    }

    texture{
        Cork
        scale 800*<1.0, 1.0, 1.0> // <x, y, z>
        rotate -45*y
    }
};

// Kabinen sollen auf folgender Gerade verschoben werden:
// - in XZ-Ebene
// - 45° zur X-Achse => cos(pi/4) => sqrt(2)/2
// - 45° zur Z-Achse => sin(pi/4) => sqrt(2)/2 (siehe Ratios: ratio45Degree)
// - monoton steigend (vom 3. -> 1. Quadranten)
// ->Sichtbar am Schachbrett-Muster des Bodens (verlaeuft diagonal)

// Ratio Distances
#local ratio45Degree = (sqrt(2)/2);

#local ratioLength45Degree = 3505*ratio45Degree; 
// Breite und Laenge der aeusseren Box der Kabine = 3005mm = 3,005m, dazu 50cm = 500mm [D]

#local ratioDistanceToWall45Degree = 900*ratio45Degree; // Hilfsdistanz zum Platzieren in der Kabine

// Erst erfolgt das Arrangement der Kabine durch Union, danach die Verschiebung mit einer Variable, die durch die Schleife konstant steigt.
// Das Headset wird auf dem Tisch und weitere Objekte in der Kabine platziert [C]
// Mittels einer Schleife wird die Vereinigung der Kabine nun um jeweils ratioLength45Degree, was zuvor definiert wurde, verschoben. [D]
#for (i, 0, 2) 
    union{
        object{Kabine}
    
        object{
            HEADSET
            scale 0.9*<1.0, 1.0, 1.0>
            rotate <105.9, 0, 0> // <x°, y°, z°> - Neige etwas mehr als 90°
            translate <ratioDistanceToWall45Degree-500*ratio45Degree, 1354, ratioDistanceToWall45Degree+2500*ratio45Degree> // <x, y, z>
        }

        // Es wurde mittels Intersection geprüft, ob Tisch und Headset sich schneiden
        object{
            Tisch
            translate<0,0,900>
            rotate <0, -45, 0> // <x°, y°, z°>
            translate <ratioDistanceToWall45Degree, 0, ratioDistanceToWall45Degree> // <x, y, z>
        }
        
        object{
            VaseMetallic
            translate <450*ratio45Degree, 0, 450*ratio45Degree> // <x, y, z>
        }

        translate<ratioLength45Degree*i,0, ratioLength45Degree*i>
    } 
#end 
