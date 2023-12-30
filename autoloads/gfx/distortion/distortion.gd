extends Control
class_name Distortion

@onready var effect := $Effect
@onready var distortion_mark := $Markers/DistortionMark

var is_playing := false

var distortion_center : Vector2 :
	set(value): effect.material.set_shader_parameter("distortion_center", value)
	get: return effect.material.get_shader_parameter("distortion_center")

var distortion_force : float :
	set(value): effect.material.set_shader_parameter("distortion_force", value)
	get: return effect.material.get_shader_parameter("distortion_force")

var distortion_size : float :
	set(value): effect.material.set_shader_parameter("distortion_size", value)
	get: return effect.material.get_shader_parameter("distortion_size")

var distortion_thickness : float :
	set(value): effect.material.set_shader_parameter("distortion_thickness", value)
	get: return effect.material.get_shader_parameter("distortion_thickness")

static func new():
	var resource := load("distortion.tscn")
	return resource.instantiate()

func _process(_delta):
	if distortion_mark == null or not distortion_mark is Node2D: return
	var uv_position = distortion_mark.get_global_transform_with_canvas().get_origin() / get_viewport_rect().size
	uv_position.y = 1 - uv_position.y
	distortion_center = uv_position

func play(target_position: Vector2, target_size: float, duration := 0.7 , force := 0.1, thickness := .0, backward := false):
	distortion_mark.global_position = target_position
	distortion_force = force if not backward else 0.0
	distortion_size = 0.0 if not backward else target_size
	distortion_thickness = thickness if not backward else 0.0
	is_playing = true
	await create_tween().set_parallel(true) \
		.tween_property(self, "distortion_force", 0.0 if not backward else force, duration) \
		.tween_property(self, "distortion_size", target_size if not backward else 0.0, duration) \
		.tween_property(self, "distortion_thickness", 0.0 if not backward else thickness, duration)
	is_playing = false
