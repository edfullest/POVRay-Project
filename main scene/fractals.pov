//POVRAY fractals.pov +V +W800 +H600

//http://www.povray.org/documentation/3.7.0/t2_3.html#t2_3_2_1
// T_Moon gotten from = http://news.povray.org/povray.text.scene-files/attachment/%3C372633e0.0%40news.povray.org%3E/MoonTex.pov.txt

#include "colors.inc"
    

#default {finish{ambient 0
diffuse 1
specular 0
reflection 0}}

camera {
    location <-10, 30, 0>
    look_at <20, 0, 0>
  }

light_source { <50, 50, -50> color rgb<1, 1, 1> }
 

//---Rings---

#declare r=55; //minor radius
#declare R=70; //major radius
#declare color_tone = 0.4;

#macro F_Ring(small_radius, big_radius, times, color_tone)
    #if (times > 0) 
        union {  
            F_Ring(small_radius-1, big_radius-1, times-1, color_tone)
            F_Ring(small_radius-2, big_radius-2, times-1, color_tone-0.1)
            F_Ring(small_radius-3, big_radius-3, times-1, color_tone-0.1)
            F_Ring(small_radius-4, big_radius-4, times-1, color_tone-0.2)
        }
        
    #else  
        union
        {
        disc {
          0, y, big_radius + 20, small_radius + 20  
          pigment{ 
             mandel 50 exponent 2 //2...33
             scale 0.60 translate<0.15,0,0>
             color_map{[0.00 color rgb <1,1,color_tone>]
                       } 
             }
          scale <1.1, 1, 1>
          rotate <0, -30, 180>   
         } 
        }
     #end
   #end 

object {
    F_Ring(r, R, 4, color_tone)
        scale 0.1
        translate <20, 13, -10>
        rotate <-10, 10, 0>
}

//---End Rings---


#declare EVENTS_HORIZON = sphere {0, 7 scale <1, 1, 0.05>
   pigment {
      wood pigment_map {
          [0.0 spiral1 0.5
              color_map {
                  [0.2 rgbt <0, 0, 0, 1>] 
                  [0.3 rgbt <232/255,192/255,153/255, 1>] 
                  [1.0 rgbt <1, 1, 1, 0.9>]} 
            turbulence 0.2 octaves 0.3 lambda 1 scale 0.2
            ]
            [1.0 rgbt <232/255,192/255 ,153/255, 1>]
      } // End of spiral pigment map 
      scale 3.2 turbulence 0.01 octaves 4 lambda 4
    }
  finish {ambient 3 diffuse 10}
}

#declare SINGULARITY = sphere {0, 2.5
      pigment {
          warp {
            spherical
            orientation x
            dist_exp 100 
          }
      }    
}

#declare BLACKHOLE = union {
    object { EVENTS_HORIZON }
}

#declare GARGANTUA = union{
  object {
    BLACKHOLE 
    rotate <60, 0, -10>
    scale <1.5, 1.5, 1.5>
  }
  object { SINGULARITY
    translate <0.0,0.0,-0.2>
  }
  object {BLACKHOLE 
      rotate <-30, 20, 60>
      scale <1, 1.5, 1>
  }
}

object { GARGANTUA 
    translate <20, -10, 10>
    scale <6,6,6>
}


#declare T_Moon = texture {
  pigment{average pigment_map{
               [1 bozo color_map{[.7 rgb <1,1,.9>]
                                 [.85 rgb <1,1,.9>*.8]}
                  turbulence 1 octaves 8 omega .8 lambda 3
                  scale .5]
               [1 leopard color_map{[.3 rgb <1,1,.9>]
                                    [.5 rgb <1,1,.9>*.8]
                                    [.7 rgb <1,1,.9>]}
                  turbulence .2 octaves 8 omega .8 lambda 3
                  scale .2]
               [1 leopard color_map{[.2 rgb <1,1,.9>]
                                    [.4 rgb <1,1,.9>*.8]
                                    [.5 rgb <1,1,.9>]}
                  turbulence .2 octaves 8 omega .8 lambda 3
                  scale .07]
               [1 granite color_map{[0 rgb <1,1,.9>]
                                    [1 rgb <1,1,.9>*.8]}
                  scale .1]
               }}
       finish{ambient 0 diffuse .6 brilliance .3}
}

#declare T_Earth = texture {
   pigment{
      image_map {
         gif "earth_map.gif"
         map_type 1  // Sphere type     
      }
   }         
}

sphere { <0,0,0> 6.378    
          texture {
               T_Earth
            }     
         scale<1.03,1,1.03>
         rotate <09,-120,-20>
         translate <30, 5, -2>
}

