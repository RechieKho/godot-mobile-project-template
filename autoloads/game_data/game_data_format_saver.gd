extends ResourceFormatSaver
class_name GameDataFormatSaver

func _get_recognized_extensions(resource: Resource):
	return [GameData.EXTENSION]

func _recognize(resource: Resource):
	return resource is GameData

func _recognize_path(resource, path):
	return resource is GameData and \
		path.begins_with(GameData.DIRNAME) and \
		path.ends_with(GameData.EXTENSION)

func _save(resource, path, _flags):
	var file := FileAccess.open_encrypted_with_pass(
		path, 
		FileAccess.WRITE, 
		path
	)
	if file == null: return ERR_UNAUTHORIZED
	file.store_string(var_to_str(resource))
	return OK
