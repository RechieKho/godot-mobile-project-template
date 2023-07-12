extends Timer
class_name CameraShaker

var camera : Camera2D = null
var force := 1.0


func shake(camera: Camera2D, duration := 0.25, force := 1.0):
	randomize()
	self.camera = camera
	self.force = force
	start(duration)

func _ready():
	timeout.connect(func(): 
		if camera != null: camera.offset = Vector2.ZERO
	)

func _process(delta):
	if process_callback == TIMER_PROCESS_IDLE:
		if not is_stopped() and camera != null: 
			camera.offset = Vector2(
				randf_range(-1, 1), randf_range(-1, 1)
			) * force

func _physics_process(delta):
	if process_callback == TIMER_PROCESS_PHYSICS:
		if not is_stopped() and camera != null: 
			camera.offset = Vector2(
				randf_range(-1, 1), randf_range(-1, 1)
			) * force
