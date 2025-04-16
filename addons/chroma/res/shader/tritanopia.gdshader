shader_type canvas_item;

uniform sampler2D screen_texture : source_color, hint_screen_texture, repeat_disable, filter_nearest;

vec3 pow3(vec3 i, float power) {
	vec3 o;
	o.x = pow(i.x, power);
	o.y = pow(i.y, power);
	o.z = pow(i.z, power);
	return o;
}

vec3 rgb2lin(vec3 c) { return (0.992052 * pow3(c, 2.2) + 0.003974) * 128.498039; }
vec3 lin2rgb(vec3 c) { return pow3(c, 0.45454545); }

vec3 tritanFilter(vec3 color) {
    color = clamp(color, 0.0, 1.0);

    float anchor_e0 = 0.05059983 + 0.08585369 + 0.00952420;
    float anchor_e1 = 0.01893033 + 0.08925308 + 0.01370054;
    float anchor_e2 = 0.00292202 + 0.00975732 + 0.07145979;
    float inflection = anchor_e1 / anchor_e0;

    float a1 = -anchor_e2 * 0.007009;
    float b1 = anchor_e2 * 0.0914;
    float c1 = anchor_e0 * 0.007009 - anchor_e1 * 0.0914;
    float a2 = anchor_e1 * 0.3636 - anchor_e2 * 0.2237;
    float b2 = anchor_e2 * 0.1284 - anchor_e0 * 0.3636;
    float c2 = anchor_e0 * 0.2237 - anchor_e1 * 0.1284;

    vec3 c_lin = rgb2lin(color);

    float L = (c_lin.r * 0.05059983 + c_lin.g * 0.08585369 + c_lin.b * 0.00952420) / 128.498039;
    float M = (c_lin.r * 0.01893033 + c_lin.g * 0.08925308 + c_lin.b * 0.01370054) / 128.498039;
    float S = (c_lin.r * 0.00292202 + c_lin.g * 0.00975732 + c_lin.b * 0.07145979) / 128.498039;

    float tmp = M / L;

    if (tmp < inflection) S = -(a1 * L + b1 * M) / c1;
    else S = -(a2 * L + b2 * M) / c2;

    float r = L * 30.830854 - M * 29.832659 + S * 1.610474;
    float g = -L * 6.481468 + M * 17.715578 - S * 2.532642;
    float b = -L * 0.375690 - M * 1.199062 + S * 14.273846;

    return mix(color, lin2rgb(clamp(vec3(r, g, b), 0.0, 1.0)), 1.0);
}

void fragment() {
	vec3 color = texture(screen_texture, SCREEN_UV).rgb;
	COLOR.rgb = tritanFilter(color);

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
