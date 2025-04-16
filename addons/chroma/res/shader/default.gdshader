shader_type canvas_item;

uniform sampler2D screen_texture : source_color, hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	COLOR.rgb = texture(screen_texture, SCREEN_UV).rgb;
}