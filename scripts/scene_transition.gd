extends Resource
class_name SceneTransition

@export_color_no_alpha var color := Color("#000000")
@export_enum("fade","circle","curtains","diagonal","horizontal","radial","scribbles","squares","vertical") var pattern_enter = "fade"
@export_enum("fade","circle","curtains","diagonal","horizontal","radial","scribbles","squares","vertical") var pattern_exit = "fade"

func transition(scene_path: String, options := {}):
	options.merge({
		"color": color,
		"pattern_enter": pattern_enter,
		"pattern_exit": pattern_exit,
	})
	await SceneManager.change_scene(scene_path, options)
