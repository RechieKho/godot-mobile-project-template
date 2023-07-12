@tool
extends Camera2D
class_name Camcorder

@onready var camera_shaker := $CameraShaker
@onready var limit : ReferenceRect = $ReferenceRects/Limit :
	set(value):
		if limit != null:
			limit.resized.disconnect(sync_limit)
		if value != null:
			value.resized.connect(sync_limit)
		limit = value
		sync_limit()

static func new() -> Camcorder:
	var resource := load("camcorder.tscn")
	return resource.instantiate()

func shake(duration: float, force := 1.0):
	camera_shaker.shake(self, duration, force)

func follow(node: Node, reset_smoothing: bool):
	get_parent().remove_child(self)
	node.add_child(node)
	if reset_smoothing: self.reset_smoothing()

func sync_limit():
	if limit == null: return
	limit_top = limit.position.y
	limit_bottom = limit.position.y + limit.size.y
	limit_left = limit.position.x
	limit_right = limit.position.x + limit.size.x
