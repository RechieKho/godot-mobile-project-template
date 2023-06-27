extends Button
class_name SwitcherButton

@export_file("*.tscn") var target_gameplay

func get_meta_dictionary() -> Dictionary:
	var dictionary := {}
	for metaname in get_meta_list(): dictionary[metaname] = get_meta(metaname)
	return dictionary

func _pressed(): 
	GameplaySwitcher.switch(target_gameplay, get_meta_dictionary())
