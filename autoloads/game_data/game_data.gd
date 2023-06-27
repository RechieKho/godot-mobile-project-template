## Stores game data. Extend this class to defined data to be stored.
extends Resource
class_name GameData

const EXTENSION := ".data"
const DIRNAME := "user://"

func _init():
	resource_path = \
		DIRNAME + \
		str(hash(Time.get_time_dict_from_system())) + "_" + \
		str(Time.get_ticks_usec()) + \
		EXTENSION

## Delete game data from the filesystem.
func delete():
	DirAccess.remove_absolute(resource_path)

## get all `GameData`s.
static func get_data_list() -> Array:
	var data_list := []
	for filename in DirAccess.open(DIRNAME).get_files():
		var path := DIRNAME + filename
		var loaded := load(path)
		if loaded is GameData: data_list.append(loaded)
	return data_list

func restore():
	pass
