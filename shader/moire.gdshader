shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float intensity : hint_range(0.0, 1.0) = 0.3;
uniform float transparency : hint_range(0.0, 1.0) = 0.5;  // 添加透明度控制

void fragment() {
    vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    float lines_a = sin(SCREEN_UV.x * 300.0);
    float lines_b = sin(SCREEN_UV.x * 298.5);
    float moire = abs((lines_a + lines_b) * 0.5);
    
    vec3 final = bg.rgb * (1.0 - moire * intensity);
    
    // 让输出半透明
    COLOR = vec4(final, transparency);  // 直接指定透明度值
}