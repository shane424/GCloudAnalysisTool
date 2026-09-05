shader_type canvas_item;
uniform float wind_strength : hint_range(0.0,1.0)=0.5;
void vertex(){float rooted=1.0-UV.y;VERTEX.x+=sin(TIME*1.4+VERTEX.y*.025)*6.0*rooted*wind_strength;}
