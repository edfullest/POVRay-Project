camera {
    location <-10, 30, 0>
    look_at <0, 0, 0>
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

#declare PLANE = 
  plane {<0,1,0>, 0 
        texture { T_Julia }
}

object { PLANE }