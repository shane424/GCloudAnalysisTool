shader_type canvas_item;
uniform float health : hint_range(0.0,1.0)=0.0;
void fragment(){vec4 c=texture(TEXTURE,UV);float l=dot(c.rgb,vec3(.299,.587,.114));vec3 storm=mix(vec3(l),c.rgb,.42)*vec3(.82,.94,.9);vec3 healed=c.rgb*vec3(1.04,1.08,1.02);COLOR=vec4(mix(storm,healed,health),c.a);}
