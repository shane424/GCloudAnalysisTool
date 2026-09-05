shader_type canvas_item;
uniform float tide_line : hint_range(0.0,1.0)=0.5;
void fragment(){vec4 c=texture(TEXTURE,UV);float wet=smoothstep(tide_line+.04,tide_line-.04,UV.y);c.rgb=mix(c.rgb,c.rgb*vec3(.55,.68,.7),wet);c.rgb+=pow(1.0-abs(UV.y-tide_line),80.0)*.12;COLOR=c;}
