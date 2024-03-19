shader_type canvas_item;

uniform float angle = 45.0;
uniform float fuzz = 30.0;

void fragment() {
	vec2 st = UV - vec2(0.5, 0.0);
	float opacity = smoothstep((angle + fuzz)/360.0, angle/360.0, abs(atan(st.x, st.y)) / 3.1415926); 
	
	opacity *= 1.0 - length(st * vec2(2, 1));
	
	COLOR = vec4(opacity, opacity, opacity, 1); 
}
