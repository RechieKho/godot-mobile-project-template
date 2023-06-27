extends Control
class_name CircularBlur

@onready var effect := $Effect
@onready var blur_mark := $Markers/blurMark

var blur_center : Vector2 :
	set(value): effect.material.set_shader_parameter("blur_center", value)
	get: return effect.material.get_shader_parameter("blur_center")

var blur_scatter_intensity : float :
	set(value): effect.material.set_shader_parameter("blur_scatter_intensity", value)
	get: return effect.material.get_shader_parameter("blur_scatter_intensity")

var blur_size : float :
	set(value): effect.material.set_shader_parameter("blur_size", value)
	get: return effect.material.get_shader_parameter("blur_size")

var blur_intensity : float :
	set(value): effect.material.set_shader_parameter("blur_intensity", value)
	get: return effect.material.get_shader_parameter("blur_intensity")

static func new():
	var resource := load("circular_blur.tscn")
	return resource.instantiate()

func _process(delta):
	if blur_mark == null or not blur_mark is Node2D: return
	var uv_position = blur_mark.get_global_transform_with_canvas().get_origin() / get_viewport_rect().size
	uv_position.y = 1 - uv_position.y
	blur_center = uv_position
