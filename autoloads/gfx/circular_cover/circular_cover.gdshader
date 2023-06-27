shader_type canvas_item;

uniform vec2 cover_center = vec2(0.5);
uniform float cover_size: hint_range(0, 1);
uniform float cover_scatter_intensity: hint_range(0, 1);
uniform vec4 cover_color: source_color;

float get_cover_cover_alpha(
	vec2 center, float size, float scatter_intensity,
	vec2 screen_pixel_size, vec2 screen_uv
){
	vec2 resolution = 1.0 / screen_pixel_size;
	vec2 current_pixel = screen_uv * resolution;
	vec2 cover_target_pixel = vec2(center.x, center.y) * resolution;
	float dist = distance(current_pixel, cover_target_pixel);
	float radius = size * length(resolution) ;
	return  clamp ((dist-radius+1.0) * 1.0/(scatter_intensity * 1000.0), 0.0, 1.0);
}

void fragment(){
	COLOR = cover_color;
	COLOR.a *= get_cover_cover_alpha(
		cover_center, cover_size, cover_scatter_intensity, SCREEN_PIXEL_SIZE, SCREEN_UV);
}
