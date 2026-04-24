shader_type canvas_item;

uniform sampler2D sct: hint_screen_texture;

void fragment(){
	// 反色
	vec4 bg_color = texture(sct, SCREEN_UV);
	vec4 inverted_color = vec4(1.0 - bg_color.rgb, bg_color.a);
	COLOR = inverted_color;
}