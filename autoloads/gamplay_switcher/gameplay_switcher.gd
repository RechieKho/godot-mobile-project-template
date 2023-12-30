extends Node

@export var scene_transition : SceneTransition

func switch(scene_path: String, options := {}):
	var on_ready = options.get("on_ready") 
	options["on_ready"] = func(gameplay):
		assert(gameplay is Gameplay, "Scene '{0}' is not a `Gameplay`.".format([scene_path]))
		if on_ready != null and on_ready is Callable: (on_ready as Callable).call(gameplay)
		gameplay.setup(options)
	
	var on_fade_in = options.get("on_fade_in") 
	options["on_fade_in"] = func():
		if on_fade_in != null and on_fade_in is Callable: (on_fade_in as Callable).call()
	
	scene_transition.transition(scene_path, options)
