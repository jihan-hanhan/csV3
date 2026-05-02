shader_type canvas_item;
render_mode unshaded;

// 可调参数
uniform float blur_radius : hint_range(1.0, 8.0) = 3.0;
//uniform vec4 glass_tint : hint_color = vec4(1.0, 1.0, 1.0, 0.5);
uniform float brightness : hint_range(0.5, 1.5) = 1.0;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 pixel_size = SCREEN_PIXEL_SIZE;
	vec4 sum = vec4(0.0);
	float samples = 0.0;

	// 方形区域采样（简单盒状模糊）
	for (float x = -blur_radius; x <= blur_radius; x += 1.0) {
		for (float y = -blur_radius; y <= blur_radius; y += 1.0) {
			vec2 offset = vec2(x, y) * pixel_size;
			sum += texture(SCREEN_TEXTURE, uv + offset);
			samples += 1.0;
		}
	}
	sum /= samples;

	// 应用亮度与色调叠加
	sum.rgb *= brightness;
	COLOR = sum * glass_tint;
}
