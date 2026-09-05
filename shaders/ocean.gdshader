shader_type canvas_item;
render_mode unshaded;
uniform vec4 shallow_color : source_color = vec4(0.15,0.72,0.72,1.0);
uniform vec4 deep_color : source_color = vec4(0.015,0.22,0.35,1.0);
uniform float motion_scale : hint_range(0.0,1.0) = 1.0;
void fragment(){float wave=sin((UV.x*18.0+UV.y*9.0)+TIME*0.7*motion_scale)*0.025;float depth=smoothstep(0.05,0.95,UV.y+wave);vec3 c=mix(shallow_color.rgb,deep_color.rgb,depth);float caustic=pow(max(0.0,sin(UV.x*75.0+TIME)*sin(UV.y*62.0-TIME*.8)),12.0);COLOR=vec4(c+caustic*.1,1.0);}
