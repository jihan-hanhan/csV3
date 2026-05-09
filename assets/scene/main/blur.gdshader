shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D screen : hint_screen_texture , filter_linear_mipmap;
uniform float blur : hint_range(0.0, 5.0) = 2.5;

void fragment(){
	vec3 result = textureLod(screen,SCREEN_UV,blur).rgb;
	COLOR.rgb = result;
}
