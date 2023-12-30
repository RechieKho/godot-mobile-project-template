## Handles save and load of the `GameData`.
extends Node

const EXTENSION := ".data"
const DIRNAME := "user://"

signal on_saving(data: GameData)
signal on_delete(data: GameData)

var current_data : GameData = null

func _ready():
	ResourceSaver.add_resource_format_saver(GameDataFormatSaver.new())
	ResourceLoader.add_resource_format_loader(GameDataFormatLoader.new())

## get all `GameData`s.
static func get_data_list() -> Array:
	var data_list := []
	for filename in DirAccess.open(DIRNAME).get_files():
		var path := DIRNAME + filename
		var loaded := load(path)
		if loaded is GameData: data_list.append(loaded)
	return data_list

## Save data. It emits `on_saving` in which tells `Gameplay` to update the data.
func save(data: GameData):
	if data == null: return
	if len(data.resource_path) == 0: 
		data.resource_path = \
			DIRNAME + \
			str(hash(Time.get_time_dict_from_system())) + "_" + \
			str(Time.get_ticks_usec()) + \
			EXTENSION
	on_saving.emit(data)
	ResourceSaver.save(data)

func save_current(): save(current_data)

func delete(data: GameData):
	if data == null: return
	on_delete.emit(data)
	if len(data.resource_path) != 0: DirAccess.remove_absolute(data.resource_path)

func delete_current(): delete(current_data)
