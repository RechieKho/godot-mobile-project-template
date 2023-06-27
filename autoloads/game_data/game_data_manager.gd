## Handles save and load of the main `GameData`.
## To get the list of `GameData` available, use `GameData.get_data_list()`
## To load the `GameData`, set `GameDataManager.data` to the `GameData`,
## this will setup the saved `Gameplay`.
## To save the `GameData`, call `save`.
extends Node

signal on_data_updated()
signal on_saving()

var data : GameData = null :
	set(value):
		on_data_updated.emit(value)
		data = value
		if data != null: data.restore()

func _ready():
	ResourceSaver.add_resource_format_saver(GameDataFormatSaver.new())
	ResourceLoader.add_resource_format_loader(GameDataFormatLoader.new())

## Save data. It emits `on_saving` in which tells `Gameplay` to update the data.
func save():
	if data == null: return
	on_saving.emit()
	ResourceSaver.save(data)

