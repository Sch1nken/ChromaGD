shader_type canvas_item;

uniform sampler2D screen_texture : source_color, hint_screen_texture, repeat_disable, filter_nearest;

vec3 greyscaleFilter(vec3 color) {
    color = clamp(color, 0.0, 1.0);

    float r_greyscale = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
    float g_greyscale = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
    float b_greyscale = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;

    r_greyscale = clamp(r_greyscale, 0.0, 1.0);
    g_greyscale = clamp(g_greyscale, 0.0, 1.0);
    b_greyscale = clamp(b_greyscale, 0.0, 1.0);
    return vec3(r_greyscale, g_greyscale, b_greyscale);
}

void fragment() {
	vec3 color = texture(screen_texture, SCREEN_UV).rgb;
	COLOR.rgb = greyscaleFilter(color);
}