#declare MOON_TERRAIN = mesh {
  triangle {
  <0, 20.000000, 0><0, 19.567932, 1><1, 18.664181, 1>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.664181, 1><1, 19.099182, 0><0, 20.000000, 0>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.567932, 1><0, 19.987768, 2><1, 18.922506, 2>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.922506, 2><1, 18.664181, 1><0, 19.567932, 1>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.987768, 2><0, 19.409325, 3><1, 18.341133, 3>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.341133, 3><1, 18.922506, 2><0, 19.987768, 2>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.409325, 3><0, 19.999956, 4><1, 19.569260, 4>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.569260, 4><1, 18.341133, 3><0, 19.409325, 3>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.999956, 4><0, 20.049749, 5><1, 19.616123, 5>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.616123, 5><1, 19.569260, 4><0, 19.999956, 4>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.049749, 5><0, 19.961981, 6><1, 19.969973, 6>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.969973, 6><1, 19.616123, 5><0, 20.049749, 5>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.961981, 6><0, 20.494320, 7><1, 20.499382, 7>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.499382, 7><1, 19.969973, 6><0, 19.961981, 6>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.494320, 7><0, 20.000000, 8><1, 19.333260, 8>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.333260, 8><1, 20.499382, 7><0, 20.494320, 7>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.000000, 8><0, 19.825447, 9><1, 19.155779, 9>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.155779, 9><1, 19.333260, 8><0, 20.000000, 8>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.825447, 9><0, 19.992174, 10><1, 19.018738, 10>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.018738, 10><1, 19.155779, 9><0, 19.825447, 9>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.992174, 10><0, 19.524635, 11><1, 18.548267, 11>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.548267, 11><1, 19.018738, 10><0, 19.992174, 10>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.524635, 11><0, 20.000050, 12><1, 19.010670, 12>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.010670, 12><1, 18.548267, 11><0, 19.524635, 11>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.000050, 12><0, 19.514551, 13><1, 18.522242, 13>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.522242, 13><1, 19.010670, 12><0, 20.000050, 12>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.514551, 13><0, 20.030937, 14><1, 19.831104, 14>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.831104, 14><1, 18.522242, 13><0, 19.514551, 13>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.030937, 14><0, 20.309933, 15><1, 20.107170, 15>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.107170, 15><1, 19.831104, 14><0, 20.030937, 14>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.309933, 15><0, 20.000000, 16><1, 19.576632, 16>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.576632, 16><1, 20.107170, 15><0, 20.309933, 15>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.000000, 16><0, 20.092257, 17><1, 19.665958, 17>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.665958, 17><1, 19.576632, 16><0, 20.000000, 16>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.092257, 17><0, 20.033840, 18><1, 20.120682, 18>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.120682, 18><1, 19.665958, 17><0, 20.092257, 17>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.033840, 18><0, 20.608330, 19><1, 20.692244, 19>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.692244, 19><1, 20.120682, 18><0, 20.033840, 18>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.608330, 19><0, 20.000006, 20><1, 19.230095, 20>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.230095, 20><1, 20.692244, 19><0, 20.608330, 19>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.000006, 20><0, 19.757437, 21><1, 18.984596, 21>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.984596, 21><1, 19.230095, 20><0, 20.000006, 20>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.757437, 21><0, 20.009241, 22><1, 19.673052, 22>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.673052, 22><1, 18.984596, 21><0, 19.757437, 21>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.009241, 22><0, 20.197014, 23><1, 19.857895, 23>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.857895, 23><1, 19.673052, 22><0, 20.009241, 22>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.197014, 23><0, 20.000000, 24><1, 19.574163, 24>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.574163, 24><1, 19.857895, 23><0, 20.197014, 23>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.000000, 24><0, 20.113226, 25><1, 19.684460, 25>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.684460, 25><1, 19.574163, 24><0, 20.000000, 24>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.113226, 25><0, 19.993317, 26><1, 20.068624, 26>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.068624, 26><1, 19.684460, 25><0, 20.113226, 25>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.993317, 26><0, 20.620293, 27><1, 20.692671, 27>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.692671, 27><1, 20.068624, 26><0, 19.993317, 26>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.620293, 27><0, 20.000126, 28><1, 18.942591, 28>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.942591, 28><1, 20.692671, 27><0, 20.620293, 27>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.000126, 28><0, 19.493311, 29><1, 18.432846, 29>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.432846, 29><1, 18.942591, 28><0, 20.000126, 28>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.493311, 29><0, 20.003328, 30><1, 19.140297, 30>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.140297, 30><1, 18.432846, 29><0, 19.493311, 29>
  texture { T_Moon } 
  }
  triangle {
  <0, 20.003328, 30><0, 19.693607, 31><1, 18.827646, 31>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.827646, 31><1, 19.140297, 30><0, 20.003328, 30>
  texture { T_Moon } 
  }
  triangle {
  <0, 19.693607, 31><0, 20.000000, 32><1, 19.131107, 32>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.131107, 32><1, 18.827646, 31><0, 19.693607, 31>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.099182, 0><1, 18.664181, 1><2, 18.618982, 1>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.618982, 1><2, 19.050268, 0><1, 19.099182, 0>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.664181, 1><1, 18.922506, 2><2, 19.026320, 2>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.026320, 2><2, 18.618982, 1><1, 18.664181, 1>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.922506, 2><1, 18.341133, 3><2, 18.864954, 3>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.864954, 3><2, 19.026320, 2><1, 18.922506, 2>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.341133, 3><1, 19.569260, 4><2, 19.001001, 4>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.001001, 4><2, 18.864954, 3><1, 18.341133, 3>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.569260, 4><1, 19.616123, 5><2, 19.029816, 5>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.029816, 5><2, 19.001001, 4><1, 19.569260, 4>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.616123, 5><1, 19.969973, 6><2, 18.951307, 6>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.951307, 6><2, 19.029816, 5><1, 19.616123, 5>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.969973, 6><1, 20.499382, 7><2, 18.344244, 7>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.344244, 7><2, 18.951307, 6><1, 19.969973, 6>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.499382, 7><1, 19.333260, 8><2, 19.007799, 8>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.007799, 8><2, 18.344244, 7><1, 20.499382, 7>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.333260, 8><1, 19.155779, 9><2, 19.198380, 9>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.198380, 9><2, 19.007799, 8><1, 19.333260, 8>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.155779, 9><1, 19.018738, 10><2, 18.988255, 10>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.988255, 10><2, 19.198380, 9><1, 19.155779, 9>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.018738, 10><1, 18.548267, 11><2, 18.887251, 11>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.887251, 11><2, 18.988255, 10><1, 19.018738, 10>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.548267, 11><1, 19.010670, 12><2, 19.023174, 12>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.023174, 12><2, 18.887251, 11><1, 18.548267, 11>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.010670, 12><1, 18.522242, 13><2, 19.160328, 13>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.160328, 13><2, 19.023174, 12><1, 19.010670, 12>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.522242, 13><1, 19.831104, 14><2, 19.042343, 14>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.042343, 14><2, 19.160328, 13><1, 18.522242, 13>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.831104, 14><1, 20.107170, 15><2, 19.003542, 15>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.003542, 15><2, 19.042343, 14><1, 19.831104, 14>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.107170, 15><1, 19.576632, 16><2, 19.002590, 16>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.002590, 16><2, 19.003542, 15><1, 20.107170, 15>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.576632, 16><1, 19.665958, 17><2, 19.045218, 17>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.045218, 17><2, 19.002590, 16><1, 19.576632, 16>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.665958, 17><1, 20.120682, 18><2, 19.024710, 18>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.024710, 18><2, 19.045218, 17><1, 19.665958, 17>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.120682, 18><1, 20.692244, 19><2, 18.707298, 19>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.707298, 19><2, 19.024710, 18><1, 20.120682, 18>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.692244, 19><1, 19.230095, 20><2, 18.954557, 20>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.954557, 20><2, 18.707298, 19><1, 20.692244, 19>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.230095, 20><1, 18.984596, 21><2, 18.610350, 21>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.610350, 21><2, 18.954557, 20><1, 19.230095, 20>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.984596, 21><1, 19.673052, 22><2, 18.952074, 22>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.952074, 22><2, 18.610350, 21><1, 18.984596, 21>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.673052, 22><1, 19.857895, 23><2, 19.262085, 23>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.262085, 23><2, 18.952074, 22><1, 19.673052, 22>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.857895, 23><1, 19.574163, 24><2, 18.915192, 24>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.915192, 24><2, 19.262085, 23><1, 19.857895, 23>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.574163, 24><1, 19.684460, 25><2, 19.456553, 25>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.456553, 25><2, 18.915192, 24><1, 19.574163, 24>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.684460, 25><1, 20.068624, 26><2, 18.896790, 26>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.896790, 26><2, 19.456553, 25><1, 19.684460, 25>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.068624, 26><1, 20.692671, 27><2, 19.426449, 27>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.426449, 27><2, 18.896790, 26><1, 20.068624, 26>
  texture { T_Moon } 
  }
  triangle {
  <1, 20.692671, 27><1, 18.942591, 28><2, 18.901892, 28>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.901892, 28><2, 19.426449, 27><1, 20.692671, 27>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.942591, 28><1, 18.432846, 29><2, 19.282312, 29>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.282312, 29><2, 18.901892, 28><1, 18.942591, 28>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.432846, 29><1, 19.140297, 30><2, 18.893375, 30>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.893375, 30><2, 19.282312, 29><1, 18.432846, 29>
  texture { T_Moon } 
  }
  triangle {
  <1, 19.140297, 30><1, 18.827646, 31><2, 18.264256, 31>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.264256, 31><2, 18.893375, 30><1, 19.140297, 30>
  texture { T_Moon } 
  }
  triangle {
  <1, 18.827646, 31><1, 19.131107, 32><2, 18.878328, 32>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.878328, 32><2, 18.264256, 31><1, 18.827646, 31>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.050268, 0><2, 18.618982, 1><3, 17.734085, 1>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.734085, 1><3, 18.168301, 0><2, 19.050268, 0>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.618982, 1><2, 19.026320, 2><3, 18.396204, 2>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.396204, 2><3, 17.734085, 1><2, 18.618982, 1>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.026320, 2><2, 18.864954, 3><3, 18.231909, 3>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.231909, 3><3, 18.396204, 2><2, 19.026320, 2>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.864954, 3><2, 19.001001, 4><3, 18.593182, 4>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.593182, 4><3, 18.231909, 3><2, 18.864954, 3>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.001001, 4><2, 19.029816, 5><3, 18.619066, 5>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.619066, 5><3, 18.593182, 4><2, 19.001001, 4>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.029816, 5><2, 18.951307, 6><3, 17.863754, 6>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.863754, 6><3, 18.619066, 5><2, 19.029816, 5>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.951307, 6><2, 18.344244, 7><3, 17.253761, 7>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.253761, 7><3, 17.863754, 6><2, 18.951307, 6>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.344244, 7><2, 19.007799, 8><3, 18.719902, 8>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.719902, 8><3, 17.253761, 7><2, 18.344244, 7>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.007799, 8><2, 19.198380, 9><3, 18.907551, 9>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.907551, 9><3, 18.719902, 8><2, 19.007799, 8>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.198380, 9><2, 18.988255, 10><3, 18.395063, 10>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.395063, 10><3, 18.907551, 9><2, 19.198380, 9>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.988255, 10><2, 18.887251, 11><3, 18.291132, 11>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.291132, 11><3, 18.395063, 10><2, 18.988255, 10>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.887251, 11><2, 19.023174, 12><3, 18.631393, 12>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.631393, 12><3, 18.291132, 11><2, 18.887251, 11>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.023174, 12><2, 19.160328, 13><3, 18.765617, 13>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.765617, 13><3, 18.631393, 12><2, 19.023174, 12>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.160328, 13><2, 19.042343, 14><3, 18.499660, 14>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.499660, 14><3, 18.765617, 13><2, 19.160328, 13>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.042343, 14><2, 19.003542, 15><3, 18.457930, 15>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.457930, 15><3, 18.499660, 14><2, 19.042343, 14>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.003542, 15><2, 19.002590, 16><3, 18.501616, 16>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.501616, 16><3, 18.457930, 15><2, 19.003542, 15>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.002590, 16><2, 19.045218, 17><3, 18.541315, 17>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.541315, 17><3, 18.501616, 16><2, 19.002590, 16>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.045218, 17><2, 19.024710, 18><3, 18.191673, 18>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.191673, 18><3, 18.541315, 17><2, 19.045218, 17>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.024710, 18><2, 18.707298, 19><3, 17.871330, 19>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.871330, 19><3, 18.191673, 18><2, 19.024710, 18>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.707298, 19><2, 18.954557, 20><3, 18.079630, 20>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.079630, 20><3, 17.871330, 19><2, 18.707298, 19>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.954557, 20><2, 18.610350, 21><3, 17.732492, 21>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.732492, 21><3, 18.079630, 20><2, 18.954557, 20>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.610350, 21><2, 18.952074, 22><3, 18.734743, 22>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.734743, 22><3, 17.732492, 21><2, 18.610350, 21>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.952074, 22><2, 19.262085, 23><3, 19.041824, 23>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.041824, 23><3, 18.734743, 22><2, 18.952074, 22>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.262085, 23><2, 18.915192, 24><3, 18.930096, 24>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.930096, 24><3, 19.041824, 23><2, 19.262085, 23>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.915192, 24><2, 19.456553, 25><3, 19.468527, 25>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.468527, 25><3, 18.930096, 24><2, 18.915192, 24>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.456553, 25><2, 18.896790, 26><3, 18.887386, 26>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.887386, 26><3, 19.468527, 25><2, 19.456553, 25>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.896790, 26><2, 19.426449, 27><3, 19.414116, 27>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.414116, 27><3, 18.887386, 26><2, 18.896790, 26>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.426449, 27><2, 18.901892, 28><3, 18.734190, 28>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.734190, 28><3, 19.414116, 27><2, 19.426449, 27>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.901892, 28><2, 19.282312, 29><3, 19.111681, 29>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.111681, 29><3, 18.734190, 28><2, 18.901892, 28>
  texture { T_Moon } 
  }
  triangle {
  <2, 19.282312, 29><2, 18.893375, 30><3, 17.713535, 30>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.713535, 30><3, 19.111681, 29><2, 19.282312, 29>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.893375, 30><2, 18.264256, 31><3, 17.081486, 31>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.081486, 31><3, 17.713535, 30><2, 18.893375, 30>
  texture { T_Moon } 
  }
  triangle {
  <2, 18.264256, 31><2, 18.878328, 32><3, 17.692631, 32>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.692631, 32><3, 17.081486, 31><2, 18.264256, 31>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.168301, 0><3, 17.734085, 1><4, 17.614035, 1>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.614035, 1><4, 18.124956, 0><3, 18.168301, 0>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.734085, 1><3, 18.396204, 2><4, 18.110689, 2>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.110689, 2><4, 17.614035, 1><3, 17.734085, 1>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.396204, 2><3, 18.231909, 3><4, 17.717890, 3>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.717890, 3><4, 18.110689, 2><3, 18.396204, 2>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.231909, 3><3, 18.593182, 4><4, 18.078037, 4>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.078037, 4><4, 17.717890, 3><3, 18.231909, 3>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.593182, 4><3, 18.619066, 5><4, 18.119188, 5>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.119188, 5><4, 18.078037, 4><3, 18.593182, 4>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.619066, 5><3, 17.863754, 6><4, 18.076401, 6>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.076401, 6><4, 18.119188, 5><3, 18.619066, 5>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.863754, 6><3, 17.253761, 7><4, 18.489870, 7>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.489870, 7><4, 18.076401, 6><3, 17.863754, 6>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.253761, 7><3, 18.719902, 8><4, 18.031300, 8>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.031300, 8><4, 18.489870, 7><3, 17.253761, 7>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.719902, 8><3, 18.907551, 9><4, 18.070126, 9>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.070126, 9><4, 18.031300, 8><3, 18.719902, 8>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.907551, 9><3, 18.395063, 10><4, 18.039022, 10>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.039022, 10><4, 18.070126, 9><3, 18.907551, 9>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.395063, 10><3, 18.291132, 11><4, 18.215765, 11>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.215765, 11><4, 18.039022, 10><3, 18.395063, 10>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.291132, 11><3, 18.631393, 12><4, 17.984474, 12>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.984474, 12><4, 18.215765, 11><3, 18.291132, 11>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.631393, 12><3, 18.765617, 13><4, 18.187260, 13>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.187260, 13><4, 17.984474, 12><3, 18.631393, 12>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.765617, 13><3, 18.499660, 14><4, 17.926146, 14>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.926146, 14><4, 18.187260, 13><3, 18.765617, 13>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.499660, 14><3, 18.457930, 15><4, 17.726694, 15>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.726694, 15><4, 17.926146, 14><3, 18.499660, 14>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.457930, 15><3, 18.501616, 16><4, 17.937506, 16>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.937506, 16><4, 17.726694, 15><3, 18.457930, 15>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.501616, 16><3, 18.541315, 17><4, 17.682495, 17>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.682495, 17><4, 17.937506, 16><3, 18.501616, 16>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.541315, 17><3, 18.191673, 18><4, 17.944656, 18>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.944656, 18><4, 17.682495, 17><3, 18.541315, 17>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.191673, 18><3, 17.871330, 19><4, 17.537323, 19>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.537323, 19><4, 17.944656, 18><3, 18.191673, 18>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.871330, 19><3, 18.079630, 20><4, 17.890636, 20>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.890636, 20><4, 17.537323, 19><3, 17.871330, 19>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.079630, 20><3, 17.732492, 21><4, 18.329908, 21>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.329908, 21><4, 17.890636, 20><3, 18.079630, 20>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.732492, 21><3, 18.734743, 22><4, 17.831640, 22>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.831640, 22><4, 18.329908, 21><3, 17.732492, 21>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.734743, 22><3, 19.041824, 23><4, 18.378235, 23>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.378235, 23><4, 17.831640, 22><3, 18.734743, 22>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.041824, 23><3, 18.930096, 24><4, 17.843876, 24>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.843876, 24><4, 18.378235, 23><3, 19.041824, 23>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.930096, 24><3, 19.468527, 25><4, 18.417557, 25>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.417557, 25><4, 17.843876, 24><3, 18.930096, 24>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.468527, 25><3, 18.887386, 26><4, 17.808767, 26>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.808767, 26><4, 18.417557, 25><3, 19.468527, 25>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.887386, 26><3, 19.414116, 27><4, 18.096674, 27>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.096674, 27><4, 17.808767, 26><3, 18.887386, 26>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.414116, 27><3, 18.734190, 28><4, 17.797127, 28>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.797127, 28><4, 18.096674, 27><3, 19.414116, 27>
  texture { T_Moon } 
  }
  triangle {
  <3, 18.734190, 28><3, 19.111681, 29><4, 17.502800, 29>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.502800, 29><4, 17.797127, 28><3, 18.734190, 28>
  texture { T_Moon } 
  }
  triangle {
  <3, 19.111681, 29><3, 17.713535, 30><4, 17.761690, 30>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.761690, 30><4, 17.502800, 29><3, 19.111681, 29>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.713535, 30><3, 17.081486, 31><4, 17.387014, 31>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.387014, 31><4, 17.761690, 30><3, 17.713535, 30>
  texture { T_Moon } 
  }
  triangle {
  <3, 17.081486, 31><3, 17.692631, 32><4, 17.750126, 32>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.750126, 32><4, 17.387014, 31><3, 17.081486, 31>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.124956, 0><4, 17.614035, 1><5, 16.643173, 1>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.643173, 1><5, 17.157024, 0><4, 18.124956, 0>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.614035, 1><4, 18.110689, 2><5, 17.264212, 2>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.264212, 2><5, 16.643173, 1><4, 17.614035, 1>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.110689, 2><4, 17.717890, 3><5, 16.868483, 3>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.868483, 3><5, 17.264212, 2><4, 18.110689, 2>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.717890, 3><4, 18.078037, 4><5, 17.650438, 4>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.650438, 4><5, 16.868483, 3><4, 17.717890, 3>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.078037, 4><4, 18.119188, 5><5, 17.688660, 5>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.688660, 5><5, 17.650438, 4><4, 18.078037, 4>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.119188, 5><4, 18.076401, 6><5, 18.037039, 6>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.037039, 6><5, 17.688660, 5><4, 18.119188, 5>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.076401, 6><4, 18.489870, 7><5, 18.447580, 7>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.447580, 7><5, 18.037039, 6><4, 18.076401, 6>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.489870, 7><4, 18.031300, 8><5, 17.589634, 8>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.589634, 8><5, 18.447580, 7><4, 18.489870, 7>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.031300, 8><4, 18.070126, 9><5, 17.625530, 9>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.625530, 9><5, 17.589634, 8><4, 18.031300, 8>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.070126, 9><4, 18.039022, 10><5, 17.760546, 10>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.760546, 10><5, 17.625530, 9><4, 18.070126, 9>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.039022, 10><4, 18.215765, 11><5, 17.934359, 11>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.934359, 11><5, 17.760546, 10><4, 18.039022, 10>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.215765, 11><4, 17.984474, 12><5, 17.695072, 12>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.695072, 12><5, 17.934359, 11><4, 18.215765, 11>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.984474, 12><4, 18.187260, 13><5, 17.894926, 13>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.894926, 13><5, 17.695072, 12><4, 17.984474, 12>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.187260, 13><4, 17.926146, 14><5, 17.193781, 14>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.193781, 14><5, 17.894926, 13><4, 18.187260, 13>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.926146, 14><4, 17.726694, 15><5, 16.991402, 15>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.991402, 15><5, 17.193781, 14><4, 17.926146, 14>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.726694, 15><4, 17.937506, 16><5, 17.178585, 16>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.178585, 16><5, 16.991402, 15><4, 17.726694, 15>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.937506, 16><4, 17.682495, 17><5, 16.920645, 17>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.920645, 17><5, 17.178585, 16><4, 17.937506, 16>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.682495, 17><4, 17.944656, 18><5, 17.058140, 18>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.058140, 18><5, 16.920645, 17><4, 17.682495, 17>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.944656, 18><4, 17.537323, 19><5, 16.647877, 19>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.647877, 19><5, 17.058140, 18><4, 17.944656, 18>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.537323, 19><4, 17.890636, 20><5, 17.814285, 20>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.814285, 20><5, 16.647877, 19><4, 17.537323, 19>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.890636, 20><4, 18.329908, 21><5, 18.250628, 21>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.250628, 21><5, 17.814285, 20><4, 17.890636, 20>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.329908, 21><4, 17.831640, 22><5, 17.821196, 22>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.821196, 22><5, 18.250628, 21><4, 18.329908, 21>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.831640, 22><4, 18.378235, 23><5, 18.364861, 23>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.364861, 23><5, 17.821196, 22><4, 17.831640, 22>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.378235, 23><4, 17.843876, 24><5, 17.890152, 24>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.890152, 24><5, 18.364861, 23><4, 18.378235, 23>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.843876, 24><4, 18.417557, 25><5, 18.460903, 25>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.460903, 25><5, 17.890152, 24><4, 17.843876, 24>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.417557, 25><4, 17.808767, 26><5, 17.551672, 26>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.551672, 26><5, 18.460903, 25><4, 18.417557, 25>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.808767, 26><4, 18.096674, 27><5, 17.836649, 27>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.836649, 27><5, 17.551672, 26><4, 17.808767, 26>
  texture { T_Moon } 
  }
  triangle {
  <4, 18.096674, 27><4, 17.797127, 28><5, 16.963737, 28>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.963737, 28><5, 17.836649, 27><4, 18.096674, 27>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.797127, 28><4, 17.502800, 29><5, 16.666483, 29>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.666483, 29><5, 16.963737, 28><4, 17.797127, 28>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.502800, 29><4, 17.761690, 30><5, 16.830156, 30>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.830156, 30><5, 16.666483, 29><4, 17.502800, 29>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.761690, 30><4, 17.387014, 31><5, 16.452549, 31>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.452549, 31><5, 16.830156, 30><4, 17.761690, 30>
  texture { T_Moon } 
  }
  triangle {
  <4, 17.387014, 31><4, 17.750126, 32><5, 16.812731, 32>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.812731, 32><5, 16.452549, 31><4, 17.387014, 31>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.157024, 0><5, 16.643173, 1><6, 17.590473, 1>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.590473, 1><6, 17.196669, 0><5, 17.157024, 0>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.643173, 1><5, 17.264212, 2><6, 17.170683, 2>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.170683, 2><6, 17.590473, 1><5, 16.643173, 1>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.264212, 2><5, 16.868483, 3><6, 17.053732, 3>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.053732, 3><6, 17.170683, 2><5, 17.264212, 2>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.868483, 3><5, 17.650438, 4><6, 17.138901, 4>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.138901, 4><6, 17.053732, 3><5, 16.868483, 3>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.650438, 4><5, 17.688660, 5><6, 17.752138, 5>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.752138, 5><6, 17.138901, 4><5, 17.650438, 4>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.688660, 5><5, 18.037039, 6><6, 17.125544, 6>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.125544, 6><6, 17.752138, 5><5, 17.688660, 5>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.037039, 6><5, 18.447580, 7><6, 17.191206, 7>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.191206, 7><6, 17.125544, 6><5, 18.037039, 6>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.447580, 7><5, 17.589634, 8><6, 17.078035, 8>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.078035, 8><6, 17.191206, 7><5, 18.447580, 7>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.589634, 8><5, 17.625530, 9><6, 17.530106, 9>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.530106, 9><6, 17.078035, 8><5, 17.589634, 8>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.625530, 9><5, 17.760546, 10><6, 17.074039, 10>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.074039, 10><6, 17.530106, 9><5, 17.625530, 9>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.760546, 10><5, 17.934359, 11><6, 17.658665, 11>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.658665, 11><6, 17.074039, 10><5, 17.760546, 10>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.934359, 11><5, 17.695072, 12><6, 16.941771, 12>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.941771, 12><6, 17.658665, 11><5, 17.934359, 11>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.695072, 12><5, 17.894926, 13><6, 17.301699, 13>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.301699, 13><6, 16.941771, 12><5, 17.695072, 12>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.894926, 13><5, 17.193781, 14><6, 16.871723, 14>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.871723, 14><6, 17.301699, 13><5, 17.894926, 13>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.193781, 14><5, 16.991402, 15><6, 16.944000, 15>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.944000, 15><6, 16.871723, 14><5, 17.193781, 14>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.991402, 15><5, 17.178585, 16><6, 16.936840, 16>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.936840, 16><6, 16.944000, 15><5, 16.991402, 15>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.178585, 16><5, 16.920645, 17><6, 17.111263, 17>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.111263, 17><6, 16.936840, 16><5, 17.178585, 16>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.920645, 17><5, 17.058140, 18><6, 16.932270, 18>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.932270, 18><6, 17.111263, 17><5, 16.920645, 17>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.058140, 18><5, 16.647877, 19><6, 17.003927, 19>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.003927, 19><6, 16.932270, 18><5, 17.058140, 18>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.647877, 19><5, 17.814285, 20><6, 16.800392, 20>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.800392, 20><6, 17.003927, 19><5, 16.647877, 19>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.814285, 20><5, 18.250628, 21><6, 17.288849, 21>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.288849, 21><6, 16.800392, 20><5, 17.814285, 20>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.250628, 21><5, 17.821196, 22><6, 16.729677, 22>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.729677, 22><6, 17.288849, 21><5, 18.250628, 21>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.821196, 22><5, 18.364861, 23><6, 17.092670, 23>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.092670, 23><6, 16.729677, 22><5, 17.821196, 22>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.364861, 23><5, 17.890152, 24><6, 16.753954, 24>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.753954, 24><6, 17.092670, 23><5, 18.364861, 23>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.890152, 24><5, 18.460903, 25><6, 17.036880, 25>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.036880, 25><6, 16.753954, 24><5, 17.890152, 24>
  texture { T_Moon } 
  }
  triangle {
  <5, 18.460903, 25><5, 17.551672, 26><6, 16.707127, 26>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.707127, 26><6, 17.036880, 25><5, 18.460903, 25>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.551672, 26><5, 17.836649, 27><6, 17.162807, 27>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.162807, 27><6, 16.707127, 26><5, 17.551672, 26>
  texture { T_Moon } 
  }
  triangle {
  <5, 17.836649, 27><5, 16.963737, 28><6, 16.683565, 28>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.683565, 28><6, 17.162807, 27><5, 17.836649, 27>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.963737, 28><5, 16.666483, 29><6, 16.975771, 29>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.975771, 29><6, 16.683565, 28><5, 16.963737, 28>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.666483, 29><5, 16.830156, 30><6, 16.636410, 30>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.636410, 30><6, 16.975771, 29><5, 16.666483, 29>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.830156, 30><5, 16.452549, 31><6, 17.152542, 31>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.152542, 31><6, 16.636410, 30><5, 16.830156, 30>
  texture { T_Moon } 
  }
  triangle {
  <5, 16.452549, 31><5, 16.812731, 32><6, 16.613127, 32>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.613127, 32><6, 17.152542, 31><5, 16.452549, 31>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.196669, 0><6, 17.590473, 1><7, 17.521006, 1>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.521006, 1><7, 17.130133, 0><6, 17.196669, 0>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.590473, 1><6, 17.170683, 2><7, 16.596722, 2>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.596722, 2><7, 17.521006, 1><6, 17.590473, 1>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.170683, 2><6, 17.053732, 3><7, 16.476841, 3>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.476841, 3><7, 16.596722, 2><6, 17.170683, 2>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.053732, 3><6, 17.138901, 4><7, 17.267469, 4>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.267469, 4><7, 16.476841, 3><6, 17.053732, 3>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.138901, 4><6, 17.752138, 5><7, 17.877779, 5>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.877779, 5><7, 17.267469, 4><6, 17.138901, 4>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.752138, 5><6, 17.125544, 6><7, 16.722456, 6>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.722456, 6><7, 17.877779, 5><6, 17.752138, 5>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.125544, 6><6, 17.191206, 7><7, 16.785189, 7>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.785189, 7><7, 16.722456, 6><6, 17.125544, 6>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.191206, 7><6, 17.078035, 8><7, 17.024334, 8>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.024334, 8><7, 16.785189, 7><6, 17.191206, 7>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.078035, 8><6, 17.530106, 9><7, 17.473475, 9>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.473475, 9><7, 17.024334, 8><6, 17.078035, 8>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.530106, 9><6, 17.074039, 10><7, 17.178173, 10>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.178173, 10><7, 17.473475, 9><6, 17.530106, 9>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.074039, 10><6, 17.658665, 11><7, 17.759869, 11>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.759869, 11><7, 17.178173, 10><6, 17.074039, 10>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.658665, 11><6, 16.941771, 12><7, 16.850237, 12>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.850237, 12><7, 17.759869, 11><6, 17.658665, 11>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.941771, 12><6, 17.301699, 13><7, 17.207237, 13>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.207237, 13><7, 16.850237, 12><6, 16.941771, 12>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.301699, 13><6, 16.871723, 14><7, 16.451813, 14>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.451813, 14><7, 17.207237, 13><6, 17.301699, 13>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.871723, 14><6, 16.944000, 15><7, 16.521160, 15>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.521160, 15><7, 16.451813, 14><6, 16.871723, 14>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.944000, 15><6, 16.936840, 16><7, 16.582628, 16>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.582628, 16><7, 16.521160, 15><6, 16.944000, 15>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.936840, 16><6, 17.111263, 17><7, 16.754124, 17>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.754124, 17><7, 16.582628, 16><6, 16.936840, 16>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.111263, 17><6, 16.932270, 18><7, 16.500019, 18>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.500019, 18><7, 16.754124, 17><6, 17.111263, 17>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.932270, 18><6, 17.003927, 19><7, 16.568747, 19>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.568747, 19><7, 16.500019, 18><6, 16.932270, 18>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.003927, 19><6, 16.800392, 20><7, 16.814640, 20>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.814640, 20><7, 16.568747, 19><6, 17.003927, 19>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.800392, 20><6, 17.288849, 21><7, 17.300167, 21>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.300167, 21><7, 16.814640, 20><6, 16.800392, 20>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.288849, 21><6, 16.729677, 22><7, 16.577045, 22>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.577045, 22><7, 17.300167, 21><6, 17.288849, 21>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.729677, 22><6, 17.092670, 23><7, 16.937109, 23>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.937109, 23><7, 16.577045, 22><6, 16.729677, 22>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.092670, 23><6, 16.753954, 24><7, 16.527065, 24>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.527065, 24><7, 16.937109, 23><6, 17.092670, 23>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.753954, 24><6, 17.036880, 25><7, 16.807064, 25>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.807064, 25><7, 16.527065, 24><6, 16.753954, 24>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.036880, 25><6, 16.707127, 26><7, 16.635403, 26>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.635403, 26><7, 16.807064, 25><6, 17.036880, 25>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.707127, 26><6, 17.162807, 27><7, 17.088154, 27>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.088154, 27><7, 16.635403, 26><6, 16.707127, 26>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.162807, 27><6, 16.683565, 28><7, 16.454504, 28>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.454504, 28><7, 17.088154, 27><6, 17.162807, 27>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.683565, 28><6, 16.975771, 29><7, 16.743778, 29>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.743778, 29><7, 16.454504, 28><6, 16.683565, 28>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.975771, 29><6, 16.636410, 30><7, 16.613480, 30>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.613480, 30><7, 16.743778, 29><6, 16.975771, 29>
  texture { T_Moon } 
  }
  triangle {
  <6, 16.636410, 30><6, 17.152542, 31><7, 17.126684, 31>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.126684, 31><7, 16.613480, 30><6, 16.636410, 30>
  texture { T_Moon } 
  }
  triangle {
  <6, 17.152542, 31><6, 16.613127, 32><7, 16.584339, 32>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.584339, 32><7, 17.126684, 31><6, 17.152542, 31>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.130133, 0><7, 17.521006, 1><8, 16.060589, 1>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.060589, 1><8, 16.250000, 0><7, 17.130133, 0>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.521006, 1><7, 16.596722, 2><8, 16.176655, 2>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.176655, 2><8, 16.060589, 1><7, 17.521006, 1>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.596722, 2><7, 16.476841, 3><8, 15.802878, 3>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.802878, 3><8, 16.176655, 2><7, 16.596722, 2>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.476841, 3><7, 17.267469, 4><8, 16.156322, 4>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.156322, 4><8, 15.802878, 3><7, 16.476841, 3>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.267469, 4><7, 17.877779, 5><8, 16.401262, 5>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.401262, 5><8, 16.156322, 4><7, 17.267469, 4>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.877779, 5><7, 16.722456, 6><8, 16.147383, 6>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.147383, 6><8, 16.401262, 5><7, 17.877779, 5>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.722456, 6><7, 16.785189, 7><8, 16.496162, 7>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.496162, 7><8, 16.147383, 6><7, 16.722456, 6>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.785189, 7><7, 17.024334, 8><8, 16.062500, 8>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.062500, 8><8, 16.496162, 7><7, 16.785189, 7>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.024334, 8><7, 17.473475, 9><8, 15.919910, 9>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.919910, 9><8, 16.062500, 8><7, 17.024334, 8>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.473475, 9><7, 17.178173, 10><8, 16.042400, 10>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.042400, 10><8, 15.919910, 9><7, 17.473475, 9>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.178173, 10><7, 17.759869, 11><8, 16.404154, 11>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.404154, 11><8, 16.042400, 10><7, 17.178173, 10>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.759869, 11><7, 16.850237, 12><8, 15.968901, 12>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.968901, 12><8, 16.404154, 11><7, 17.759869, 11>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.850237, 12><7, 17.207237, 13><8, 16.162657, 13>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.162657, 13><8, 15.968901, 12><7, 16.850237, 12>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.207237, 13><7, 16.451813, 14><8, 15.914386, 14>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.914386, 14><8, 16.162657, 13><7, 17.207237, 13>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.451813, 14><7, 16.521160, 15><8, 15.273100, 15>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.273100, 15><8, 15.914386, 14><7, 16.451813, 14>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.521160, 15><7, 16.582628, 16><8, 15.875000, 16>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.875000, 16><8, 15.273100, 15><7, 16.521160, 15>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.582628, 16><7, 16.754124, 17><8, 16.449398, 17>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.449398, 17><8, 15.875000, 16><7, 16.582628, 16>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.754124, 17><7, 16.500019, 18><8, 15.810747, 18>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.810747, 18><8, 16.449398, 17><7, 16.754124, 17>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.500019, 18><7, 16.568747, 19><8, 15.621547, 19>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.621547, 19><8, 15.810747, 18><7, 16.500019, 18>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.568747, 19><7, 16.814640, 20><8, 15.781271, 20>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.781271, 20><8, 15.621547, 19><7, 16.568747, 19>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.814640, 20><7, 17.300167, 21><8, 15.266901, 21>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.266901, 21><8, 15.781271, 20><7, 16.814640, 20>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.300167, 21><7, 16.577045, 22><8, 15.709435, 22>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.709435, 22><8, 15.266901, 21><7, 17.300167, 21>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.577045, 22><7, 16.937109, 23><8, 15.430790, 23>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.430790, 23><8, 15.709435, 22><7, 16.577045, 22>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.937109, 23><7, 16.527065, 24><8, 15.687500, 24>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.687500, 24><8, 15.430790, 23><7, 16.937109, 23>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.527065, 24><7, 16.807064, 25><8, 16.087299, 25>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.087299, 25><8, 15.687500, 24><7, 16.527065, 24>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.807064, 25><7, 16.635403, 26><8, 15.651037, 26>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.651037, 26><8, 16.087299, 25><7, 16.807064, 25>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.635403, 26><7, 17.088154, 27><8, 15.060720, 27>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.060720, 27><8, 15.651037, 26><7, 16.635403, 26>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.088154, 27><7, 16.454504, 28><8, 15.593626, 28>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.593626, 28><8, 15.060720, 27><7, 17.088154, 27>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.454504, 28><7, 16.743778, 29><8, 15.226571, 29>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.226571, 29><8, 15.593626, 28><7, 16.454504, 28>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.743778, 29><7, 16.613480, 30><8, 15.542617, 30>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.542617, 30><8, 15.226571, 29><7, 16.743778, 29>
  texture { T_Moon } 
  }
  triangle {
  <7, 16.613480, 30><7, 17.126684, 31><8, 15.948980, 31>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.948980, 31><8, 15.542617, 30><7, 16.613480, 30>
  texture { T_Moon } 
  }
  triangle {
  <7, 17.126684, 31><7, 16.584339, 32><8, 15.500000, 32>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.500000, 32><8, 15.948980, 31><7, 17.126684, 31>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.250000, 0><8, 16.060589, 1><9, 15.422935, 1>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.422935, 1><9, 15.615276, 0><8, 16.250000, 0>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.060589, 1><8, 16.176655, 2><9, 15.325200, 2>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.325200, 2><9, 15.422935, 1><8, 16.060589, 1>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.176655, 2><8, 15.802878, 3><9, 14.948494, 3>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.948494, 3><9, 15.325200, 2><8, 16.176655, 2>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.802878, 3><8, 16.156322, 4><9, 15.944268, 4>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.944268, 4><9, 14.948494, 3><8, 15.802878, 3>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.156322, 4><8, 16.401262, 5><9, 16.186279, 5>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.186279, 5><9, 15.944268, 4><8, 16.156322, 4>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.401262, 5><8, 16.147383, 6><9, 16.071278, 6>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.071278, 6><9, 16.186279, 5><8, 16.401262, 5>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.147383, 6><8, 16.496162, 7><9, 16.417128, 7>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.417128, 7><9, 16.071278, 6><8, 16.147383, 6>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.496162, 7><8, 16.062500, 8><9, 15.451159, 8>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.451159, 8><9, 16.417128, 7><8, 16.496162, 7>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.062500, 8><8, 15.919910, 9><9, 15.305639, 9>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.305639, 9><9, 15.451159, 8><8, 16.062500, 8>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.919910, 9><8, 16.042400, 10><9, 15.956244, 10>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.956244, 10><9, 15.305639, 9><8, 15.919910, 9>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.042400, 10><8, 16.404154, 11><9, 16.315067, 11>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.315067, 11><9, 15.956244, 10><8, 16.042400, 10>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.404154, 11><8, 15.968901, 12><9, 15.682263, 12>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.682263, 12><9, 16.315067, 11><8, 16.404154, 11>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.968901, 12><8, 16.162657, 13><9, 15.873089, 13>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.873089, 13><9, 15.682263, 12><8, 15.968901, 12>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.162657, 13><8, 15.914386, 14><9, 14.779282, 14>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.779282, 14><9, 15.873089, 13><8, 16.162657, 13>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.914386, 14><8, 15.273100, 15><9, 14.135067, 15>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.135067, 15><9, 14.779282, 14><8, 15.914386, 14>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.273100, 15><8, 15.875000, 16><9, 15.957211, 16>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.957211, 16><9, 14.135067, 15><8, 15.273100, 15>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.875000, 16><8, 16.449398, 17><9, 16.528681, 17>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.528681, 17><9, 15.957211, 16><8, 15.875000, 16>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.449398, 17><8, 15.810747, 18><9, 15.106112, 18>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.106112, 18><9, 16.528681, 17><8, 16.449398, 17>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.810747, 18><8, 15.621547, 19><9, 14.913981, 19>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.913981, 19><9, 15.106112, 18><8, 15.810747, 18>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.621547, 19><8, 15.781271, 20><9, 14.763004, 20>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.763004, 20><9, 14.913981, 19><8, 15.621547, 19>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.781271, 20><8, 15.266901, 21><9, 14.245705, 21>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.245705, 21><9, 14.763004, 20><8, 15.781271, 20>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.266901, 21><8, 15.709435, 22><9, 14.896086, 22>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.896086, 22><9, 14.245705, 21><8, 15.266901, 21>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.709435, 22><8, 15.430790, 23><9, 14.614511, 23>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.614511, 23><9, 14.896086, 22><8, 15.709435, 22>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.430790, 23><8, 15.687500, 24><9, 15.571673, 24>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.571673, 24><9, 14.614511, 23><8, 15.430790, 23>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.687500, 24><8, 16.087299, 25><9, 15.968542, 25>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.968542, 25><9, 15.571673, 24><8, 15.687500, 24>
  texture { T_Moon } 
  }
  triangle {
  <8, 16.087299, 25><8, 15.651037, 26><9, 14.549709, 26>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.549709, 26><9, 15.968542, 25><8, 16.087299, 25>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.651037, 26><8, 15.060720, 27><9, 13.956463, 27>
  texture { T_Moon } 
  }
  triangle {
  <9, 13.956463, 27><9, 14.549709, 26><8, 15.651037, 26>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.060720, 27><8, 15.593626, 28><9, 14.699166, 28>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.699166, 28><9, 13.956463, 27><8, 15.060720, 27>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.593626, 28><8, 15.226571, 29><9, 14.329182, 29>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.329182, 29><9, 14.699166, 28><8, 15.593626, 28>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.226571, 29><8, 15.542617, 30><9, 15.411518, 30>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.411518, 30><9, 14.329182, 29><8, 15.226571, 29>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.542617, 30><8, 15.948980, 31><9, 15.814953, 31>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.814953, 31><9, 15.411518, 30><8, 15.542617, 30>
  texture { T_Moon } 
  }
  triangle {
  <8, 15.948980, 31><8, 15.500000, 32><9, 15.363043, 32>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.363043, 32><9, 15.814953, 31><8, 15.948980, 31>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.615276, 0><9, 15.422935, 1><10, 15.037051, 1>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.037051, 1><10, 15.286030, 0><9, 15.615276, 0>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.422935, 1><9, 15.325200, 2><10, 15.200966, 2>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.200966, 2><10, 15.037051, 1><9, 15.422935, 1>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.325200, 2><9, 14.948494, 3><10, 15.760493, 3>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.760493, 3><10, 15.200966, 2><9, 15.325200, 2>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.948494, 3><9, 15.944268, 4><10, 15.233393, 4>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.233393, 4><10, 15.760493, 3><9, 14.948494, 3>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.944268, 4><9, 16.186279, 5><10, 15.557193, 5>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.557193, 5><10, 15.233393, 4><9, 15.944268, 4>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.186279, 5><9, 16.071278, 6><10, 15.212734, 6>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.212734, 6><10, 15.557193, 5><9, 16.186279, 5>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.071278, 6><9, 16.417128, 7><10, 14.962174, 7>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.962174, 7><10, 15.212734, 6><9, 16.071278, 6>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.417128, 7><9, 15.451159, 8><10, 15.104898, 8>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.104898, 8><10, 14.962174, 7><9, 16.417128, 7>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.451159, 8><9, 15.305639, 9><10, 14.563154, 9>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.563154, 9><10, 15.104898, 8><9, 15.451159, 8>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.305639, 9><9, 15.956244, 10><10, 15.073079, 10>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.073079, 10><10, 14.563154, 9><9, 15.305639, 9>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.956244, 10><9, 16.315067, 11><10, 15.237407, 11>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.237407, 11><10, 15.073079, 10><9, 15.956244, 10>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.315067, 11><9, 15.682263, 12><10, 14.953599, 12>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.953599, 12><10, 15.237407, 11><9, 16.315067, 11>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.682263, 12><9, 15.873089, 13><10, 14.970772, 13>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.970772, 13><10, 14.953599, 12><9, 15.682263, 12>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.873089, 13><9, 14.779282, 14><10, 14.887365, 14>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.887365, 14><10, 14.970772, 13><9, 15.873089, 13>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.779282, 14><9, 14.135067, 15><10, 15.221256, 15>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.221256, 15><10, 14.887365, 14><9, 14.779282, 14>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.135067, 15><9, 15.957211, 16><10, 14.826372, 16>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.826372, 16><10, 15.221256, 15><9, 14.135067, 15>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.957211, 16><9, 16.528681, 17><10, 14.713154, 17>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.713154, 17><10, 14.826372, 16><9, 15.957211, 16>
  texture { T_Moon } 
  }
  triangle {
  <9, 16.528681, 17><9, 15.106112, 18><10, 14.750401, 18>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.750401, 18><10, 14.713154, 17><9, 16.528681, 17>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.106112, 18><9, 14.913981, 19><10, 15.279065, 19>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.279065, 19><10, 14.750401, 18><9, 15.106112, 18>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.913981, 19><9, 14.763004, 20><10, 14.701644, 20>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.701644, 20><10, 15.279065, 19><9, 14.913981, 19>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.763004, 20><9, 14.245705, 21><10, 15.042126, 21>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.042126, 21><10, 14.701644, 20><9, 14.763004, 20>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.245705, 21><9, 14.896086, 22><10, 14.618090, 22>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.618090, 22><10, 15.042126, 21><9, 14.245705, 21>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.896086, 22><9, 14.614511, 23><10, 15.160923, 23>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.160923, 23><10, 14.618090, 22><9, 14.896086, 22>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.614511, 23><9, 15.571673, 24><10, 14.619787, 24>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.619787, 24><10, 15.160923, 23><9, 14.614511, 23>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.571673, 24><9, 15.968542, 25><10, 14.035524, 25>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.035524, 25><10, 14.619787, 24><9, 15.571673, 24>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.968542, 25><9, 14.549709, 26><10, 14.571606, 26>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.571606, 26><10, 14.035524, 25><9, 15.968542, 25>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.549709, 26><9, 13.956463, 27><10, 15.019938, 27>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.019938, 27><10, 14.571606, 26><9, 14.549709, 26>
  texture { T_Moon } 
  }
  triangle {
  <9, 13.956463, 27><9, 14.699166, 28><10, 14.487805, 28>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.487805, 28><10, 15.019938, 27><9, 13.956463, 27>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.699166, 28><9, 14.329182, 29><10, 14.677957, 29>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.677957, 29><10, 14.487805, 28><9, 14.699166, 28>
  texture { T_Moon } 
  }
  triangle {
  <9, 14.329182, 29><9, 15.411518, 30><10, 14.425077, 30>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.425077, 30><10, 14.677957, 29><9, 14.329182, 29>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.411518, 30><9, 15.814953, 31><10, 14.597420, 31>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.597420, 31><10, 14.425077, 30><9, 15.411518, 30>
  texture { T_Moon } 
  }
  triangle {
  <9, 15.814953, 31><9, 15.363043, 32><10, 14.370742, 32>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.370742, 32><10, 14.597420, 31><9, 15.814953, 31>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.286030, 0><10, 15.037051, 1><11, 14.372196, 1>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.372196, 1><11, 14.624104, 0><10, 15.286030, 0>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.037051, 1><10, 15.200966, 2><11, 15.315181, 2>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.315181, 2><11, 14.372196, 1><10, 15.037051, 1>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.200966, 2><10, 15.760493, 3><11, 15.871778, 3>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.871778, 3><11, 15.315181, 2><10, 15.200966, 2>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.760493, 3><10, 15.233393, 4><11, 15.068086, 4>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.068086, 4><11, 15.871778, 3><10, 15.760493, 3>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.233393, 4><10, 15.557193, 5><11, 15.388956, 5>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.388956, 5><11, 15.068086, 4><10, 15.233393, 4>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.557193, 5><10, 15.212734, 6><11, 14.505179, 6>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.505179, 6><11, 15.388956, 5><10, 15.557193, 5>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.212734, 6><10, 14.962174, 7><11, 14.251690, 7>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.251690, 7><11, 14.505179, 6><10, 15.212734, 6>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.962174, 7><10, 15.104898, 8><11, 14.073565, 8>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.073565, 8><11, 14.251690, 7><10, 14.962174, 7>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.104898, 8><10, 14.563154, 9><11, 13.528890, 9>
  texture { T_Moon } 
  }
  triangle {
  <11, 13.528890, 9><11, 14.073565, 8><10, 15.104898, 8>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.563154, 9><10, 15.073079, 10><11, 14.768657, 10>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.768657, 10><11, 13.528890, 9><10, 14.563154, 9>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.073079, 10><10, 15.237407, 11><11, 14.930056, 11>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.930056, 11><11, 14.768657, 10><10, 15.073079, 10>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.237407, 11><10, 14.953599, 12><11, 14.503801, 12>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.503801, 12><11, 14.930056, 11><10, 15.237407, 11>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.953599, 12><10, 14.970772, 13><11, 14.518044, 13>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.518044, 13><11, 14.503801, 12><10, 14.953599, 12>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.970772, 13><10, 14.887365, 14><11, 14.740864, 14>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.740864, 14><11, 14.518044, 13><10, 14.970772, 13>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.887365, 14><10, 15.221256, 15><11, 15.071825, 15>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.071825, 15><11, 14.740864, 14><10, 14.887365, 14>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.221256, 15><10, 14.826372, 16><11, 14.244214, 16>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.244214, 16><11, 15.071825, 15><10, 15.221256, 15>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.826372, 16><10, 14.713154, 17><11, 14.128066, 17>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.128066, 17><11, 14.244214, 16><10, 14.826372, 16>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.713154, 17><10, 14.750401, 18><11, 14.786878, 18>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.786878, 18><11, 14.128066, 17><10, 14.713154, 17>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.750401, 18><10, 15.279065, 19><11, 15.312613, 19>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.312613, 19><11, 14.786878, 18><10, 14.750401, 18>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.279065, 19><10, 14.701644, 20><11, 14.569040, 20>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.569040, 20><11, 15.312613, 19><10, 15.279065, 19>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.701644, 20><10, 15.042126, 21><11, 14.906592, 21>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.906592, 21><11, 14.569040, 20><10, 14.701644, 20>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.042126, 21><10, 14.618090, 22><11, 14.657026, 22>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.657026, 22><11, 14.906592, 21><10, 15.042126, 21>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.618090, 22><10, 15.160923, 23><11, 15.196930, 23>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.196930, 23><11, 14.657026, 22><10, 14.618090, 22>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.160923, 23><10, 14.619787, 24><11, 13.515285, 24>
  texture { T_Moon } 
  }
  triangle {
  <11, 13.515285, 24><11, 15.196930, 23><10, 15.160923, 23>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.619787, 24><10, 14.035524, 25><11, 12.928092, 25>
  texture { T_Moon } 
  }
  triangle {
  <11, 12.928092, 25><11, 13.515285, 24><10, 14.619787, 24>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.035524, 25><10, 14.571606, 26><11, 14.504313, 26>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.504313, 26><11, 12.928092, 25><10, 14.035524, 25>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.571606, 26><10, 15.019938, 27><11, 14.949717, 27>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.949717, 27><11, 14.504313, 26><10, 14.571606, 26>
  texture { T_Moon } 
  }
  triangle {
  <10, 15.019938, 27><10, 14.487805, 28><11, 14.160605, 28>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.160605, 28><11, 14.949717, 27><10, 15.019938, 27>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.487805, 28><10, 14.677957, 29><11, 14.347827, 29>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.347827, 29><11, 14.160605, 28><10, 14.487805, 28>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.677957, 29><10, 14.425077, 30><11, 14.070015, 30>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.070015, 30><11, 14.347827, 29><10, 14.677957, 29>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.425077, 30><10, 14.597420, 31><11, 14.239428, 31>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.239428, 31><11, 14.070015, 30><10, 14.425077, 30>
  texture { T_Moon } 
  }
  triangle {
  <10, 14.597420, 31><10, 14.370742, 32><11, 14.009819, 32>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.009819, 32><11, 14.239428, 31><10, 14.597420, 31>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.624104, 0><11, 14.372196, 1><12, 14.535595, 1>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.535595, 1><12, 14.375072, 0><11, 14.624104, 0>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.372196, 1><11, 15.315181, 2><12, 14.328152, 2>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.328152, 2><12, 14.535595, 1><11, 14.372196, 1>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.315181, 2><11, 15.871778, 3><12, 13.814922, 3>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.814922, 3><12, 14.328152, 2><11, 15.315181, 2>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.871778, 3><11, 15.068086, 4><12, 14.234520, 4>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.234520, 4><12, 13.814922, 3><11, 15.871778, 3>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.068086, 4><11, 15.388956, 5><12, 13.652503, 5>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.652503, 5><12, 14.234520, 4><11, 15.068086, 4>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.388956, 5><11, 14.505179, 6><12, 14.155411, 6>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.155411, 6><12, 13.652503, 5><11, 15.388956, 5>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.505179, 6><11, 14.251690, 7><12, 13.701468, 7>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.701468, 7><12, 14.155411, 6><11, 14.505179, 6>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.251690, 7><11, 14.073565, 8><12, 14.093901, 8>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.093901, 8><12, 13.701468, 7><11, 14.251690, 7>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.073565, 8><11, 13.528890, 9><12, 14.599142, 9>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.599142, 9><12, 14.093901, 8><11, 14.073565, 8>
  texture { T_Moon } 
  }
  triangle {
  <11, 13.528890, 9><11, 14.768657, 10><12, 14.041850, 10>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.041850, 10><12, 14.599142, 9><11, 13.528890, 9>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.768657, 10><11, 14.930056, 11><12, 14.255337, 11>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.255337, 11><12, 14.041850, 10><11, 14.768657, 10>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.930056, 11><11, 14.503801, 12><12, 13.953426, 12>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.953426, 12><12, 14.255337, 11><11, 14.930056, 11>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.503801, 12><11, 14.518044, 13><12, 14.109450, 13>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.109450, 13><12, 13.953426, 12><11, 14.503801, 12>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.518044, 13><11, 14.740864, 14><12, 13.868658, 14>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.868658, 14><12, 14.109450, 13><11, 14.518044, 13>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.740864, 14><11, 15.071825, 15><12, 13.361610, 15>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.361610, 15><12, 13.868658, 14><11, 14.740864, 14>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.071825, 15><11, 14.244214, 16><12, 13.812521, 16>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.812521, 16><12, 13.361610, 15><11, 15.071825, 15>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.244214, 16><11, 14.128066, 17><12, 14.023774, 17>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.023774, 17><12, 13.812521, 16><11, 14.244214, 16>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.128066, 17><11, 14.786878, 18><12, 13.737457, 18>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.737457, 18><12, 14.023774, 17><11, 14.128066, 17>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.786878, 18><11, 15.312613, 19><12, 13.801015, 19>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.801015, 19><12, 13.737457, 18><11, 14.786878, 18>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.312613, 19><11, 14.569040, 20><12, 13.671917, 20>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.671917, 20><12, 13.801015, 19><11, 15.312613, 19>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.569040, 20><11, 14.906592, 21><12, 13.785636, 21>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.785636, 21><12, 13.671917, 20><11, 14.569040, 20>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.906592, 21><11, 14.657026, 22><12, 13.569300, 22>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.569300, 22><12, 13.785636, 21><11, 14.906592, 21>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.657026, 22><11, 15.196930, 23><12, 13.386908, 23>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.386908, 23><12, 13.569300, 22><11, 14.657026, 22>
  texture { T_Moon } 
  }
  triangle {
  <11, 15.196930, 23><11, 13.515285, 24><12, 13.531126, 24>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.531126, 24><12, 13.386908, 23><11, 15.196930, 23>
  texture { T_Moon } 
  }
  triangle {
  <11, 13.515285, 24><11, 12.928092, 25><12, 13.164355, 25>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.164355, 25><12, 13.531126, 24><11, 13.515285, 24>
  texture { T_Moon } 
  }
  triangle {
  <11, 12.928092, 25><11, 14.504313, 26><12, 13.442266, 26>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.442266, 26><12, 13.164355, 25><11, 12.928092, 25>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.504313, 26><11, 14.949717, 27><12, 12.925756, 27>
  texture { T_Moon } 
  }
  triangle {
  <12, 12.925756, 27><12, 13.442266, 26><11, 14.504313, 26>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.949717, 27><11, 14.160605, 28><12, 13.390377, 28>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.390377, 28><12, 12.925756, 27><11, 14.949717, 27>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.160605, 28><11, 14.347827, 29><12, 13.301723, 29>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.301723, 29><12, 13.390377, 28><11, 14.160605, 28>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.347827, 29><11, 14.070015, 30><12, 13.281634, 30>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.281634, 30><12, 13.301723, 29><11, 14.347827, 29>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.070015, 30><11, 14.239428, 31><12, 13.571106, 31>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.571106, 31><12, 13.281634, 30><11, 14.070015, 30>
  texture { T_Moon } 
  }
  triangle {
  <11, 14.239428, 31><11, 14.009819, 32><12, 13.249876, 32>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.249876, 32><12, 13.571106, 31><11, 14.239428, 31>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.375072, 0><12, 14.535595, 1><13, 14.259558, 1>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.259558, 1><13, 14.101965, 0><12, 14.375072, 0>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.535595, 1><12, 14.328152, 2><13, 13.398788, 2>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.398788, 2><13, 14.259558, 1><12, 14.535595, 1>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.328152, 2><12, 13.814922, 3><13, 12.882629, 3>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.882629, 3><13, 13.398788, 2><12, 14.328152, 2>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.814922, 3><12, 14.234520, 4><13, 13.207191, 4>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.207191, 4><13, 12.882629, 3><12, 13.814922, 3>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.234520, 4><12, 13.652503, 5><13, 12.622244, 5>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.622244, 5><13, 13.207191, 4><12, 14.234520, 4>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.652503, 5><12, 14.155411, 6><13, 13.241536, 6>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.241536, 6><13, 12.622244, 5><12, 13.652503, 5>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.155411, 6><12, 13.701468, 7><13, 12.784664, 7>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.784664, 7><13, 13.241536, 6><12, 14.155411, 6>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.701468, 7><12, 14.093901, 8><13, 14.142036, 8>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.142036, 8><13, 12.784664, 7><12, 13.701468, 7>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.093901, 8><12, 14.599142, 9><13, 14.644348, 9>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.644348, 9><13, 14.142036, 8><12, 14.093901, 8>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.599142, 9><12, 14.041850, 10><13, 13.810556, 10>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.810556, 10><13, 14.644348, 9><12, 14.599142, 9>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.041850, 10><12, 14.255337, 11><13, 14.021113, 11>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.021113, 11><13, 13.810556, 10><12, 14.041850, 10>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.255337, 11><12, 13.953426, 12><13, 13.640700, 12>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.640700, 12><13, 14.021113, 11><12, 14.255337, 11>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.953426, 12><12, 14.109450, 13><13, 13.793795, 13>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.793795, 13><13, 13.640700, 12><12, 13.953426, 12>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.109450, 13><12, 13.868658, 14><13, 12.872621, 14>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.872621, 14><13, 13.793795, 13><12, 14.109450, 13>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.868658, 14><12, 13.361610, 15><13, 12.362643, 15>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.362643, 15><13, 12.872621, 14><12, 13.868658, 14>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.361610, 15><12, 13.812521, 16><13, 13.543295, 16>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.543295, 16><13, 12.362643, 15><12, 13.361610, 15>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.812521, 16><12, 14.023774, 17><13, 13.751618, 17>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.751618, 17><13, 13.543295, 16><12, 13.812521, 16>
  texture { T_Moon } 
  }
  triangle {
  <12, 14.023774, 17><12, 13.737457, 18><13, 13.309915, 18>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.309915, 18><13, 13.751618, 17><12, 14.023774, 17>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.737457, 18><12, 13.801015, 19><13, 13.370543, 19>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.370543, 19><13, 13.309915, 18><12, 13.737457, 18>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.801015, 19><12, 13.671917, 20><13, 13.293448, 20>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.293448, 20><13, 13.370543, 19><12, 13.801015, 19>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.671917, 20><12, 13.785636, 21><13, 13.404238, 21>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.404238, 21><13, 13.293448, 20><12, 13.671917, 20>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.785636, 21><12, 13.569300, 22><13, 12.856566, 22>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.856566, 22><13, 13.404238, 21><12, 13.785636, 21>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.569300, 22><12, 13.386908, 23><13, 12.671245, 23>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.671245, 23><13, 12.856566, 22><12, 13.569300, 22>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.386908, 23><12, 13.531126, 24><13, 12.660510, 24>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.660510, 24><13, 12.671245, 23><12, 13.386908, 23>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.531126, 24><12, 13.164355, 25><13, 12.290810, 25>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.290810, 25><13, 12.660510, 24><12, 13.531126, 24>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.164355, 25><12, 13.442266, 26><13, 12.397568, 26>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.397568, 26><13, 12.290810, 25><12, 13.164355, 25>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.442266, 26><12, 12.925756, 27><13, 11.878130, 27>
  texture { T_Moon } 
  }
  triangle {
  <13, 11.878130, 27><13, 12.397568, 26><12, 13.442266, 26>
  texture { T_Moon } 
  }
  triangle {
  <12, 12.925756, 27><12, 13.390377, 28><13, 12.786098, 28>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.786098, 28><13, 11.878130, 27><12, 12.925756, 27>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.390377, 28><12, 13.301723, 29><13, 12.694512, 29>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.694512, 29><13, 12.786098, 28><12, 13.390377, 28>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.301723, 29><12, 13.281634, 30><13, 13.011129, 30>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.011129, 30><13, 12.694512, 29><12, 13.301723, 29>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.281634, 30><12, 13.571106, 31><13, 13.297672, 31>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.297672, 31><13, 13.011129, 30><12, 13.281634, 30>
  texture { T_Moon } 
  }
  triangle {
  <12, 13.571106, 31><12, 13.249876, 32><13, 12.973513, 32>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.973513, 32><13, 13.297672, 31><12, 13.571106, 31>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.101965, 0><13, 14.259558, 1><14, 13.326469, 1>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.326469, 1><14, 13.460892, 0><13, 14.101965, 0>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.259558, 1><13, 13.398788, 2><14, 13.402252, 2>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.402252, 2><14, 13.326469, 1><13, 14.259558, 1>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.398788, 2><13, 12.882629, 3><14, 12.760778, 3>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.760778, 3><14, 13.402252, 2><13, 13.398788, 2>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.882629, 3><13, 13.207191, 4><14, 13.264786, 4>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.264786, 4><14, 12.760778, 3><13, 12.882629, 3>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.207191, 4><13, 12.622244, 5><14, 13.602225, 5>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.602225, 5><14, 13.264786, 4><13, 13.207191, 4>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.622244, 5><13, 13.241536, 6><14, 13.173958, 6>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.173958, 6><14, 13.602225, 5><13, 12.622244, 5>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.241536, 6><13, 12.784664, 7><14, 13.370543, 7>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.370543, 7><14, 13.173958, 6><13, 13.241536, 6>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.784664, 7><13, 14.142036, 8><14, 13.127637, 8>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.127637, 8><14, 13.370543, 7><13, 12.784664, 7>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.142036, 8><13, 14.644348, 9><14, 13.051026, 9>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.051026, 9><14, 13.127637, 8><13, 14.142036, 8>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.644348, 9><13, 13.810556, 10><14, 13.063868, 10>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.063868, 10><14, 13.051026, 9><13, 14.644348, 9>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.810556, 10><13, 14.021113, 11><14, 12.781879, 11>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.781879, 11><14, 13.063868, 10><13, 13.810556, 10>
  texture { T_Moon } 
  }
  triangle {
  <13, 14.021113, 11><13, 13.640700, 12><14, 12.931158, 12>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.931158, 12><14, 12.781879, 11><13, 14.021113, 11>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.640700, 12><13, 13.793795, 13><14, 13.412922, 13>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.412922, 13><14, 12.931158, 12><13, 13.640700, 12>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.793795, 13><13, 12.872621, 14><14, 12.834671, 14>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.834671, 14><14, 13.412922, 13><13, 13.793795, 13>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.872621, 14><13, 12.362643, 15><14, 12.859160, 15>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.859160, 15><14, 12.834671, 14><13, 12.872621, 14>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.362643, 15><13, 13.543295, 16><14, 12.776499, 16>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.776499, 16><14, 12.859160, 15><13, 12.362643, 15>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.543295, 16><13, 13.751618, 17><14, 12.308272, 17>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.308272, 17><14, 12.776499, 16><13, 13.543295, 16>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.751618, 17><13, 13.309915, 18><14, 12.689716, 18>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.689716, 18><14, 12.308272, 17><13, 13.751618, 17>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.309915, 18><13, 13.370543, 19><14, 12.260001, 19>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.260001, 19><14, 12.689716, 18><13, 13.309915, 18>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.370543, 19><13, 13.293448, 20><14, 12.584925, 20>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.584925, 20><14, 12.260001, 19><13, 13.370543, 19>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.293448, 20><13, 13.404238, 21><14, 12.414791, 21>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.414791, 21><14, 12.584925, 20><13, 13.293448, 20>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.404238, 21><13, 12.856566, 22><14, 12.470589, 22>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.470589, 22><14, 12.414791, 21><13, 13.404238, 21>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.856566, 22><13, 12.671245, 23><14, 12.049865, 23>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.049865, 23><14, 12.470589, 22><13, 12.856566, 22>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.671245, 23><13, 12.660510, 24><14, 12.434577, 24>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.434577, 24><14, 12.049865, 23><13, 12.671245, 23>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.660510, 24><13, 12.290810, 25><14, 12.886295, 25>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.886295, 25><14, 12.434577, 24><13, 12.660510, 24>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.290810, 25><13, 12.397568, 26><14, 12.333998, 26>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.333998, 26><14, 12.886295, 25><13, 12.290810, 25>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.397568, 26><13, 11.878130, 27><14, 12.878265, 27>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.878265, 27><14, 12.333998, 26><13, 12.397568, 26>
  texture { T_Moon } 
  }
  triangle {
  <13, 11.878130, 27><13, 12.786098, 28><14, 12.250384, 28>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.250384, 28><14, 12.878265, 27><13, 11.878130, 27>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.786098, 28><13, 12.694512, 29><14, 11.729495, 29>
  texture { T_Moon } 
  }
  triangle {
  <14, 11.729495, 29><14, 12.250384, 28><13, 12.786098, 28>
  texture { T_Moon } 
  }
  triangle {
  <13, 12.694512, 29><13, 13.011129, 30><14, 12.129923, 30>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.129923, 30><14, 11.729495, 29><13, 12.694512, 29>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.011129, 30><13, 13.297672, 31><14, 12.424507, 31>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.424507, 31><14, 12.129923, 30><13, 13.011129, 30>
  texture { T_Moon } 
  }
  triangle {
  <13, 13.297672, 31><13, 12.973513, 32><14, 12.086446, 32>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.086446, 32><14, 12.424507, 31><13, 13.297672, 31>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.460892, 0><14, 13.326469, 1><15, 12.737991, 1>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.737991, 1><15, 12.875343, 0><14, 13.460892, 0>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.326469, 1><14, 13.402252, 2><15, 12.327148, 2>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.327148, 2><15, 12.737991, 1><14, 13.326469, 1>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.402252, 2><14, 12.760778, 3><15, 11.682745, 3>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.682745, 3><15, 12.327148, 2><14, 13.402252, 2>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.760778, 3><14, 13.264786, 4><15, 13.171533, 4>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.171533, 4><15, 11.682745, 3><14, 12.760778, 3>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.264786, 4><14, 13.602225, 5><15, 13.506042, 5>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.506042, 5><15, 13.171533, 4><14, 13.264786, 4>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.602225, 5><14, 13.173958, 6><15, 12.925231, 6>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.925231, 6><15, 13.506042, 5><14, 13.602225, 5>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.173958, 6><14, 13.370543, 7><15, 13.118887, 7>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.118887, 7><15, 12.925231, 6><14, 13.173958, 6>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.370543, 7><14, 13.127637, 8><15, 12.581592, 8>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.581592, 8><15, 13.118887, 7><14, 13.370543, 7>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.127637, 8><14, 13.051026, 9><15, 12.502051, 9>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.502051, 9><15, 12.581592, 8><14, 13.127637, 8>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.051026, 9><14, 13.063868, 10><15, 12.324774, 10>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.324774, 10><15, 12.502051, 9><14, 13.051026, 9>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.063868, 10><14, 12.781879, 11><15, 12.039856, 11>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.039856, 11><15, 12.324774, 10><14, 13.063868, 10>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.781879, 11><14, 12.931158, 12><15, 12.964412, 12>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.964412, 12><15, 12.039856, 11><14, 12.781879, 11>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.931158, 12><14, 13.412922, 13><15, 13.443246, 13>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.443246, 13><15, 12.964412, 12><14, 12.931158, 12>
  texture { T_Moon } 
  }
  triangle {
  <14, 13.412922, 13><14, 12.834671, 14><15, 12.390410, 14>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.390410, 14><15, 13.443246, 13><14, 13.412922, 13>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.834671, 14><14, 12.859160, 15><15, 12.411970, 15>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.411970, 15><15, 12.390410, 14><14, 12.834671, 14>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.859160, 15><14, 12.776499, 16><15, 11.838414, 16>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.838414, 16><15, 12.411970, 15><14, 12.859160, 15>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.776499, 16><14, 12.308272, 17><15, 11.367258, 17>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.367258, 17><15, 11.838414, 16><14, 12.776499, 16>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.308272, 17><14, 12.689716, 18><15, 11.779522, 18>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.779522, 18><15, 11.367258, 17><14, 12.308272, 17>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.689716, 18><14, 12.260001, 19><15, 11.346877, 19>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.346877, 19><15, 11.779522, 18><14, 12.689716, 18>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.260001, 19><14, 12.584925, 20><15, 11.960757, 20>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.960757, 20><15, 11.346877, 19><14, 12.260001, 19>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.584925, 20><14, 12.414791, 21><15, 11.787694, 21>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.787694, 21><15, 11.960757, 20><14, 12.584925, 20>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.414791, 21><14, 12.470589, 22><15, 11.557677, 22>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.557677, 22><15, 11.787694, 21><14, 12.414791, 21>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.470589, 22><14, 12.049865, 23><15, 11.134024, 23>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.134024, 23><15, 11.557677, 22><14, 12.470589, 22>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.049865, 23><14, 12.434577, 24><15, 12.406797, 24>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.406797, 24><15, 11.134024, 23><14, 12.049865, 23>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.434577, 24><14, 12.886295, 25><15, 12.855586, 25>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.855586, 25><15, 12.406797, 24><14, 12.434577, 24>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.886295, 25><14, 12.333998, 26><15, 12.374420, 26>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.374420, 26><15, 12.855586, 25><14, 12.886295, 25>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.333998, 26><14, 12.878265, 27><15, 12.915758, 27>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.915758, 27><15, 12.374420, 26><14, 12.333998, 26>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.878265, 27><14, 12.250384, 28><15, 11.258222, 28>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.258222, 28><15, 12.915758, 27><14, 12.878265, 27>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.250384, 28><14, 11.729495, 29><15, 10.734404, 29>
  texture { T_Moon } 
  }
  triangle {
  <15, 10.734404, 29><15, 11.258222, 28><14, 12.250384, 28>
  texture { T_Moon } 
  }
  triangle {
  <14, 11.729495, 29><14, 12.129923, 30><15, 11.908882, 30>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.908882, 30><15, 10.734404, 29><14, 11.729495, 29>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.129923, 30><14, 12.424507, 31><15, 12.200535, 31>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.200535, 31><15, 11.908882, 30><14, 12.129923, 30>
  texture { T_Moon } 
  }
  triangle {
  <14, 12.424507, 31><14, 12.086446, 32><15, 11.859545, 32>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.859545, 32><15, 12.200535, 31><14, 12.424507, 31>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.875343, 0><15, 12.737991, 1><16, 12.687737, 1>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.687737, 1><16, 12.500000, 0><15, 12.875343, 0>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.737991, 1><15, 12.327148, 2><16, 12.435390, 2>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.435390, 2><16, 12.687737, 1><15, 12.737991, 1>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.327148, 2><15, 11.682745, 3><16, 11.796278, 3>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.796278, 3><16, 12.435390, 2><15, 12.327148, 2>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.682745, 3><15, 13.171533, 4><16, 12.312588, 4>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.312588, 4><16, 11.796278, 3><15, 11.682745, 3>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.171533, 4><15, 13.506042, 5><16, 12.628736, 5>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.628736, 5><16, 12.312588, 4><15, 13.171533, 4>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.506042, 5><15, 12.925231, 6><16, 12.186017, 6>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.186017, 6><16, 12.628736, 5><15, 13.506042, 5>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.925231, 6><15, 13.118887, 7><16, 12.630709, 7>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.630709, 7><16, 12.186017, 6><15, 12.925231, 6>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.118887, 7><15, 12.581592, 8><16, 12.125000, 8>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.125000, 8><16, 12.630709, 7><15, 13.118887, 7>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.581592, 8><15, 12.502051, 9><16, 11.948420, 9>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.948420, 9><16, 12.125000, 8><15, 12.581592, 8>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.502051, 9><15, 12.324774, 10><16, 12.049643, 10>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.049643, 10><16, 11.948420, 9><15, 12.502051, 9>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.324774, 10><15, 12.039856, 11><16, 12.572889, 11>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.572889, 11><16, 12.049643, 10><15, 12.324774, 10>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.039856, 11><15, 12.964412, 12><16, 11.937613, 12>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.937613, 12><16, 12.572889, 11><15, 12.039856, 11>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.964412, 12><15, 13.443246, 13><16, 11.382684, 13>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.382684, 13><16, 11.937613, 12><15, 12.964412, 12>
  texture { T_Moon } 
  }
  triangle {
  <15, 13.443246, 13><15, 12.390410, 14><16, 11.870509, 14>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.870509, 14><16, 11.382684, 13><15, 13.443246, 13>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.390410, 14><15, 12.411970, 15><16, 12.115724, 15>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.115724, 15><16, 11.870509, 14><15, 12.390410, 14>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.411970, 15><15, 11.838414, 16><16, 11.750000, 16>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.750000, 16><16, 12.115724, 15><15, 12.411970, 15>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.838414, 16><15, 11.367258, 17><16, 12.197248, 17>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.197248, 17><16, 11.750000, 16><15, 11.838414, 16>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.367258, 17><15, 11.779522, 18><16, 11.678565, 18>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.678565, 18><16, 12.197248, 17><15, 11.367258, 17>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.779522, 18><15, 11.346877, 19><16, 11.550015, 19>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.550015, 19><16, 11.678565, 18><15, 11.779522, 18>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.346877, 19><15, 11.960757, 20><16, 11.562484, 20>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.562484, 20><16, 11.550015, 19><15, 11.346877, 19>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.960757, 20><15, 11.787694, 21><16, 11.029738, 21>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.029738, 21><16, 11.562484, 20><15, 11.960757, 20>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.787694, 21><15, 11.557677, 22><16, 11.457142, 22>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.457142, 22><16, 11.029738, 21><15, 11.787694, 21>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.557677, 22><15, 11.134024, 23><16, 11.476681, 23>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.476681, 23><16, 11.457142, 22><15, 11.557677, 22>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.134024, 23><15, 12.406797, 24><16, 11.375000, 24>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.375000, 24><16, 11.476681, 23><15, 11.134024, 23>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.406797, 24><15, 12.855586, 25><16, 11.277098, 25>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.277098, 25><16, 11.375000, 24><15, 12.406797, 24>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.855586, 25><15, 12.374420, 26><16, 11.314239, 26>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.314239, 26><16, 11.277098, 25><15, 12.855586, 25>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.374420, 26><15, 12.915758, 27><16, 11.831442, 27>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.831442, 27><16, 11.314239, 26><15, 12.374420, 26>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.915758, 27><15, 11.258222, 28><16, 11.187406, 28>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.187406, 28><16, 11.831442, 27><15, 12.915758, 27>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.258222, 28><15, 10.734404, 29><16, 11.514668, 29>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.514668, 29><16, 11.187406, 28><15, 11.258222, 28>
  texture { T_Moon } 
  }
  triangle {
  <15, 10.734404, 29><15, 11.908882, 30><16, 11.078809, 30>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.078809, 30><16, 11.514668, 29><15, 10.734404, 29>
  texture { T_Moon } 
  }
  triangle {
  <15, 11.908882, 30><15, 12.200535, 31><16, 11.440261, 31>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.440261, 31><16, 11.078809, 30><15, 11.908882, 30>
  texture { T_Moon } 
  }
  triangle {
  <15, 12.200535, 31><15, 11.859545, 32><16, 11.000000, 32>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.000000, 32><16, 11.440261, 31><15, 12.200535, 31>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.500000, 0><16, 12.687737, 1><17, 12.450669, 1>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.450669, 1><17, 12.265862, 0><16, 12.500000, 0>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.687737, 1><16, 12.435390, 2><17, 11.397638, 2>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.397638, 2><17, 12.450669, 1><16, 12.687737, 1>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.435390, 2><16, 11.796278, 3><17, 10.755597, 3>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.755597, 3><17, 11.397638, 2><16, 12.435390, 2>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.796278, 3><16, 12.312588, 4><17, 12.195187, 4>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.195187, 4><17, 10.755597, 3><16, 11.796278, 3>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.312588, 4><16, 12.628736, 5><17, 12.508408, 5>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.508408, 5><17, 12.195187, 4><16, 12.312588, 4>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.628736, 5><16, 12.186017, 6><17, 12.158524, 6>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.158524, 6><17, 12.508408, 5><16, 12.628736, 5>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.186017, 6><16, 12.630709, 7><17, 12.600285, 7>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.600285, 7><17, 12.158524, 6><16, 12.186017, 6>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.630709, 7><16, 12.125000, 8><17, 11.503107, 8>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.503107, 8><17, 12.600285, 7><16, 12.630709, 7>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.125000, 8><16, 11.948420, 9><17, 11.323597, 9>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.323597, 9><17, 11.503107, 8><16, 12.125000, 8>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.948420, 9><16, 12.049643, 10><17, 12.140054, 10>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.140054, 10><17, 11.323597, 9><16, 11.948420, 9>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.049643, 10><16, 12.572889, 11><17, 12.660371, 11>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.660371, 11><17, 12.140054, 10><16, 12.049643, 10>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.572889, 11><16, 11.937613, 12><17, 10.925710, 12>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.925710, 12><17, 12.660371, 11><16, 12.572889, 11>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.937613, 12><16, 11.382684, 13><17, 10.367851, 13>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.367851, 13><17, 10.925710, 12><16, 11.937613, 12>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.382684, 13><16, 11.870509, 14><17, 11.679591, 14>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.679591, 14><17, 10.367851, 13><16, 11.382684, 13>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.870509, 14><16, 12.115724, 15><17, 11.921876, 15>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.921876, 15><17, 11.679591, 14><16, 11.870509, 14>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.115724, 15><16, 11.750000, 16><17, 11.728498, 16>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.728498, 16><17, 11.921876, 15><16, 12.115724, 15>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.750000, 16><16, 12.197248, 17><17, 12.172814, 17>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.172814, 17><17, 11.728498, 16><16, 11.750000, 16>
  texture { T_Moon } 
  }
  triangle {
  <16, 12.197248, 17><16, 11.678565, 18><17, 11.097729, 18>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.097729, 18><17, 12.172814, 17><16, 12.197248, 17>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.678565, 18><16, 11.550015, 19><17, 10.966249, 19>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.966249, 19><17, 11.097729, 18><16, 11.678565, 18>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.550015, 19><16, 11.562484, 20><17, 10.549260, 20>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.549260, 20><17, 10.966249, 19><16, 11.550015, 19>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.562484, 20><16, 11.029738, 21><17, 10.013585, 21>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.013585, 21><17, 10.549260, 20><16, 11.562484, 20>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.029738, 21><16, 11.457142, 22><17, 10.978745, 22>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.978745, 22><17, 10.013585, 21><16, 11.029738, 21>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.457142, 22><16, 11.476681, 23><17, 10.995354, 23>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.995354, 23><17, 10.978745, 22><16, 11.457142, 22>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.476681, 23><16, 11.375000, 24><17, 10.784910, 24>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.784910, 24><17, 10.995354, 23><16, 11.476681, 23>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.375000, 24><16, 11.277098, 25><17, 10.684077, 25>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.684077, 25><17, 10.784910, 24><16, 11.375000, 24>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.277098, 25><16, 11.314239, 26><17, 11.366431, 26>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.366431, 26><17, 10.684077, 25><16, 11.277098, 25>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.314239, 26><16, 11.831442, 27><17, 11.880705, 27>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.880705, 27><17, 11.366431, 26><16, 11.314239, 26>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.831442, 27><16, 11.187406, 28><17, 11.010715, 28>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.010715, 28><17, 11.880705, 27><16, 11.831442, 27>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.187406, 28><16, 11.514668, 29><17, 11.335047, 29>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.335047, 29><17, 11.010715, 28><16, 11.187406, 28>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.514668, 29><16, 11.078809, 30><17, 10.915555, 30>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.915555, 30><17, 11.335047, 29><16, 11.514668, 29>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.078809, 30><16, 11.440261, 31><17, 11.274077, 31>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.274077, 31><17, 10.915555, 30><16, 11.078809, 30>
  texture { T_Moon } 
  }
  triangle {
  <16, 11.440261, 31><16, 11.000000, 32><17, 10.830886, 32>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.830886, 32><17, 11.274077, 31><16, 11.440261, 31>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.265862, 0><17, 12.450669, 1><18, 11.052809, 1>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.052809, 1><18, 11.591640, 0><17, 12.265862, 0>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.450669, 1><17, 11.397638, 2><18, 11.515310, 2>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.515310, 2><18, 11.052809, 1><17, 12.450669, 1>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.397638, 2><17, 10.755597, 3><18, 11.541459, 3>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.541459, 3><18, 11.515310, 2><17, 11.397638, 2>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.755597, 3><17, 12.195187, 4><18, 11.318917, 4>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.318917, 4><18, 11.541459, 3><17, 10.755597, 3>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.195187, 4><17, 12.508408, 5><18, 10.821440, 5>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.821440, 5><18, 11.318917, 4><17, 12.195187, 4>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.508408, 5><17, 12.158524, 6><18, 11.180628, 6>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.180628, 6><18, 10.821440, 5><17, 12.508408, 5>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.158524, 6><17, 12.600285, 7><18, 11.128488, 7>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.128488, 7><18, 11.180628, 6><17, 12.158524, 6>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.600285, 7><17, 11.503107, 8><18, 11.159018, 8>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.159018, 8><18, 11.128488, 7><17, 12.600285, 7>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.503107, 8><17, 11.323597, 9><18, 11.339993, 9>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.339993, 9><18, 11.159018, 8><17, 11.503107, 8>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.323597, 9><17, 12.140054, 10><18, 11.071941, 10>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.071941, 10><18, 11.339993, 9><17, 11.323597, 9>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.140054, 10><17, 12.660371, 11><18, 11.511171, 11>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.511171, 11><18, 11.071941, 10><17, 12.140054, 10>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.660371, 11><17, 10.925710, 12><18, 10.956559, 12>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.956559, 12><18, 11.511171, 11><17, 12.660371, 11>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.925710, 12><17, 10.367851, 13><18, 10.697738, 13>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.697738, 13><18, 10.956559, 12><17, 10.925710, 12>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.367851, 13><17, 11.679591, 14><18, 10.877737, 14>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.877737, 14><18, 10.697738, 13><17, 10.367851, 13>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.679591, 14><17, 11.921876, 15><18, 11.319983, 15>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.319983, 15><18, 10.877737, 14><17, 11.679591, 14>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.921876, 15><17, 11.728498, 16><18, 10.741065, 16>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.741065, 16><18, 11.319983, 15><17, 11.921876, 15>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.728498, 16><17, 12.172814, 17><18, 11.188480, 17>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.188480, 17><18, 10.741065, 16><17, 11.728498, 16>
  texture { T_Moon } 
  }
  triangle {
  <17, 12.172814, 17><17, 11.097729, 18><18, 10.657910, 18>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.657910, 18><18, 11.188480, 17><17, 12.172814, 17>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.097729, 18><17, 10.966249, 19><18, 10.906533, 19>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.906533, 19><18, 10.657910, 18><17, 11.097729, 18>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.966249, 19><17, 10.549260, 20><18, 10.496187, 20>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.496187, 20><18, 10.906533, 19><17, 10.966249, 19>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.549260, 20><17, 10.013585, 21><18, 10.634889, 21>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.634889, 21><18, 10.496187, 20><17, 10.549260, 20>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.013585, 21><17, 10.978745, 22><18, 10.379127, 22>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.379127, 22><18, 10.634889, 21><17, 10.013585, 21>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.978745, 22><17, 10.995354, 23><18, 10.191562, 23>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.191562, 23><18, 10.379127, 22><17, 10.978745, 22>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.995354, 23><17, 10.784910, 24><18, 10.329864, 24>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.329864, 24><18, 10.191562, 23><17, 10.995354, 23>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.784910, 24><17, 10.684077, 25><18, 10.612290, 25>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.612290, 25><18, 10.329864, 24><17, 10.784910, 24>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.684077, 25><17, 11.366431, 26><18, 10.257384, 26>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.257384, 26><18, 10.612290, 25><17, 10.684077, 25>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.366431, 26><17, 11.880705, 27><18, 10.151843, 27>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.151843, 27><18, 10.257384, 26><17, 11.366431, 26>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.880705, 27><17, 11.010715, 28><18, 10.070903, 28>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.070903, 28><18, 10.151843, 27><17, 11.880705, 27>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.010715, 28><17, 11.335047, 29><18, 9.715992, 29>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.715992, 29><18, 10.070903, 28><17, 11.010715, 28>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.335047, 29><17, 10.915555, 30><18, 9.950587, 30>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.950587, 30><18, 9.715992, 29><17, 11.335047, 29>
  texture { T_Moon } 
  }
  triangle {
  <17, 10.915555, 30><17, 11.274077, 31><18, 9.587915, 31>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.587915, 31><18, 9.950587, 30><17, 10.915555, 30>
  texture { T_Moon } 
  }
  triangle {
  <17, 11.274077, 31><17, 10.830886, 32><18, 9.860059, 32>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.860059, 32><18, 9.587915, 31><17, 11.274077, 31>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.591640, 0><18, 11.052809, 1><19, 10.065938, 1>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.065938, 1><19, 10.607698, 0><18, 11.591640, 0>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.052809, 1><18, 11.515310, 2><19, 11.119584, 2>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.119584, 2><19, 10.065938, 1><18, 11.052809, 1>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.515310, 2><18, 11.541459, 3><19, 11.142804, 3>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.142804, 3><19, 11.119584, 2><18, 11.515310, 2>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.541459, 3><18, 11.318917, 4><19, 10.426525, 4>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.426525, 4><19, 11.142804, 3><18, 11.541459, 3>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.318917, 4><18, 10.821440, 5><19, 9.926118, 5>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.926118, 5><19, 10.426525, 4><18, 11.318917, 4>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.821440, 5><18, 11.180628, 6><19, 10.694938, 6>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.694938, 6><19, 9.926118, 5><18, 10.821440, 5>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.180628, 6><18, 11.128488, 7><19, 10.639867, 7>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.639867, 7><19, 10.694938, 6><18, 11.180628, 6>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.128488, 7><18, 11.159018, 8><19, 10.882203, 8>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.882203, 8><19, 10.639867, 7><18, 11.128488, 7>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.159018, 8><18, 11.339993, 9><19, 11.060248, 9>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.060248, 9><19, 10.882203, 8><18, 11.159018, 8>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.339993, 9><18, 11.071941, 10><19, 11.065859, 10>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.065859, 10><19, 11.060248, 9><18, 11.339993, 9>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.071941, 10><18, 11.511171, 11><19, 11.502159, 11>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.502159, 11><19, 11.065859, 10><18, 11.071941, 10>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.511171, 11><18, 10.956559, 12><19, 10.219918, 12>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.219918, 12><19, 11.502159, 11><18, 11.511171, 11>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.956559, 12><18, 10.697738, 13><19, 9.958167, 13>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.958167, 13><19, 10.219918, 12><18, 10.956559, 12>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.697738, 13><18, 10.877737, 14><19, 10.863008, 14>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.863008, 14><19, 9.958167, 13><18, 10.697738, 13>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.877737, 14><18, 11.319983, 15><19, 11.302324, 15>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.302324, 15><19, 10.863008, 14><18, 10.877737, 14>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.319983, 15><18, 10.741065, 16><19, 10.703268, 16>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.703268, 16><19, 11.302324, 15><18, 11.319983, 15>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.741065, 16><18, 11.188480, 17><19, 11.147755, 17>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.147755, 17><19, 10.703268, 16><18, 10.741065, 16>
  texture { T_Moon } 
  }
  triangle {
  <18, 11.188480, 17><18, 10.657910, 18><19, 10.437783, 18>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.437783, 18><19, 11.147755, 17><18, 11.188480, 17>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.657910, 18><18, 10.906533, 19><19, 10.683477, 19>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.683477, 19><19, 10.437783, 18><18, 10.657910, 18>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.906533, 19><18, 10.496187, 20><19, 10.171872, 20>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.171872, 20><19, 10.683477, 19><18, 10.906533, 19>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.496187, 20><18, 10.634889, 21><19, 10.307644, 21>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.307644, 21><19, 10.171872, 20><18, 10.496187, 20>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.634889, 21><18, 10.379127, 22><19, 9.711083, 22>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.711083, 22><19, 10.307644, 21><18, 10.634889, 21>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.379127, 22><18, 10.191562, 23><19, 9.520589, 23>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.520589, 23><19, 9.711083, 22><18, 10.379127, 22>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.191562, 23><18, 10.329864, 24><19, 10.092926, 24>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.092926, 24><19, 9.520589, 23><18, 10.191562, 23>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.329864, 24><18, 10.612290, 25><19, 10.372423, 25>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.372423, 25><19, 10.092926, 24><18, 10.329864, 24>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.612290, 25><18, 10.257384, 26><19, 9.659656, 26>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.659656, 26><19, 10.372423, 25><18, 10.612290, 25>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.257384, 26><18, 10.151843, 27><19, 9.551185, 27>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.551185, 27><19, 9.659656, 26><18, 10.257384, 26>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.151843, 27><18, 10.070903, 28><19, 9.232791, 28>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.232791, 28><19, 9.551185, 27><18, 10.151843, 27>
  texture { T_Moon } 
  }
  triangle {
  <18, 10.070903, 28><18, 9.715992, 29><19, 8.874951, 29>
  texture { T_Moon } 
  }
  triangle {
  <19, 8.874951, 29><19, 9.232791, 28><18, 10.070903, 28>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.715992, 29><18, 9.950587, 30><19, 9.083962, 30>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.083962, 30><19, 8.874951, 29><18, 9.715992, 29>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.950587, 30><18, 9.587915, 31><19, 8.718361, 31>
  texture { T_Moon } 
  }
  triangle {
  <19, 8.718361, 31><19, 9.083962, 30><18, 9.950587, 30>
  texture { T_Moon } 
  }
  triangle {
  <18, 9.587915, 31><18, 9.860059, 32><19, 8.987575, 32>
  texture { T_Moon } 
  }
  triangle {
  <19, 8.987575, 32><19, 8.718361, 31><18, 9.587915, 31>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.607698, 0><19, 10.065938, 1><20, 11.126879, 1>
  texture { T_Moon } 
  }
  triangle {
  <20, 11.126879, 1><20, 10.625088, 0><19, 10.607698, 0>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.065938, 1><19, 11.119584, 2><20, 10.544293, 2>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.544293, 2><20, 11.126879, 1><19, 10.065938, 1>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.119584, 2><19, 11.142804, 3><20, 10.563517, 3>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.563517, 3><20, 10.544293, 2><19, 11.119584, 2>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.142804, 3><19, 10.426525, 4><20, 10.390800, 4>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.390800, 4><20, 10.563517, 3><19, 11.142804, 3>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.426525, 4><19, 9.926118, 5><20, 10.143173, 5>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.143173, 5><20, 10.390800, 4><19, 10.426525, 4>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.926118, 5><19, 10.694938, 6><20, 10.271064, 6>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.271064, 6><20, 10.143173, 5><19, 9.926118, 5>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.694938, 6><19, 10.639867, 7><20, 10.572777, 7>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.572777, 7><20, 10.271064, 6><19, 10.694938, 6>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.639867, 7><19, 10.882203, 8><20, 10.156363, 8>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.156363, 8><20, 10.572777, 7><19, 10.639867, 7>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.882203, 8><19, 11.060248, 9><20, 9.878918, 9>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.878918, 9><20, 10.156363, 8><19, 10.882203, 8>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.060248, 9><19, 11.065859, 10><20, 10.051641, 10>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.051641, 10><20, 9.878918, 9><19, 11.060248, 9>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.065859, 10><19, 11.502159, 11><20, 9.461471, 11>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.461471, 11><20, 10.051641, 10><19, 11.065859, 10>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.502159, 11><19, 10.219918, 12><20, 9.922100, 12>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.922100, 12><20, 9.461471, 11><19, 11.502159, 11>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.219918, 12><19, 9.958167, 13><20, 10.243877, 13>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.243877, 13><20, 9.922100, 12><19, 10.219918, 12>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.958167, 13><19, 10.863008, 14><20, 9.787161, 14>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.787161, 14><20, 10.243877, 13><19, 9.958167, 13>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.863008, 14><19, 11.302324, 15><20, 9.146357, 15>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.146357, 15><20, 9.787161, 14><19, 10.863008, 14>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.302324, 15><19, 10.703268, 16><20, 9.687484, 16>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.687484, 16><20, 9.146357, 15><19, 11.302324, 15>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.703268, 16><19, 11.147755, 17><20, 9.263647, 17>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.263647, 17><20, 9.687484, 16><19, 10.703268, 16>
  texture { T_Moon } 
  }
  triangle {
  <19, 11.147755, 17><19, 10.437783, 18><20, 9.603170, 18>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.603170, 18><20, 9.263647, 17><19, 11.147755, 17>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.437783, 18><19, 10.683477, 19><20, 9.115976, 19>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.115976, 19><20, 9.603170, 18><19, 10.437783, 18>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.683477, 19><19, 10.171872, 20><20, 9.453093, 20>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.453093, 20><20, 9.115976, 19><19, 10.683477, 19>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.171872, 20><19, 10.307644, 21><20, 9.993586, 21>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.993586, 21><20, 9.453093, 20><19, 10.171872, 20>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.307644, 21><19, 9.711083, 22><20, 9.350991, 22>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.350991, 22><20, 9.993586, 21><19, 10.307644, 21>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.711083, 22><19, 9.520589, 23><20, 9.435503, 23>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.435503, 23><20, 9.350991, 22><19, 9.711083, 22>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.520589, 23><19, 10.092926, 24><20, 9.218656, 24>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.218656, 24><20, 9.435503, 23><19, 9.520589, 23>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.092926, 24><19, 10.372423, 25><20, 9.677047, 25>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.677047, 25><20, 9.218656, 24><19, 10.092926, 24>
  texture { T_Moon } 
  }
  triangle {
  <19, 10.372423, 25><19, 9.659656, 26><20, 9.128138, 26>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.128138, 26><20, 9.677047, 25><19, 10.372423, 25>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.659656, 26><19, 9.551185, 27><20, 9.329166, 27>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.329166, 27><20, 9.128138, 26><19, 9.659656, 26>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.551185, 27><19, 9.232791, 28><20, 8.984186, 28>
  texture { T_Moon } 
  }
  triangle {
  <20, 8.984186, 28><20, 9.329166, 27><19, 9.551185, 27>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.232791, 28><19, 8.874951, 29><20, 9.437786, 29>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.437786, 29><20, 8.984186, 28><19, 9.232791, 28>
  texture { T_Moon } 
  }
  triangle {
  <19, 8.874951, 29><19, 9.083962, 30><20, 8.860739, 30>
  texture { T_Moon } 
  }
  triangle {
  <20, 8.860739, 30><20, 9.437786, 29><19, 8.874951, 29>
  texture { T_Moon } 
  }
  triangle {
  <19, 9.083962, 30><19, 8.718361, 31><20, 9.270488, 31>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.270488, 31><20, 8.860739, 30><19, 9.083962, 30>
  texture { T_Moon } 
  }
  triangle {
  <19, 8.718361, 31><19, 8.987575, 32><20, 8.749906, 32>
  texture { T_Moon } 
  }
  triangle {
  <20, 8.749906, 32><20, 9.270488, 31><19, 8.718361, 31>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.625088, 0><20, 11.126879, 1><21, 11.215542, 1>
  texture { T_Moon } 
  }
  triangle {
  <21, 11.215542, 1><21, 10.716679, 0><20, 10.625088, 0>
  texture { T_Moon } 
  }
  triangle {
  <20, 11.126879, 1><20, 10.544293, 2><21, 10.183807, 2>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.183807, 2><21, 11.215542, 1><20, 11.126879, 1>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.544293, 2><20, 10.563517, 3><21, 10.200101, 3>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.200101, 3><21, 10.183807, 2><20, 10.544293, 2>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.563517, 3><20, 10.390800, 4><21, 9.721298, 4>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.721298, 4><21, 10.200101, 3><20, 10.563517, 3>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.390800, 4><20, 10.143173, 5><21, 9.470740, 5>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.470740, 5><21, 9.721298, 4><20, 10.390800, 4>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.143173, 5><20, 10.271064, 6><21, 10.142536, 6>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.142536, 6><21, 9.470740, 5><20, 10.143173, 5>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.271064, 6><20, 10.572777, 7><21, 10.441319, 7>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.441319, 7><21, 10.142536, 6><20, 10.271064, 6>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.572777, 7><20, 10.156363, 8><21, 9.445268, 8>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.445268, 8><21, 10.441319, 7><20, 10.572777, 7>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.156363, 8><20, 9.878918, 9><21, 9.164893, 9>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.164893, 9><21, 9.445268, 8><20, 10.156363, 8>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.878918, 9><20, 10.051641, 10><21, 9.034371, 10>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.034371, 10><21, 9.164893, 9><20, 9.878918, 9>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.051641, 10><20, 9.461471, 11><21, 8.441271, 11>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.441271, 11><21, 9.034371, 10><20, 10.051641, 10>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.461471, 11><20, 9.922100, 12><21, 9.798565, 12>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.798565, 12><21, 8.441271, 11><20, 9.461471, 11>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.922100, 12><20, 10.243877, 13><21, 10.117413, 13>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.117413, 13><21, 9.798565, 12><20, 9.922100, 12>
  texture { T_Moon } 
  }
  triangle {
  <20, 10.243877, 13><20, 9.787161, 14><21, 8.677489, 14>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.677489, 14><21, 10.117413, 13><20, 10.243877, 13>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.787161, 14><20, 9.146357, 15><21, 8.033755, 15>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.033755, 15><21, 8.677489, 14><20, 9.787161, 14>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.146357, 15><20, 9.687484, 16><21, 8.806625, 16>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.806625, 16><21, 8.033755, 15><20, 9.146357, 15>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.687484, 16><20, 9.263647, 17><21, 8.379858, 17>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.379858, 17><21, 8.806625, 16><20, 9.687484, 16>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.263647, 17><20, 9.603170, 18><21, 8.685976, 18>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.685976, 18><21, 8.379858, 17><20, 9.263647, 17>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.603170, 18><20, 9.115976, 19><21, 8.195852, 19>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.195852, 19><21, 8.685976, 18><20, 9.603170, 18>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.115976, 19><20, 9.453093, 20><21, 9.524836, 20>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.524836, 20><21, 8.195852, 19><20, 9.115976, 19>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.453093, 20><20, 9.993586, 21><21, 10.062399, 21>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.062399, 21><21, 9.524836, 20><20, 9.453093, 20>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.993586, 21><20, 9.350991, 22><21, 8.975972, 22>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.975972, 22><21, 10.062399, 21><20, 9.993586, 21>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.350991, 22><20, 9.435503, 23><21, 9.057554, 23>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.057554, 23><21, 8.975972, 22><20, 9.350991, 22>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.435503, 23><20, 9.218656, 24><21, 9.196624, 24>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.196624, 24><21, 9.057554, 23><20, 9.435503, 23>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.218656, 24><20, 9.677047, 25><21, 9.652085, 25>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.652085, 25><21, 9.196624, 24><20, 9.218656, 24>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.677047, 25><20, 9.128138, 26><21, 8.869602, 26>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.869602, 26><21, 9.652085, 25><20, 9.677047, 25>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.128138, 26><20, 9.329166, 27><21, 9.067701, 27>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.067701, 27><21, 8.869602, 26><20, 9.128138, 26>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.329166, 27><20, 8.984186, 28><21, 8.945599, 28>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.945599, 28><21, 9.067701, 27><20, 9.329166, 27>
  texture { T_Moon } 
  }
  triangle {
  <20, 8.984186, 28><20, 9.437786, 29><21, 9.396269, 29>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.396269, 29><21, 8.945599, 28><20, 8.984186, 28>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.437786, 29><20, 8.860739, 30><21, 8.766133, 30>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.766133, 30><21, 9.396269, 29><20, 9.437786, 29>
  texture { T_Moon } 
  }
  triangle {
  <20, 8.860739, 30><20, 9.270488, 31><21, 9.172952, 31>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.172952, 31><21, 8.766133, 30><20, 8.860739, 30>
  texture { T_Moon } 
  }
  triangle {
  <20, 9.270488, 31><20, 8.749906, 32><21, 8.649441, 32>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.649441, 32><21, 9.172952, 31><20, 9.270488, 31>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.716679, 0><21, 11.215542, 1><22, 9.594223, 1>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.594223, 1><22, 9.723893, 0><21, 10.716679, 0>
  texture { T_Moon } 
  }
  triangle {
  <21, 11.215542, 1><21, 10.183807, 2><22, 9.631380, 2>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.631380, 2><22, 9.594223, 1><21, 11.215542, 1>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.183807, 2><21, 10.200101, 3><22, 9.881655, 3>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.881655, 3><22, 9.631380, 2><21, 10.183807, 2>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.200101, 3><21, 9.721298, 4><22, 9.427314, 4>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.427314, 4><22, 9.881655, 3><21, 10.200101, 3>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.721298, 4><21, 9.470740, 5><22, 9.741497, 5>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.741497, 5><22, 9.427314, 4><21, 9.721298, 4>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.470740, 5><21, 10.142536, 6><22, 9.295858, 6>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.295858, 6><22, 9.741497, 5><21, 9.470740, 5>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.142536, 6><21, 10.441319, 7><22, 8.844402, 7>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.844402, 7><22, 9.295858, 6><21, 10.142536, 6>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.441319, 7><21, 9.445268, 8><22, 9.184341, 8>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.184341, 8><22, 8.844402, 7><21, 10.441319, 7>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.445268, 8><21, 9.164893, 9><22, 8.927207, 9>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.927207, 9><22, 9.184341, 8><21, 9.445268, 8>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.164893, 9><21, 9.034371, 10><22, 9.067902, 10>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.067902, 10><22, 8.927207, 9><21, 9.164893, 9>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.034371, 10><21, 8.441271, 11><22, 9.116610, 11>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.116610, 11><22, 9.067902, 10><21, 9.034371, 10>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.441271, 11><21, 9.798565, 12><22, 8.896536, 12>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.896536, 12><22, 9.116610, 11><21, 8.441271, 11>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.798565, 12><21, 10.117413, 13><22, 8.912926, 13>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.912926, 13><22, 8.896536, 12><21, 9.798565, 12>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.117413, 13><21, 8.677489, 14><22, 8.749878, 14>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.749878, 14><22, 8.912926, 13><21, 10.117413, 13>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.677489, 14><21, 8.033755, 15><22, 8.481902, 15>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.481902, 15><22, 8.749878, 14><21, 8.677489, 14>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.033755, 15><21, 8.806625, 16><22, 8.689125, 16>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.689125, 16><22, 8.481902, 15><21, 8.033755, 15>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.806625, 16><21, 8.379858, 17><22, 8.474113, 17>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.474113, 17><22, 8.689125, 16><21, 8.806625, 16>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.379858, 17><21, 8.685976, 18><22, 8.593092, 18>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.593092, 18><22, 8.474113, 17><21, 8.379858, 17>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.685976, 18><21, 8.195852, 19><22, 8.691825, 19>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.691825, 19><22, 8.593092, 18><21, 8.685976, 18>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.195852, 19><21, 9.524836, 20><22, 8.413491, 20>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.413491, 20><22, 8.691825, 19><21, 8.195852, 19>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.524836, 20><21, 10.062399, 21><22, 8.533865, 21>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.533865, 21><22, 8.413491, 20><21, 9.524836, 20>
  texture { T_Moon } 
  }
  triangle {
  <21, 10.062399, 21><21, 8.975972, 22><22, 8.299672, 22>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.299672, 22><22, 8.533865, 21><21, 10.062399, 21>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.975972, 22><21, 9.057554, 23><22, 8.826992, 23>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.826992, 23><22, 8.299672, 22><21, 8.975972, 22>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.057554, 23><21, 9.196624, 24><22, 8.167294, 24>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.167294, 24><22, 8.826992, 23><21, 9.057554, 23>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.196624, 24><21, 9.652085, 25><22, 8.233781, 25>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.233781, 25><22, 8.167294, 24><21, 9.196624, 24>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.652085, 25><21, 8.869602, 26><22, 8.065057, 26>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.065057, 26><22, 8.233781, 25><21, 9.652085, 25>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.869602, 26><21, 9.067701, 27><22, 7.512344, 27>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.512344, 27><22, 8.065057, 26><21, 8.869602, 26>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.067701, 27><21, 8.945599, 28><22, 7.876364, 28>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.876364, 28><22, 7.512344, 27><21, 9.067701, 27>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.945599, 28><21, 9.396269, 29><22, 8.375829, 29>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.375829, 29><22, 7.876364, 28><21, 8.945599, 28>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.396269, 29><21, 8.766133, 30><22, 7.741197, 30>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.741197, 30><22, 8.375829, 29><21, 9.396269, 29>
  texture { T_Moon } 
  }
  triangle {
  <21, 8.766133, 30><21, 9.172952, 31><22, 7.526609, 31>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.526609, 31><22, 7.741197, 30><21, 8.766133, 30>
  texture { T_Moon } 
  }
  triangle {
  <21, 9.172952, 31><21, 8.649441, 32><22, 7.618645, 32>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.618645, 32><22, 7.526609, 31><21, 9.172952, 31>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.723893, 0><22, 9.594223, 1><23, 9.020932, 1>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.020932, 1><23, 9.153532, 0><22, 9.723893, 0>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.594223, 1><22, 9.631380, 2><23, 9.471455, 2>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.471455, 2><23, 9.020932, 1><22, 9.594223, 1>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.631380, 2><22, 9.881655, 3><23, 9.718799, 3>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.718799, 3><23, 9.471455, 2><22, 9.631380, 2>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.881655, 3><22, 9.427314, 4><23, 9.327988, 4>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.327988, 4><23, 9.718799, 3><22, 9.881655, 3>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.427314, 4><22, 9.741497, 5><23, 9.639241, 5>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.639241, 5><23, 9.327988, 4><22, 9.427314, 4>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.741497, 5><22, 9.295858, 6><23, 8.422527, 6>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.422527, 6><23, 9.639241, 5><22, 9.741497, 5>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.295858, 6><22, 8.844402, 7><23, 7.968142, 7>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.968142, 7><23, 8.422527, 6><22, 9.295858, 6>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.844402, 7><22, 9.184341, 8><23, 8.487006, 8>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.487006, 8><23, 7.968142, 7><22, 8.844402, 7>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.184341, 8><22, 8.927207, 9><23, 8.226942, 9>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.226942, 9><23, 8.487006, 8><22, 9.184341, 8>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.927207, 9><22, 9.067902, 10><23, 8.682960, 10>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.682960, 10><23, 8.226942, 9><22, 8.927207, 9>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.067902, 10><22, 9.116610, 11><23, 8.728738, 11>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.728738, 11><23, 8.682960, 10><22, 9.067902, 10>
  texture { T_Moon } 
  }
  triangle {
  <22, 9.116610, 11><22, 8.896536, 12><23, 8.491168, 12>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.491168, 12><23, 8.728738, 11><22, 9.116610, 11>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.896536, 12><22, 8.912926, 13><23, 8.504628, 13>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.504628, 13><23, 8.491168, 12><22, 8.896536, 12>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.912926, 13><22, 8.749878, 14><23, 8.036590, 14>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.036590, 14><23, 8.504628, 13><22, 8.912926, 13>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.749878, 14><22, 8.481902, 15><23, 7.765684, 15>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.765684, 15><23, 8.036590, 14><22, 8.749878, 14>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.481902, 15><22, 8.689125, 16><23, 7.990067, 16>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.990067, 16><23, 7.765684, 15><22, 8.481902, 15>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.689125, 16><22, 8.474113, 17><23, 7.772126, 17>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.772126, 17><23, 7.990067, 16><22, 8.689125, 16>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.474113, 17><22, 8.593092, 18><23, 8.234801, 18>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.234801, 18><23, 7.772126, 17><22, 8.474113, 17>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.593092, 18><22, 8.691825, 19><23, 8.330605, 19>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.330605, 19><23, 8.234801, 18><22, 8.593092, 18>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.691825, 19><22, 8.413491, 20><23, 8.055896, 20>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.055896, 20><23, 8.330605, 19><22, 8.691825, 19>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.413491, 20><22, 8.533865, 21><23, 8.173340, 21>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.173340, 21><23, 8.055896, 20><22, 8.413491, 20>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.533865, 21><22, 8.299672, 22><23, 8.358242, 22>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.358242, 22><23, 8.173340, 21><22, 8.533865, 21>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.299672, 22><22, 8.826992, 23><23, 8.882631, 23>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.882631, 23><23, 8.358242, 22><22, 8.299672, 22>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.826992, 23><22, 8.167294, 24><23, 7.732503, 24>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.732503, 24><23, 8.882631, 23><22, 8.826992, 23>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.167294, 24><22, 8.233781, 25><23, 7.796061, 25>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.796061, 25><23, 7.732503, 24><22, 8.167294, 24>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.233781, 25><22, 8.065057, 26><23, 7.031923, 26>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.031923, 26><23, 7.796061, 25><22, 8.233781, 25>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.065057, 26><22, 7.512344, 27><23, 6.476280, 27>
  texture { T_Moon } 
  }
  triangle {
  <23, 6.476280, 27><23, 7.031923, 26><22, 8.065057, 26>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.512344, 27><22, 7.876364, 28><23, 7.895809, 28>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.895809, 28><23, 6.476280, 27><22, 7.512344, 27>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.876364, 28><22, 8.375829, 29><23, 8.392344, 29>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.392344, 29><23, 7.895809, 28><22, 7.876364, 28>
  texture { T_Moon } 
  }
  triangle {
  <22, 8.375829, 29><22, 7.741197, 30><23, 7.034421, 30>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.034421, 30><23, 8.392344, 29><22, 8.375829, 29>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.741197, 30><22, 7.526609, 31><23, 6.816904, 31>
  texture { T_Moon } 
  }
  triangle {
  <23, 6.816904, 31><23, 7.034421, 30><22, 7.741197, 30>
  texture { T_Moon } 
  }
  triangle {
  <22, 7.526609, 31><22, 7.618645, 32><23, 6.906010, 32>
  texture { T_Moon } 
  }
  triangle {
  <23, 6.906010, 32><23, 6.816904, 31><22, 7.526609, 31>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.153532, 0><23, 9.020932, 1><24, 8.562180, 1>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.562180, 1><24, 8.750000, 0><23, 9.153532, 0>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.020932, 1><23, 9.471455, 2><24, 8.639661, 2>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.639661, 2><24, 8.562180, 1><23, 9.020932, 1>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.471455, 2><23, 9.718799, 3><24, 8.621617, 3>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.621617, 3><24, 8.639661, 2><23, 9.471455, 2>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.718799, 3><23, 9.327988, 4><24, 8.468837, 4>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.468837, 4><24, 8.621617, 3><23, 9.718799, 3>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.327988, 4><23, 9.639241, 5><24, 8.189765, 5>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.189765, 5><24, 8.468837, 4><23, 9.327988, 4>
  texture { T_Moon } 
  }
  triangle {
  <23, 9.639241, 5><23, 8.422527, 6><24, 8.355447, 6>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.355447, 6><24, 8.189765, 5><23, 9.639241, 5>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.422527, 6><23, 7.968142, 7><24, 7.761467, 7>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.761467, 7><24, 8.355447, 6><23, 8.422527, 6>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.968142, 7><23, 8.487006, 8><24, 8.187500, 8>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.187500, 8><24, 7.761467, 7><23, 7.968142, 7>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.487006, 8><23, 8.226942, 9><24, 8.695779, 9>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.695779, 9><24, 8.187500, 8><23, 8.487006, 8>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.226942, 9><23, 8.682960, 10><24, 8.036304, 10>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.036304, 10><24, 8.695779, 9><23, 8.226942, 9>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.682960, 10><23, 8.728738, 11><24, 8.127133, 11>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.127133, 11><24, 8.036304, 10><23, 8.682960, 10>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.728738, 11><23, 8.491168, 12><24, 7.906293, 12>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.906293, 12><24, 8.127133, 11><23, 8.728738, 11>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.491168, 12><23, 8.504628, 13><24, 7.531924, 13>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.531924, 13><24, 7.906293, 12><23, 8.491168, 12>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.504628, 13><23, 8.036590, 14><24, 7.774352, 14>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.774352, 14><24, 7.531924, 13><23, 8.504628, 13>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.036590, 14><23, 7.765684, 15><24, 7.437039, 15>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.437039, 15><24, 7.774352, 14><23, 8.036590, 14>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.765684, 15><23, 7.990067, 16><24, 7.625000, 16>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.625000, 16><24, 7.437039, 15><23, 7.765684, 15>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.990067, 16><23, 7.772126, 17><24, 7.503071, 17>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.503071, 17><24, 7.625000, 16><23, 7.990067, 16>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.772126, 17><23, 8.234801, 18><24, 7.520094, 18>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.520094, 18><24, 7.503071, 17><23, 7.772126, 17>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.234801, 18><23, 8.330605, 19><24, 6.861595, 19>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.861595, 19><24, 7.520094, 18><23, 8.234801, 18>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.330605, 19><23, 8.055896, 20><24, 7.343839, 20>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.343839, 20><24, 6.861595, 19><23, 8.330605, 19>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.055896, 20><23, 8.173340, 21><24, 6.738136, 21>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.738136, 21><24, 7.343839, 20><23, 8.055896, 20>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.173340, 21><23, 8.358242, 22><24, 7.220276, 22>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.220276, 22><24, 6.738136, 21><23, 8.173340, 21>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.358242, 22><23, 8.882631, 23><24, 7.271674, 23>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.271674, 23><24, 7.220276, 22><23, 8.358242, 22>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.882631, 23><23, 7.732503, 24><24, 7.062500, 24>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.062500, 24><24, 7.271674, 23><23, 8.882631, 23>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.732503, 24><23, 7.796061, 25><24, 6.663324, 25>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.663324, 25><24, 7.062500, 24><23, 7.732503, 24>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.796061, 25><23, 7.031923, 26><24, 6.952236, 26>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.952236, 26><24, 6.663324, 25><23, 7.796061, 25>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.031923, 26><23, 6.476280, 27><24, 6.725123, 27>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.725123, 27><24, 6.952236, 26><23, 7.031923, 26>
  texture { T_Moon } 
  }
  triangle {
  <23, 6.476280, 27><23, 7.895809, 28><24, 6.781346, 28>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.781346, 28><24, 6.725123, 27><23, 6.476280, 27>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.895809, 28><23, 8.392344, 29><24, 7.051499, 29>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.051499, 29><24, 6.781346, 28><23, 7.895809, 28>
  texture { T_Moon } 
  }
  triangle {
  <23, 8.392344, 29><23, 7.034421, 30><24, 6.672588, 30>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.672588, 30><24, 7.051499, 29><23, 8.392344, 29>
  texture { T_Moon } 
  }
  triangle {
  <23, 7.034421, 30><23, 6.816904, 31><24, 6.966807, 31>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.966807, 31><24, 6.672588, 30><23, 7.034421, 30>
  texture { T_Moon } 
  }
  triangle {
  <23, 6.816904, 31><23, 6.906010, 32><24, 6.500000, 32>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.500000, 32><24, 6.966807, 31><23, 6.816904, 31>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.750000, 0><24, 8.562180, 1><25, 7.972991, 1>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.972991, 1><25, 8.163742, 0><24, 8.750000, 0>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.562180, 1><24, 8.639661, 2><25, 8.247562, 2>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.247562, 2><25, 7.972991, 1><24, 8.562180, 1>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.639661, 2><24, 8.621617, 3><25, 8.226589, 3>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.226589, 3><25, 8.247562, 2><24, 8.639661, 2>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.621617, 3><24, 8.468837, 4><25, 7.779652, 4>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.779652, 4><25, 8.226589, 3><24, 8.621617, 3>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.468837, 4><24, 8.189765, 5><25, 7.497651, 5>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.497651, 5><25, 7.779652, 4><24, 8.468837, 4>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.189765, 5><24, 8.355447, 6><25, 7.372773, 6>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.372773, 6><25, 7.497651, 5><24, 8.189765, 5>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.355447, 6><24, 7.761467, 7><25, 6.775864, 7>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.775864, 7><25, 7.372773, 6><24, 8.355447, 6>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.761467, 7><24, 8.187500, 8><25, 8.273903, 8>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.273903, 8><25, 6.775864, 7><24, 7.761467, 7>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.187500, 8><24, 8.695779, 9><25, 8.779252, 9>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.779252, 9><25, 8.273903, 8><24, 8.187500, 8>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.695779, 9><24, 8.036304, 10><25, 7.688806, 10>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.688806, 10><25, 8.779252, 9><24, 8.695779, 9>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.036304, 10><24, 8.127133, 11><25, 7.776706, 11>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.776706, 11><25, 7.688806, 10><24, 8.036304, 10>
  texture { T_Moon } 
  }
  triangle {
  <24, 8.127133, 11><24, 7.906293, 12><25, 7.098351, 12>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.098351, 12><25, 7.776706, 11><24, 8.127133, 11>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.906293, 12><24, 7.531924, 13><25, 6.721052, 13>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.721052, 13><25, 7.098351, 12><24, 7.906293, 12>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.531924, 13><24, 7.774352, 14><25, 7.006312, 14>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.006312, 14><25, 6.721052, 13><24, 7.531924, 13>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.774352, 14><24, 7.437039, 15><25, 6.666070, 15>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.666070, 15><25, 7.006312, 14><24, 7.774352, 14>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.437039, 15><24, 7.625000, 16><25, 7.057759, 16>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.057759, 16><25, 6.666070, 15><24, 7.437039, 15>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.625000, 16><24, 7.503071, 17><25, 6.932901, 17>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.932901, 17><25, 7.057759, 16><24, 7.625000, 16>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.503071, 17><24, 7.520094, 18><25, 6.446098, 18>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.446098, 18><25, 6.932901, 17><24, 7.503071, 17>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.520094, 18><24, 6.861595, 19><25, 5.784668, 19>
  texture { T_Moon } 
  }
  triangle {
  <25, 5.784668, 19><25, 6.446098, 18><24, 7.520094, 18>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.861595, 19><24, 7.343839, 20><25, 6.281149, 20>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.281149, 20><25, 5.784668, 19><24, 6.861595, 19>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.343839, 20><24, 6.738136, 21><25, 5.672517, 21>
  texture { T_Moon } 
  }
  triangle {
  <25, 5.672517, 21><25, 6.281149, 20><24, 7.343839, 20>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.738136, 21><24, 7.220276, 22><25, 6.825935, 22>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.825935, 22><25, 5.672517, 21><24, 6.738136, 21>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.220276, 22><24, 7.271674, 23><25, 6.874404, 23>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.874404, 23><25, 6.825935, 22><24, 7.220276, 22>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.271674, 23><24, 7.062500, 24><25, 6.194574, 24>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.194574, 24><25, 6.874404, 23><24, 7.271674, 23>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.062500, 24><24, 6.663324, 25><25, 5.792469, 25>
  texture { T_Moon } 
  }
  triangle {
  <25, 5.792469, 25><25, 6.194574, 24><24, 7.062500, 24>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.663324, 25><24, 6.952236, 26><25, 6.280827, 26>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.280827, 26><25, 5.792469, 25><24, 6.663324, 25>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.952236, 26><24, 6.725123, 27><25, 6.050785, 27>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.050785, 27><25, 6.280827, 26><24, 6.952236, 26>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.725123, 27><24, 6.781346, 28><25, 6.571079, 28>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.571079, 28><25, 6.050785, 27><24, 6.725123, 27>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.781346, 28><24, 7.051499, 29><25, 6.838302, 29>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.838302, 29><25, 6.571079, 28><24, 6.781346, 28>
  texture { T_Moon } 
  }
  triangle {
  <24, 7.051499, 29><24, 6.672588, 30><25, 6.512443, 30>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.512443, 30><25, 6.838302, 29><24, 7.051499, 29>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.672588, 30><24, 6.966807, 31><25, 6.803732, 31>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.803732, 31><25, 6.512443, 30><24, 6.672588, 30>
  texture { T_Moon } 
  }
  triangle {
  <24, 6.966807, 31><24, 6.500000, 32><25, 6.333995, 32>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.333995, 32><25, 6.803732, 31><24, 6.966807, 31>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.163742, 0><25, 7.972991, 1><26, 8.249615, 1>
  texture { T_Moon } 
  }
  triangle {
  <26, 8.249615, 1><26, 7.842785, 0><25, 8.163742, 0>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.972991, 1><25, 8.247562, 2><26, 7.720727, 2>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.720727, 2><26, 8.249615, 1><25, 7.972991, 1>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.247562, 2><25, 8.226589, 3><26, 7.388037, 3>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.388037, 3><26, 7.720727, 2><25, 8.247562, 2>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.226589, 3><25, 7.779652, 4><26, 7.535220, 4>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.535220, 4><26, 7.388037, 3><25, 8.226589, 3>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.779652, 4><25, 7.497651, 5><26, 7.267412, 5>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.267412, 5><26, 7.535220, 4><25, 7.779652, 4>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.497651, 5><25, 7.372773, 6><26, 7.410111, 6>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.410111, 6><26, 7.267412, 5><25, 7.497651, 5>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.372773, 6><25, 6.775864, 7><26, 7.254514, 7>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.254514, 7><26, 7.410111, 6><25, 7.372773, 6>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.775864, 7><25, 8.273903, 8><26, 7.192553, 8>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.192553, 8><26, 7.254514, 7><25, 6.775864, 7>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.273903, 8><25, 8.779252, 9><26, 6.890791, 9>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.890791, 9><26, 7.192553, 8><25, 8.273903, 8>
  texture { T_Moon } 
  }
  triangle {
  <25, 8.779252, 9><25, 7.688806, 10><26, 7.029637, 10>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.029637, 10><26, 6.890791, 9><25, 8.779252, 9>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.688806, 10><25, 7.776706, 11><26, 7.097774, 11>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.097774, 11><26, 7.029637, 10><25, 7.688806, 10>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.776706, 11><25, 7.098351, 12><26, 6.907207, 12>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.907207, 12><26, 7.097774, 11><25, 7.776706, 11>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.098351, 12><25, 6.721052, 13><26, 7.001400, 13>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.001400, 13><26, 6.907207, 12><25, 7.098351, 12>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.721052, 13><25, 7.006312, 14><26, 6.763546, 14>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.763546, 14><26, 7.001400, 13><25, 6.721052, 13>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.006312, 14><25, 6.666070, 15><26, 6.113971, 15>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.113971, 15><26, 6.763546, 14><25, 7.006312, 14>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.666070, 15><25, 7.057759, 16><26, 6.629469, 16>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.629469, 16><26, 6.113971, 15><25, 6.666070, 15>
  texture { T_Moon } 
  }
  triangle {
  <25, 7.057759, 16><25, 6.932901, 17><26, 6.650696, 17>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.650696, 17><26, 6.629469, 16><25, 7.057759, 16>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.932901, 17><25, 6.446098, 18><26, 6.512845, 18>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.512845, 18><26, 6.650696, 17><25, 6.932901, 17>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.446098, 18><25, 5.784668, 19><26, 6.687585, 19>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.687585, 19><26, 6.512845, 18><25, 6.446098, 18>
  texture { T_Moon } 
  }
  triangle {
  <25, 5.784668, 19><25, 6.281149, 20><26, 6.306303, 20>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.306303, 20><26, 6.687585, 19><25, 5.784668, 19>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.281149, 20><25, 5.672517, 21><26, 5.738887, 21>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.738887, 21><26, 6.306303, 20><25, 6.281149, 20>
  texture { T_Moon } 
  }
  triangle {
  <25, 5.672517, 21><25, 6.825935, 22><26, 6.171021, 22>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.171021, 22><26, 5.738887, 21><25, 5.672517, 21>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.825935, 22><25, 6.874404, 23><26, 6.145731, 23>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.145731, 23><26, 6.171021, 22><25, 6.825935, 22>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.874404, 23><25, 6.194574, 24><26, 6.014736, 24>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.014736, 24><26, 6.145731, 23><25, 6.874404, 23>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.194574, 24><25, 5.792469, 25><26, 6.220920, 25>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.220920, 25><26, 6.014736, 24><25, 6.194574, 24>
  texture { T_Moon } 
  }
  triangle {
  <25, 5.792469, 25><25, 6.280827, 26><26, 5.892753, 26>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.892753, 26><26, 6.220920, 25><25, 5.792469, 25>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.280827, 26><25, 6.050785, 27><26, 5.922948, 27>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.922948, 27><26, 5.892753, 26><25, 6.280827, 26>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.050785, 27><25, 6.571079, 28><26, 5.711747, 28>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.711747, 28><26, 5.922948, 27><25, 6.050785, 27>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.571079, 28><25, 6.838302, 29><26, 5.965440, 29>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.965440, 29><26, 5.711747, 28><25, 6.571079, 28>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.838302, 29><25, 6.512443, 30><26, 5.591270, 30>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.591270, 30><26, 5.965440, 29><25, 6.838302, 29>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.512443, 30><25, 6.803732, 31><26, 5.698913, 31>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.698913, 31><26, 5.591270, 30><25, 6.512443, 30>
  texture { T_Moon } 
  }
  triangle {
  <25, 6.803732, 31><25, 6.333995, 32><26, 5.406963, 32>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.406963, 32><26, 5.698913, 31><25, 6.803732, 31>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.842785, 0><26, 8.249615, 1><27, 8.230693, 1>
  texture { T_Moon } 
  }
  triangle {
  <27, 8.230693, 1><27, 7.826794, 0><26, 7.842785, 0>
  texture { T_Moon } 
  }
  triangle {
  <26, 8.249615, 1><26, 7.720727, 2><27, 6.989599, 2>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.989599, 2><27, 8.230693, 1><26, 8.249615, 1>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.720727, 2><26, 7.388037, 3><27, 6.653979, 3>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.653979, 3><27, 6.989599, 2><26, 7.720727, 2>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.388037, 3><26, 7.535220, 4><27, 6.835881, 4>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.835881, 4><27, 6.653979, 3><26, 7.388037, 3>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.535220, 4><26, 7.267412, 5><27, 6.565143, 5>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.565143, 5><27, 6.835881, 4><26, 7.535220, 4>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.267412, 5><26, 7.410111, 6><27, 6.844402, 6>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.844402, 6><27, 6.565143, 5><26, 7.267412, 5>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.410111, 6><26, 7.254514, 7><27, 6.685875, 7>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.685875, 7><27, 6.844402, 6><26, 7.410111, 6>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.254514, 7><26, 7.192553, 8><27, 6.485369, 8>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.485369, 8><27, 6.685875, 7><26, 7.254514, 7>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.192553, 8><26, 6.890791, 9><27, 6.180677, 9>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.180677, 9><27, 6.485369, 8><26, 7.192553, 8>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.890791, 9><26, 7.029637, 10><27, 6.675899, 10>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.675899, 10><27, 6.180677, 9><26, 6.890791, 9>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.029637, 10><26, 7.097774, 11><27, 6.741106, 11>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.741106, 11><27, 6.675899, 10><26, 7.029637, 10>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.097774, 11><26, 6.907207, 12><27, 6.564982, 12>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.564982, 12><27, 6.741106, 11><26, 7.097774, 11>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.907207, 12><26, 7.001400, 13><27, 6.656245, 13>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.656245, 13><27, 6.564982, 12><26, 6.907207, 12>
  texture { T_Moon } 
  }
  triangle {
  <26, 7.001400, 13><26, 6.763546, 14><27, 5.680398, 14>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.680398, 14><27, 6.656245, 13><26, 7.001400, 13>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.763546, 14><26, 6.113971, 15><27, 5.027892, 15>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.027892, 15><27, 5.680398, 14><26, 6.763546, 14>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.113971, 15><26, 6.629469, 16><27, 6.175568, 16>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.175568, 16><27, 5.027892, 15><26, 6.113971, 15>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.629469, 16><26, 6.650696, 17><27, 6.193864, 17>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.193864, 17><27, 6.175568, 16><26, 6.629469, 16>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.650696, 17><26, 6.512845, 18><27, 6.242272, 18>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.242272, 18><27, 6.193864, 17><26, 6.650696, 17>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.512845, 18><26, 6.687585, 19><27, 6.414083, 19>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.414083, 19><27, 6.242272, 18><26, 6.512845, 18>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.687585, 19><26, 6.306303, 20><27, 5.270653, 20>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.270653, 20><27, 6.414083, 19><26, 6.687585, 19>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.306303, 20><26, 5.738887, 21><27, 4.700307, 21>
  texture { T_Moon } 
  }
  triangle {
  <27, 4.700307, 21><27, 5.270653, 20><26, 6.306303, 20>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.738887, 21><26, 6.171021, 22><27, 5.688744, 22>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.688744, 22><27, 4.700307, 21><26, 5.738887, 21>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.171021, 22><26, 6.145731, 23><27, 5.660523, 23>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.660523, 23><27, 5.688744, 22><26, 6.171021, 22>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.145731, 23><26, 6.014736, 24><27, 5.727716, 24>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.727716, 24><27, 5.660523, 23><26, 6.145731, 23>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.014736, 24><26, 6.220920, 25><27, 5.930971, 25>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.930971, 25><27, 5.727716, 24><26, 6.014736, 24>
  texture { T_Moon } 
  }
  triangle {
  <26, 6.220920, 25><26, 5.892753, 26><27, 5.454198, 26>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.454198, 26><27, 5.930971, 25><26, 6.220920, 25>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.892753, 26><26, 5.922948, 27><27, 5.481464, 27>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.481464, 27><27, 5.454198, 26><26, 5.892753, 26>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.922948, 27><26, 5.711747, 28><27, 5.458963, 28>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.458963, 28><27, 5.481464, 27><26, 5.922948, 27>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.711747, 28><26, 5.965440, 29><27, 5.709726, 29>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.709726, 29><27, 5.458963, 28><26, 5.711747, 28>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.965440, 29><26, 5.591270, 30><27, 5.218493, 30>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.218493, 30><27, 5.709726, 29><26, 5.965440, 29>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.591270, 30><26, 5.698913, 31><27, 5.323205, 31>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.323205, 31><27, 5.218493, 30><26, 5.591270, 30>
  texture { T_Moon } 
  }
  triangle {
  <26, 5.698913, 31><26, 5.406963, 32><27, 5.028326, 32>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.028326, 32><27, 5.323205, 31><26, 5.698913, 31>
  texture { T_Moon } 
  }
  triangle {
  <27, 7.826794, 0><27, 8.230693, 1><28, 7.403431, 1>
  texture { T_Moon } 
  }
  triangle {
  <28, 7.403431, 1><28, 6.875087, 0><27, 7.826794, 0>
  texture { T_Moon } 
  }
  triangle {
  <27, 8.230693, 1><27, 6.989599, 2><28, 6.733742, 2>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.733742, 2><28, 7.403431, 1><27, 8.230693, 1>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.989599, 2><27, 6.653979, 3><28, 6.960743, 3>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.960743, 3><28, 6.733742, 2><27, 6.989599, 2>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.653979, 3><27, 6.835881, 4><28, 6.547049, 4>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.547049, 4><28, 6.960743, 3><27, 6.653979, 3>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.835881, 4><27, 6.565143, 5><28, 6.535275, 5>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.535275, 5><28, 6.547049, 4><27, 6.835881, 4>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.565143, 5><27, 6.844402, 6><28, 6.372550, 6>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.372550, 6><28, 6.535275, 5><27, 6.565143, 5>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.844402, 6><27, 6.685875, 7><28, 6.321180, 7>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.321180, 7><28, 6.372550, 6><27, 6.844402, 6>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.685875, 7><27, 6.485369, 8><28, 6.218793, 8>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.218793, 8><28, 6.321180, 7><27, 6.685875, 7>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.485369, 8><27, 6.180677, 9><28, 5.817170, 9>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.817170, 9><28, 6.218793, 8><27, 6.485369, 8>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.180677, 9><27, 6.675899, 10><28, 6.036557, 10>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.036557, 10><28, 5.817170, 9><27, 6.180677, 9>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.675899, 10><27, 6.741106, 11><28, 6.092907, 11>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.092907, 11><28, 6.036557, 10><27, 6.675899, 10>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.741106, 11><27, 6.564982, 12><28, 5.890712, 12>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.890712, 12><28, 6.092907, 11><27, 6.741106, 11>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.564982, 12><27, 6.656245, 13><28, 6.295903, 13>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.295903, 13><28, 5.890712, 12><27, 6.564982, 12>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.656245, 13><27, 5.680398, 14><28, 5.696402, 14>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.696402, 14><28, 6.295903, 13><27, 6.656245, 13>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.680398, 14><27, 5.027892, 15><28, 6.146725, 15>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.146725, 15><28, 5.696402, 14><27, 5.680398, 14>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.027892, 15><27, 6.175568, 16><28, 5.562589, 16>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.562589, 16><28, 6.146725, 15><27, 5.027892, 15>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.175568, 16><27, 6.193864, 17><28, 5.308183, 17>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.308183, 17><28, 5.562589, 16><27, 6.175568, 16>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.193864, 17><27, 6.242272, 18><28, 5.382682, 18>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.382682, 18><28, 5.308183, 17><27, 6.193864, 17>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.242272, 18><27, 6.414083, 19><28, 5.700007, 19>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.700007, 19><28, 5.382682, 18><27, 6.242272, 18>
  texture { T_Moon } 
  }
  triangle {
  <27, 6.414083, 19><27, 5.270653, 20><28, 5.234552, 20>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.234552, 20><28, 5.700007, 19><27, 6.414083, 19>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.270653, 20><27, 4.700307, 21><28, 5.305463, 21>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.305463, 21><28, 5.234552, 20><27, 5.270653, 20>
  texture { T_Moon } 
  }
  triangle {
  <27, 4.700307, 21><27, 5.688744, 22><28, 5.041586, 22>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.041586, 22><28, 5.305463, 21><27, 4.700307, 21>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.688744, 22><27, 5.660523, 23><28, 4.811825, 23>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.811825, 23><28, 5.041586, 22><27, 5.688744, 22>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.660523, 23><27, 5.727716, 24><28, 4.906346, 24>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.906346, 24><28, 4.811825, 23><27, 5.660523, 23>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.727716, 24><27, 5.930971, 25><28, 4.393819, 25>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.393819, 25><28, 4.906346, 24><27, 5.727716, 24>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.930971, 25><27, 5.454198, 26><28, 4.775004, 26>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.775004, 26><28, 4.393819, 25><27, 5.930971, 25>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.454198, 26><27, 5.481464, 27><28, 4.052972, 27>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.052972, 27><28, 4.775004, 26><27, 5.454198, 26>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.481464, 27><27, 5.458963, 28><28, 4.578318, 28>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.578318, 28><28, 4.052972, 27><27, 5.481464, 27>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.458963, 28><27, 5.709726, 29><28, 4.132149, 29>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.132149, 29><28, 4.578318, 28><27, 5.458963, 28>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.709726, 29><27, 5.218493, 30><28, 4.439985, 30>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.439985, 30><28, 4.132149, 29><27, 5.709726, 29>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.218493, 30><27, 5.323205, 31><28, 4.554750, 31>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.554750, 31><28, 4.439985, 30><27, 5.218493, 30>
  texture { T_Moon } 
  }
  triangle {
  <27, 5.323205, 31><27, 5.028326, 32><28, 4.250096, 32>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.250096, 32><28, 4.554750, 31><27, 5.323205, 31>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.875087, 0><28, 7.403431, 1><29, 7.542083, 1>
  texture { T_Moon } 
  }
  triangle {
  <29, 7.542083, 1><29, 7.016668, 0><28, 6.875087, 0>
  texture { T_Moon } 
  }
  triangle {
  <28, 7.403431, 1><28, 6.733742, 2><29, 6.590796, 2>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.590796, 2><29, 7.542083, 1><28, 7.403431, 1>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.733742, 2><28, 6.960743, 3><29, 6.814868, 3>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.814868, 3><29, 6.590796, 2><28, 6.733742, 2>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.960743, 3><28, 6.547049, 4><29, 6.136838, 4>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.136838, 4><29, 6.814868, 3><28, 6.960743, 3>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.547049, 4><28, 6.535275, 5><29, 6.122136, 5>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.122136, 5><29, 6.136838, 4><28, 6.547049, 4>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.535275, 5><28, 6.372550, 6><29, 5.906490, 6>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.906490, 6><29, 6.122136, 5><28, 6.535275, 5>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.372550, 6><28, 6.321180, 7><29, 5.852191, 7>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.852191, 7><29, 5.906490, 6><28, 6.372550, 6>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.321180, 7><28, 6.218793, 8><29, 5.406992, 8>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.406992, 8><29, 5.852191, 7><28, 6.321180, 7>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.218793, 8><28, 5.817170, 9><29, 5.002438, 9>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.002438, 9><29, 5.406992, 8><28, 6.218793, 8>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.817170, 9><28, 6.036557, 10><29, 5.658674, 10>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.658674, 10><29, 5.002438, 9><28, 5.817170, 9>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.036557, 10><28, 6.092907, 11><29, 5.712094, 11>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.712094, 11><29, 5.658674, 10><28, 6.036557, 10>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.092907, 11><28, 5.890712, 12><29, 5.874028, 12>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.874028, 12><29, 5.712094, 11><28, 6.092907, 11>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.890712, 12><28, 6.295903, 13><29, 6.276290, 13>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.276290, 13><29, 5.874028, 12><28, 5.890712, 12>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.295903, 13><28, 5.696402, 14><29, 5.688765, 14>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.688765, 14><29, 6.276290, 13><28, 6.295903, 13>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.696402, 14><28, 6.146725, 15><29, 6.136158, 15>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.136158, 15><29, 5.688765, 14><28, 5.696402, 14>
  texture { T_Moon } 
  }
  triangle {
  <28, 6.146725, 15><28, 5.562589, 16><29, 4.874546, 16>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.874546, 16><29, 6.136158, 15><28, 6.146725, 15>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.562589, 16><28, 5.308183, 17><29, 4.617210, 17>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.617210, 17><29, 4.874546, 16><28, 5.562589, 16>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.308183, 17><28, 5.382682, 18><29, 5.244621, 18>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.244621, 18><29, 4.617210, 17><28, 5.308183, 17>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.382682, 18><28, 5.700007, 19><29, 5.559017, 19>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.559017, 19><29, 5.244621, 18><28, 5.382682, 18>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.700007, 19><28, 5.234552, 20><29, 4.860151, 20>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.860151, 20><29, 5.559017, 19><28, 5.700007, 19>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.234552, 20><28, 5.305463, 21><29, 4.928132, 21>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.928132, 21><29, 4.860151, 20><28, 5.234552, 20>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.305463, 21><28, 5.041586, 22><29, 4.331794, 22>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.331794, 22><29, 4.928132, 21><28, 5.305463, 21>
  texture { T_Moon } 
  }
  triangle {
  <28, 5.041586, 22><28, 4.811825, 23><29, 4.099103, 23>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.099103, 23><29, 4.331794, 22><28, 5.041586, 22>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.811825, 23><28, 4.906346, 24><29, 3.936740, 24>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.936740, 24><29, 4.099103, 23><28, 4.811825, 23>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.906346, 24><28, 4.393819, 25><29, 3.421283, 25>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.421283, 25><29, 3.936740, 24><28, 4.906346, 24>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.393819, 25><28, 4.775004, 26><29, 3.622706, 26>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.622706, 26><29, 3.421283, 25><28, 4.393819, 25>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.775004, 26><28, 4.052972, 27><29, 2.897744, 27>
  texture { T_Moon } 
  }
  triangle {
  <29, 2.897744, 27><29, 3.622706, 26><28, 4.775004, 26>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.052972, 27><28, 4.578318, 28><29, 3.663399, 28>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.663399, 28><29, 2.897744, 27><28, 4.052972, 27>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.578318, 28><28, 4.132149, 29><29, 3.214301, 29>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.214301, 29><29, 3.663399, 28><28, 4.578318, 28>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.132149, 29><28, 4.439985, 30><29, 4.105919, 30>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.105919, 30><29, 3.214301, 29><28, 4.132149, 29>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.439985, 30><28, 4.554750, 31><29, 4.217755, 31>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.217755, 31><29, 4.105919, 30><28, 4.439985, 30>
  texture { T_Moon } 
  }
  triangle {
  <28, 4.554750, 31><28, 4.250096, 32><29, 3.910171, 32>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.910171, 32><29, 4.217755, 31><28, 4.554750, 31>
  texture { T_Moon } 
  }
  triangle {
  <29, 7.016668, 0><29, 7.542083, 1><30, 6.069775, 1>
  texture { T_Moon } 
  }
  triangle {
  <30, 6.069775, 1><30, 5.960217, 0><29, 7.016668, 0>
  texture { T_Moon } 
  }
  triangle {
  <29, 7.542083, 1><29, 6.590796, 2><30, 5.807154, 2>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.807154, 2><30, 6.069775, 1><29, 7.542083, 1>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.590796, 2><29, 6.814868, 3><30, 5.571169, 3>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.571169, 3><30, 5.807154, 2><29, 6.590796, 2>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.814868, 3><29, 6.136838, 4><30, 5.575675, 4>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.575675, 4><30, 5.571169, 3><29, 6.814868, 3>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.136838, 4><29, 6.122136, 5><30, 5.833093, 5>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.833093, 5><30, 5.575675, 4><29, 6.136838, 4>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.122136, 5><29, 5.906490, 6><30, 5.389457, 6>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.389457, 6><30, 5.833093, 5><29, 6.122136, 5>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.906490, 6><29, 5.852191, 7><30, 5.504516, 7>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.504516, 7><30, 5.389457, 6><29, 5.906490, 6>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.852191, 7><29, 5.406992, 8><30, 5.216201, 8>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.216201, 8><30, 5.504516, 7><29, 5.852191, 7>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.406992, 8><29, 5.002438, 9><30, 5.516823, 9>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.516823, 9><30, 5.216201, 8><29, 5.406992, 8>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.002438, 9><29, 5.658674, 10><30, 5.022246, 10>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.022246, 10><30, 5.516823, 9><29, 5.002438, 9>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.658674, 10><29, 5.712094, 11><30, 4.327063, 11>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.327063, 11><30, 5.022246, 10><29, 5.658674, 10>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.712094, 11><29, 5.874028, 12><30, 4.852653, 12>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.852653, 12><30, 4.327063, 11><29, 5.712094, 11>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.874028, 12><29, 6.276290, 13><30, 4.179203, 13>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.179203, 13><30, 4.852653, 12><29, 5.874028, 12>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.276290, 13><29, 5.688765, 14><30, 4.646624, 14>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.646624, 14><30, 4.179203, 13><29, 6.276290, 13>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.688765, 14><29, 6.136158, 15><30, 4.663785, 15>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.663785, 15><30, 4.646624, 14><29, 5.688765, 14>
  texture { T_Moon } 
  }
  triangle {
  <29, 6.136158, 15><29, 4.874546, 16><30, 4.515406, 16>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.515406, 16><30, 4.663785, 15><29, 6.136158, 15>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.874546, 16><29, 4.617210, 17><30, 3.944759, 17>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.944759, 17><30, 4.515406, 16><29, 4.874546, 16>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.617210, 17><29, 5.244621, 18><30, 4.323781, 18>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.323781, 18><30, 3.944759, 17><29, 4.617210, 17>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.244621, 18><29, 5.559017, 19><30, 4.675756, 19>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.675756, 19><30, 4.323781, 18><29, 5.244621, 18>
  texture { T_Moon } 
  }
  triangle {
  <29, 5.559017, 19><29, 4.860151, 20><30, 4.150961, 20>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.150961, 20><30, 4.675756, 19><29, 5.559017, 19>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.860151, 20><29, 4.928132, 21><30, 4.618614, 21>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.618614, 21><30, 4.150961, 20><29, 4.860151, 20>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.928132, 21><29, 4.331794, 22><30, 3.946276, 22>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.946276, 22><30, 4.618614, 21><29, 4.928132, 21>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.331794, 22><29, 4.099103, 23><30, 4.398762, 23>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.398762, 23><30, 3.946276, 22><29, 4.331794, 22>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.099103, 23><29, 3.936740, 24><30, 3.860845, 24>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.860845, 24><30, 4.398762, 23><29, 4.099103, 23>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.936740, 24><29, 3.421283, 25><30, 3.919557, 25>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.919557, 25><30, 3.860845, 24><29, 3.936740, 24>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.421283, 25><29, 3.622706, 26><30, 3.717784, 26>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.717784, 26><30, 3.919557, 25><29, 3.421283, 25>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.622706, 26><29, 2.897744, 27><30, 3.570896, 27>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.570896, 27><30, 3.717784, 26><29, 3.622706, 26>
  texture { T_Moon } 
  }
  triangle {
  <29, 2.897744, 27><29, 3.663399, 28><30, 3.502486, 28>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.502486, 28><30, 3.570896, 27><29, 2.897744, 27>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.663399, 28><29, 3.214301, 29><30, 2.820326, 29>
  texture { T_Moon } 
  }
  triangle {
  <30, 2.820326, 29><30, 3.502486, 28><29, 3.663399, 28>
  texture { T_Moon } 
  }
  triangle {
  <29, 3.214301, 29><29, 4.105919, 30><30, 3.352434, 30>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.352434, 30><30, 2.820326, 29><29, 3.214301, 29>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.105919, 30><29, 4.217755, 31><30, 2.721891, 31>
  texture { T_Moon } 
  }
  triangle {
  <30, 2.721891, 31><30, 3.352434, 30><29, 4.105919, 30>
  texture { T_Moon } 
  }
  triangle {
  <29, 4.217755, 31><29, 3.910171, 32><30, 3.150827, 32>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.150827, 32><30, 2.721891, 31><29, 4.217755, 31>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.960217, 0><30, 6.069775, 1><31, 5.772826, 1>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.772826, 1><31, 5.666198, 0><30, 5.960217, 0>
  texture { T_Moon } 
  }
  triangle {
  <30, 6.069775, 1><30, 5.807154, 2><31, 5.184407, 2>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.184407, 2><31, 5.772826, 1><30, 6.069775, 1>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.807154, 2><30, 5.571169, 3><31, 4.945492, 3>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.945492, 3><31, 5.184407, 2><30, 5.807154, 2>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.571169, 3><30, 5.575675, 4><31, 5.450908, 4>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.450908, 4><31, 4.945492, 3><30, 5.571169, 3>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.575675, 4><30, 5.833093, 5><31, 5.705397, 5>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.705397, 5><31, 5.450908, 4><30, 5.575675, 4>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.833093, 5><30, 5.389457, 6><31, 5.106078, 6>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.106078, 6><31, 5.705397, 5><30, 5.833093, 5>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.389457, 6><30, 5.504516, 7><31, 5.218208, 7>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.218208, 7><31, 5.106078, 6><30, 5.389457, 6>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.504516, 7><30, 5.216201, 8><31, 5.130700, 8>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.130700, 8><31, 5.218208, 7><30, 5.504516, 7>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.216201, 8><30, 5.516823, 9><31, 5.428392, 9>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.428392, 9><31, 5.130700, 8><30, 5.216201, 8>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.516823, 9><30, 5.022246, 10><31, 3.916885, 10>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.916885, 10><31, 5.428392, 9><30, 5.516823, 9>
  texture { T_Moon } 
  }
  triangle {
  <30, 5.022246, 10><30, 4.327063, 11><31, 3.218772, 11>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.218772, 11><31, 3.916885, 10><30, 5.022246, 10>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.327063, 11><30, 4.852653, 12><31, 3.793412, 12>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.793412, 12><31, 3.218772, 11><30, 4.327063, 11>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.852653, 12><30, 4.179203, 13><31, 3.117032, 13>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.117032, 13><31, 3.793412, 12><30, 4.852653, 12>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.179203, 13><30, 4.646624, 14><31, 4.241910, 14>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.241910, 14><31, 3.117032, 13><30, 4.179203, 13>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.646624, 14><30, 4.663785, 15><31, 4.256141, 15>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.256141, 15><31, 4.241910, 14><30, 4.646624, 14>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.663785, 15><30, 4.515406, 16><31, 3.532868, 16>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.532868, 16><31, 4.256141, 15><30, 4.663785, 15>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.515406, 16><30, 3.944759, 17><31, 2.959292, 17>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.959292, 17><31, 3.532868, 16><30, 4.515406, 16>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.944759, 17><30, 4.323781, 18><31, 4.242118, 18>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.242118, 18><31, 2.959292, 17><30, 3.944759, 17>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.323781, 18><30, 4.675756, 19><31, 4.591163, 19>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.591163, 19><31, 4.242118, 18><30, 4.323781, 18>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.675756, 19><30, 4.150961, 20><31, 4.208020, 20>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.208020, 20><31, 4.591163, 19><30, 4.675756, 19>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.150961, 20><30, 4.618614, 21><31, 4.672743, 21>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.672743, 21><31, 4.208020, 20><30, 4.150961, 20>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.618614, 21><30, 3.946276, 22><31, 3.953450, 22>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.953450, 22><31, 4.672743, 21><30, 4.618614, 21>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.946276, 22><30, 4.398762, 23><31, 4.403007, 23>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.403007, 23><31, 3.953450, 22><30, 3.946276, 22>
  texture { T_Moon } 
  }
  triangle {
  <30, 4.398762, 23><30, 3.860845, 24><31, 3.435665, 24>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.435665, 24><31, 4.403007, 23><30, 4.398762, 23>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.860845, 24><30, 3.919557, 25><31, 3.491447, 25>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.491447, 25><31, 3.435665, 24><30, 3.860845, 24>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.919557, 25><30, 3.717784, 26><31, 3.113817, 26>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.113817, 26><31, 3.491447, 25><30, 3.919557, 25>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.717784, 26><30, 3.570896, 27><31, 2.964000, 27>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.964000, 27><31, 3.113817, 26><30, 3.717784, 26>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.570896, 27><30, 3.502486, 28><31, 2.331656, 28>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.331656, 28><31, 2.964000, 27><30, 3.570896, 27>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.502486, 28><30, 2.820326, 29><31, 1.646567, 29>
  texture { T_Moon } 
  }
  triangle {
  <31, 1.646567, 29><31, 2.331656, 28><30, 3.502486, 28>
  texture { T_Moon } 
  }
  triangle {
  <30, 2.820326, 29><30, 3.352434, 30><31, 2.253141, 30>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.253141, 30><31, 1.646567, 29><30, 2.820326, 29>
  texture { T_Moon } 
  }
  triangle {
  <30, 3.352434, 30><30, 2.721891, 31><31, 1.619668, 31>
  texture { T_Moon } 
  }
  triangle {
  <31, 1.619668, 31><31, 2.253141, 30><30, 3.352434, 30>
  texture { T_Moon } 
  }
  triangle {
  <30, 2.721891, 31><30, 3.150827, 32><31, 2.045674, 32>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.045674, 32><31, 1.619668, 31><30, 2.721891, 31>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.666198, 0><31, 5.772826, 1><32, 5.103698, 1>
  texture { T_Moon } 
  }
  triangle {
  <32, 5.103698, 1><32, 5.000000, 0><31, 5.666198, 0>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.772826, 1><31, 5.184407, 2><32, 4.835217, 2>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.835217, 2><32, 5.103698, 1><31, 5.772826, 1>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.184407, 2><31, 4.945492, 3><32, 4.593373, 3>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.593373, 3><32, 4.835217, 2><31, 5.184407, 2>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.945492, 3><31, 5.450908, 4><32, 4.625087, 4>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.625087, 4><32, 4.593373, 3><31, 4.945492, 3>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.450908, 4><31, 5.705397, 5><32, 4.876646, 5>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.876646, 5><32, 4.625087, 4><31, 5.450908, 4>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.705397, 5><31, 5.106078, 6><32, 4.427150, 6>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.427150, 6><32, 4.876646, 5><31, 5.705397, 5>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.106078, 6><31, 5.218208, 7><32, 4.536350, 7>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.536350, 7><32, 4.427150, 6><31, 5.106078, 6>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.218208, 7><31, 5.130700, 8><32, 4.250000, 8>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.250000, 8><32, 4.536350, 7><31, 5.218208, 7>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.130700, 8><31, 5.428392, 9><32, 4.544763, 9>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.544763, 9><32, 4.250000, 8><31, 5.130700, 8>
  texture { T_Moon } 
  }
  triangle {
  <31, 5.428392, 9><31, 3.916885, 10><32, 4.044326, 10>
  texture { T_Moon } 
  }
  triangle {
  <32, 4.044326, 10><32, 4.544763, 9><31, 5.428392, 9>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.916885, 10><31, 3.218772, 11><32, 3.343284, 11>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.343284, 11><32, 4.044326, 10><31, 3.916885, 10>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.218772, 11><31, 3.793412, 12><32, 3.875044, 12>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.875044, 12><32, 3.343284, 11><31, 3.218772, 11>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.793412, 12><31, 3.117032, 13><32, 3.195734, 13>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.195734, 13><32, 3.875044, 12><31, 3.793412, 12>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.117032, 13><31, 4.241910, 14><32, 3.657297, 14>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.657297, 14><32, 3.195734, 13><31, 3.117032, 13>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.241910, 14><31, 4.256141, 15><32, 3.668598, 15>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.668598, 15><32, 3.657297, 14><31, 4.241910, 14>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.256141, 15><31, 3.532868, 16><32, 3.500000, 16>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.500000, 16><32, 3.668598, 15><31, 4.256141, 15>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.532868, 16><31, 2.959292, 17><32, 2.923493, 17>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.923493, 17><32, 3.500000, 16><31, 3.532868, 16>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.959292, 17><31, 4.242118, 18><32, 3.296656, 18>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.296656, 18><32, 2.923493, 17><31, 2.959292, 17>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.242118, 18><31, 4.591163, 19><32, 3.642772, 19>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.642772, 19><32, 3.296656, 18><31, 4.242118, 18>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.591163, 19><31, 4.208020, 20><32, 3.125089, 20>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.125089, 20><32, 3.642772, 19><31, 4.591163, 19>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.208020, 20><31, 4.672743, 21><32, 3.586882, 21>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.586882, 21><32, 3.125089, 20><31, 4.208020, 20>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.672743, 21><31, 3.953450, 22><32, 2.908685, 22>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.908685, 22><32, 3.586882, 21><31, 4.672743, 21>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.953450, 22><31, 4.403007, 23><32, 3.355312, 23>
  texture { T_Moon } 
  }
  triangle {
  <32, 3.355312, 23><32, 2.908685, 22><31, 3.953450, 22>
  texture { T_Moon } 
  }
  triangle {
  <31, 4.403007, 23><31, 3.435665, 24><32, 2.750000, 24>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.750000, 24><32, 3.355312, 23><31, 4.403007, 23>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.435665, 24><31, 3.491447, 25><32, 2.802852, 25>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.802852, 25><32, 2.750000, 24><31, 3.435665, 24>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.491447, 25><31, 3.113817, 26><32, 2.595220, 26>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.595220, 26><32, 2.802852, 25><31, 3.491447, 25>
  texture { T_Moon } 
  }
  triangle {
  <31, 3.113817, 26><31, 2.964000, 27><32, 2.442473, 27>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.442473, 27><32, 2.595220, 26><31, 3.113817, 26>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.964000, 27><31, 2.331656, 28><32, 2.375096, 28>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.375096, 28><32, 2.442473, 27><31, 2.964000, 27>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.331656, 28><31, 1.646567, 29><32, 1.687077, 29>
  texture { T_Moon } 
  }
  triangle {
  <32, 1.687077, 29><32, 2.375096, 28><31, 2.331656, 28>
  texture { T_Moon } 
  }
  triangle {
  <31, 1.646567, 29><31, 2.253141, 30><32, 2.213327, 30>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.213327, 30><32, 1.687077, 29><31, 1.646567, 29>
  texture { T_Moon } 
  }
  triangle {
  <31, 2.253141, 30><31, 1.619668, 31><32, 1.576924, 31>
  texture { T_Moon } 
  }
  triangle {
  <32, 1.576924, 31><32, 2.213327, 30><31, 2.253141, 30>
  texture { T_Moon } 
  }
  triangle {
  <31, 1.619668, 31><31, 2.045674, 32><32, 2.000000, 32>
  texture { T_Moon } 
  }
  triangle {
  <32, 2.000000, 32><32, 1.576924, 31><31, 1.619668, 31>
  texture { T_Moon } 
  }

  //FRONT 
}

object {
    MOON_TERRAIN 
    translate <-20, 20, -14>
    scale <0.5,0.5,1.2>
    rotate <-10,0,0>
}

#declare T_Julia =
pigment{ julia <0.360, 0.150>, 30
         scale 2.5 translate<-3.0,1.0,1.5>
         color_map{
                   [0.05 color rgb <201/255,144/255 ,57/255>]
                   [0.5 color rgb <0.2,0.2,0.2>]
                   [1.0 color rgb <165/255,145/255 ,134/255>]
                   }
} 

#declare PLANET = sphere{ <0,0,0>, 4.5
        pigment{ T_Julia
               } 
}



object {
  PLANET
  translate <20, 10, -15>
  rotate <0,3,5>
  finish{ambient 0.1 diffuse .6 brilliance .3}
} 