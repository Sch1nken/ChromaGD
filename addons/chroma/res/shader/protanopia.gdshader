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

vec3 protanDeutanFilter(float k1, float k2, float k3, vec3 color) {
    color = clamp(color, 0.0, 1.0);
    vec3 c_lin = rgb2lin(color);

    float r_blind = (float(k1) * c_lin.r + float(k2) * c_lin.g) / 16448.25098;
    float b_blind = (float(k3) * c_lin.r - float(k3) * c_lin.g + 128.498039 * c_lin.b) / 16448.25098;
    r_blind = clamp(r_blind, 0.0, 1.0);
    b_blind = clamp(b_blind, 0.0, 1.0);

    return mix(color, lin2rgb(vec3(r_blind, r_blind, b_blind)), 1.0);
}

void fragment() {
	vec3 color = texture(screen_texture, SCREEN_UV).rgb;
	COLOR.rgb = protanDeutanFilter(14.443137, 114.054902, 0.513725, color);
}