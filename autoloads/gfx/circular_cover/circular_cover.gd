extends Control
class_name CircularCover

@onready var effect := $Effect
@onready var cover_mark := $Markers/CoverMark

var cover_center : Vector2 :
	set(value): effect.material.set_shader_parameter("cover_center", value)
	get: return effect.material.get_shader_parameter("cover_center")

var cover_scatter_intensity : float :
	set(value): effect.material.set_shader_parameter("cover_scatter_intensity", value)
	get: return effect.material.get_shader_parameter("cover_scatter_intensity")

var cover_size : float :
	set(value): effect.material.set_shader_parameter("cover_size", value)
	get: return effect.material.get_shader_parameter("cover_size")

var cover_color : float :
	set(value): effect.material.set_shader_parameter("cover_color", value)
	get: return effect.material.get_shader_parameter("cover_color")

static func new():
	var resource := load("circular_cover.tscn")
	return resource.instantiate()

func _process(delta):
	if cover_mark == null or not cover_mark is Node2D: return
	var uv_position = cover_mark.get_global_transform_with_canvas().get_origin() / get_viewport_rect().size
	uv_position.y = 1 - uv_position.y
	cover_center = uv_position

func cover(cover_scatter_intensity := 0, cover_size := 0, tween_duration := 0.5):
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "cover_size", cover_size, tween_duration) 
	tween.tween_property(self, "cover_scatter_intensity", cover_scatter_intensity, tween_duration)
	await tween.finished

func clear():
	await cover(1, 0)
