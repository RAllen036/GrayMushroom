shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float mixer = 1.0;

void fragment() {
	clamp(mixer, 0, 1);
	vec4 pixel_color = texture(screen_texture, SCREEN_UV);
	vec4 gradient_texture = textureLod(TEXTURE, UV, 0.0);
	float brightness = (pixel_color.r + pixel_color.g + pixel_color.b) / 3.0;
	vec4 gray_scale = vec4(brightness, brightness, brightness, gradient_texture.a);
	COLOR.rgb = mix(pixel_color.rgb, gray_scale.rgb, mixer);
}
