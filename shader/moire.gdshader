shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float intensity : hint_range(0.0, 1.0) = 0.3;
uniform float transparency : hint_range(0.0, 1.0) = 0.4;

void fragment() {
    vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);
    
	// 摩尔纹，想改变粗细调整SCREEN_UV后面的系数即可，测得1120.0/1198.0最舒服
    float lines_a = sin(SCREEN_UV.x * 1200.0);
    float lines_b = sin(SCREEN_UV.x * 1198.0);
    float moire = abs((lines_a + lines_b) * 0.5);
    
    vec3 final = bg.rgb * (1.0 - moire * intensity);
    
    COLOR = vec4(final, transparency);
}