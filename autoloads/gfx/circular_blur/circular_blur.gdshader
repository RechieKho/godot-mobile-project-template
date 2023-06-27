shader_type canvas_item;

uniform vec2 blur_center = vec2(0.5);
uniform float blur_intensity: hint_range(0, 5);
uniform float blur_size: hint_range(0, 1);
uniform float blur_scatter_intensity: hint_range(0, 1);
uniform sampler2D screen_texture: hint_screen_texture;

float get_circle_cover_alpha(
	vec2 center, float size, float scatter_intensity,
	vec2 screen_pixel_size, vec2 screen_uv
){
	vec2 resolution = 1.0 / screen_pixel_size;
	vec2 current_pixel = screen_uv * resolution;
	vec2 circle_target_pixel = vec2(center.x, center.y) * resolution;
	float dist = distance(current_pixel, circle_target_pixel);
	float radius = size * length(resolution) ;
	return  clamp ((dist-radius+1.0) * 1.0/(scatter_intensity * 1000.0), 0.0, 1.0);
}


void fragment(){
	float blur_lod = get_circle_cover_alpha(
		blur_center, blur_size, blur_scatter_intensity, SCREEN_PIXEL_SIZE, SCREEN_UV) * blur_intensity;
	
	COLOR = textureLod(screen_texture, SCREEN_UV, blur_lod);
}
