shader_type canvas_item;

uniform float t = 0.5;
uniform float fuzz = 0.0;
uniform sampler2D between: hint_default_black, repeat_enable, filter_linear_mipmap;
uniform bool invert = false;

void fragment() {
	float value = COLOR.r;
	
	if (invert) {
		value = 1.0 - value;
	}
	
	COLOR.a = 0.0;
	float alpha;
	
	if (fuzz == 0.0) {
		alpha = value < t ? 1.0 : 0.0;
	} else {
		alpha = clamp((t - value) / fuzz, 0.0, 1.0);
	}
	
	COLOR = texture(between, UV);
	COLOR.a = alpha;
}
